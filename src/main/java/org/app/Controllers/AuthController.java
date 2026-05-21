package org.app.Controllers;

import org.app.Services.PatientService;
import org.app.Services.UserService;
import org.app.dto.RegisterDto;
import org.app.models.Patient;
import org.app.models.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import javax.servlet.http.HttpSession;

@Controller
public class AuthController {

    private final UserService userService;
    private final PatientService patientService;

    @Autowired
    public AuthController(
            UserService userService,PatientService patientService){

        this.userService = userService;
        this.patientService=patientService;
    }

    @GetMapping("/patient/dashboard")
    public String patientDashboard(
            HttpSession session,
            Model model){

        // CHECK LOGIN

        User user =
                (User) session.getAttribute(
                        "loggedInUser"
                );

        if(user == null){

            return "redirect:/login";
        }

        // CHECK ROLE

        if(!user.getRole().equals("PATIENT")){

            return "redirect:/login";
        }

        model.addAttribute(
                "user",
                user
        );

        return "patientDashboard";
    }

    @GetMapping("/register")
    public String registerPage(){

        return "register";
    }
    @PostMapping("/register")
    public String register(
            @ModelAttribute RegisterDto registerDto,
            Model model) {

        // BACKEND VALIDATION

        User existingUser =
                userService.findBYEmail(
                        registerDto.getEmail());

        if(existingUser != null){

            model.addAttribute("error",
                    "Email already registered!");

            return "register";
        }

        // SAVE PATIENT

        Patient patient = new Patient();

        patient.setName(registerDto.getName());

        patient.setEmail(registerDto.getEmail());

        patientService.savePatient(patient);

        // SAVE USER

        User user = new User();

        user.setName(registerDto.getName());

        user.setEmail(registerDto.getEmail());

        user.setPassword(registerDto.getPassword());

        user.setRole("PATIENT");

        userService.saveUser(user);

        return "redirect:/login";
    }
}