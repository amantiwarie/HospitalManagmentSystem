package org.app.Controllers;

import org.app.Services.PatientService;
import org.app.models.Patient;
import org.app.models.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/patients")
public class PatientController {

    private final PatientService patientService;

    public PatientController(PatientService patientService)
    {
        this.patientService = patientService;
    }


    @GetMapping
    public String getAllPatients(HttpSession session ,Model model) {


        User user =
                (User) session.getAttribute(
                        "loggedInUser"
                );

        // NOT LOGGED IN

        if(user == null){

            return "redirect:/login";
        }

        model.addAttribute(
                "patients",
                patientService.getAllPatients()
        );

        model.addAttribute(
                "patient",
                new Patient()
        );

        return "patient-list";
    }

    // SAVE PATIENT
    @PostMapping("/save")
    public String savePatient(
            @ModelAttribute Patient patient) {

        patientService.savePatient(patient);

        return "redirect:/patients";
    }


    // GET PATIENT BY ID
    @GetMapping("/{id}")
    public String getPatientById(
            @PathVariable Long id,
            Model model) {

        Patient patient =
                patientService.getPatientById(id);

        model.addAttribute("patient", patient);

        return "patient-details";
    }
    @PostMapping("/update")
    public String updatePatient(
            @ModelAttribute Patient patient){

        patientService.savePatient(patient);

        return "redirect:/patients/" + patient.getId();
    }

    // DELETE PATIENT
    @GetMapping("/delete/{id}")
    public String deletePatient(
            @PathVariable Long id) {

        patientService.deletePatient(id);

        return "redirect:/patients";
    }

    // SEARCH BY NAME
    @GetMapping("/search")
    public String findByName(
            @RequestParam String name,
            Model model) {

        model.addAttribute(
                "patients",
                patientService.findByName(name)
        );

        return "patient-list";
    }
}