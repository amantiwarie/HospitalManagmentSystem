package org.app.Controllers;

import org.app.Services.AppointmentService;
import org.app.Services.DepartmentService;
import org.app.Services.DoctorService;
import org.app.Services.PatientService;
import org.app.models.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;

@Controller
public class AdminController {

    private final PatientService patientService;
    private final DoctorService doctorService;
    private final AppointmentService appointmentService;
    private final DepartmentService departmentService;

    public AdminController(
            PatientService patientService,
            DoctorService doctorService,
            AppointmentService appointmentService,
            DepartmentService departmentService) {
        this.patientService = patientService;
        this.doctorService = doctorService;
        this.appointmentService = appointmentService;
        this.departmentService = departmentService;
    }

    @GetMapping("/admin/dashboard")
    public String adminDashboard(HttpSession session, Model model) {

        // FIX: session check — redirect to login if not logged in
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";

        // FIX: role check — only ADMIN can access
        if (!user.getRole().equalsIgnoreCase("ADMIN")) {
            return "redirect:/login";
        }

        model.addAttribute("totalPatients", patientService.getAllPatients().size());
        model.addAttribute("recentPatients", patientService.getRecentPatients());

        model.addAttribute("totalDoctors", doctorService.getAllDoctors().size());
        model.addAttribute("recentDoctors", doctorService.getAllDoctors());

        model.addAttribute("totalAppointments", appointmentService.getAllAppointments().size());
        model.addAttribute("recentAppointments", appointmentService.getAllAppointments());

        model.addAttribute("totalDepartments", departmentService.getDepartmentCount());

        return "adminDashboard";
    }
}
