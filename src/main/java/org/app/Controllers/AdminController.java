package org.app.Controllers;

import org.app.Services.PatientService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminController {

    private final PatientService patientService;

    public AdminController(
            PatientService patientService){

        this.patientService = patientService;
    }

    @GetMapping("/admin/dashboard")
    public String adminDashboard(Model model){

        model.addAttribute(
                "totalPatients",
                patientService.getAllPatients().size()
        );

        model.addAttribute(
                "recentPatients",
                patientService.getRecentPatients()
        );

        return "adminDashboard";
    }
}