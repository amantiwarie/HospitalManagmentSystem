package org.app.Controllers;

import org.app.Services.AppointmentService;
import org.app.Services.DepartmentService;
import org.app.Services.DoctorService;
import org.app.models.Doctor;
import org.app.models.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/doctors")
public class DoctorController {

    private final DoctorService doctorService;
    private final AppointmentService appointmentService;
    private final DepartmentService departmentService;

    public DoctorController(
            DoctorService doctorService,
            AppointmentService appointmentService,
            DepartmentService departmentService) {
        this.doctorService = doctorService;
        this.appointmentService = appointmentService;
        this.departmentService = departmentService;
    }

    @GetMapping
    public String getAllDoctors(HttpSession session, Model model) {
        // FIX: session check — redirect to login if not logged in
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";

        // FIX: role check — only ADMIN can access
        if (!user.getRole().equalsIgnoreCase("ADMIN")) {
            return "redirect:/login";
        }
        model.addAttribute("doctors", doctorService.getAllDoctors());
        model.addAttribute("doctor", new Doctor());
        model.addAttribute("departments", departmentService.getAllDepartments());
        return "doctors-list";
    }

    @PostMapping("/save")
    public String saveDoctor(
            @ModelAttribute Doctor doctor,
            // FIX: changed Integer to Long — matches Department.id type
            @RequestParam(required = false) Long departmentId,
            @RequestParam(value = "imageFile", required = false) MultipartFile imageFile,
            HttpSession session) {

        if (departmentId != null) {
            doctor.setDepartment(departmentService.getDepartmentById(departmentId));
        }

        if (imageFile != null && !imageFile.isEmpty()) {
            try {
                String path = doctorService.saveImage(imageFile, "uploads/doctors/");
                doctor.setImagePath(path);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        doctorService.saveDoctor(doctor);
        session.setAttribute("successMessage", "Doctor added successfully!");
        return "redirect:/doctors";
    }

    @GetMapping("/{id}")
    public String getDoctorById(@PathVariable Long id, Model model) {
        model.addAttribute("doctor", doctorService.getDoctorById(id));
        model.addAttribute("departments", departmentService.getAllDepartments());
        return "doctor-details";
    }

    @PostMapping("/update")
    public String updateDoctor(
            @RequestParam Long id,
            @RequestParam String name,
            @RequestParam String email,
            @RequestParam(required = false) Integer age,
            @RequestParam(required = false) Long departmentId,
            @RequestParam(required = false) String imagePath,
            @RequestParam(value = "imageFile", required = false) MultipartFile imageFile,
            HttpSession session) {

        // FIX: fetch existing — preserves all fields
        Doctor existing = doctorService.getDoctorById(id);
        if (existing == null) return "redirect:/doctors";

        existing.setName(name);
        existing.setEmail(email);
        if (age != null) existing.setAge(age);
        if (departmentId != null) {
            existing.setDepartment(departmentService.getDepartmentById(departmentId));
        }

        if (imageFile != null && !imageFile.isEmpty()) {
            try {
                String path = doctorService.saveImage(imageFile, "uploads/doctors/");
                existing.setImagePath(path);
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else if (imagePath != null && !imagePath.isEmpty()) {
            existing.setImagePath(imagePath);
        }

        doctorService.saveDoctor(existing);
        session.setAttribute("successMessage", "Doctor updated successfully!");
        return "redirect:/doctors/" + id;
    }

    @GetMapping("/delete/{id}")
    public String deleteDoctor(@PathVariable Long id, HttpSession session) {
        doctorService.deleteDoctor(id);
        session.setAttribute("successMessage", "Doctor deleted successfully!");
        return "redirect:/doctors";
    }

    @GetMapping("/dashboard")
    public String doctorDashboard(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";
        model.addAttribute("appointments",
                appointmentService.getAppointmentsByDoctorEmail(user.getEmail()));
        return "DoctorDashboard";
    }
}
