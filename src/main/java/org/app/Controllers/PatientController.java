package org.app.Controllers;

import org.app.Services.PatientService;
import org.app.models.Patient;
import org.app.models.User;
import org.app.Enums.BloodType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/patients")
public class PatientController {

    private final PatientService patientService;

    public PatientController(PatientService patientService) {
        this.patientService = patientService;
    }

    @GetMapping
    public String getAllPatients(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";
        model.addAttribute("patients", patientService.getAllPatients());
        model.addAttribute("patient", new Patient());
        return "patient-list";
    }

    @PostMapping("/save")
    public String savePatient(
            @ModelAttribute Patient patient,
            @RequestParam(value = "imageFile", required = false) MultipartFile imageFile,
            HttpSession session) {

        if (imageFile != null && !imageFile.isEmpty()) {
            try {
                String path = patientService.saveImage(imageFile, "uploads/patients/");
                patient.setImagePath(path);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        patientService.savePatient(patient);
        session.setAttribute("successMessage", "Patient added successfully!");
        return "redirect:/patients";
    }

    @GetMapping("/{id}")
    public String getPatientById(@PathVariable Long id, Model model) {
        model.addAttribute("patient", patientService.getPatientById(id));
        return "patient-details";
    }

    // FIX: fetch existing patient first → preserves registeredAt, avoids 400 error
    @PostMapping("/update")
    public String updatePatient(
            @RequestParam Long id,
            @RequestParam String name,
            @RequestParam String email,
            @RequestParam(required = false) Integer age,
            @RequestParam(required = false) String bloodType,
            @RequestParam(required = false) String imagePath,
            @RequestParam(value = "imageFile", required = false) MultipartFile imageFile,
            HttpSession session) {

        // fetch existing — preserves registeredAt and all other fields
        Patient existing = patientService.getPatientById(id);
        if (existing == null) return "redirect:/patients";

        existing.setName(name);
        existing.setEmail(email);
        if (age != null) existing.setAge(age);
        if (bloodType != null && !bloodType.isEmpty()) {
            existing.setBloodType(BloodType.valueOf(bloodType));
        }

        // handle image
        if (imageFile != null && !imageFile.isEmpty()) {
            try {
                String path = patientService.saveImage(imageFile, "uploads/patients/");
                existing.setImagePath(path);
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else if (imagePath != null && !imagePath.isEmpty()) {
            existing.setImagePath(imagePath); // keep old image
        }

        patientService.savePatient(existing);
        session.setAttribute("successMessage", "Patient updated successfully!");
        return "redirect:/patients/" + id;
    }

    // FIX: added HttpSession for success message
    @GetMapping("/delete/{id}")
    public String deletePatient(@PathVariable Long id, HttpSession session) {
        patientService.deletePatient(id);
        session.setAttribute("successMessage", "Patient deleted successfully!");
        return "redirect:/patients";
    }

    @GetMapping("/search")
    public String searchByName(@RequestParam String name, Model model) {
        model.addAttribute("patients", patientService.searchByName(name));
        model.addAttribute("searchTerm", name);
        return "patient-list";
    }
}
