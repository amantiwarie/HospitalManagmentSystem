package org.app.Controllers;

import org.app.Services.AppointmentService;
import org.app.Services.PatientService;
import org.app.Services.UserService;

import org.app.dto.RegisterDto;

import org.app.models.Patient;
import org.app.models.User;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
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

    private final AppointmentService appointmentService;
    @Autowired
    private BCryptPasswordEncoder passwordEncoder;
    @Autowired
    public AuthController(
            UserService userService,
            PatientService patientService,
            AppointmentService appointmentService){

        this.userService = userService;

        this.patientService = patientService;

        this.appointmentService = appointmentService;
    }

    // PATIENT DASHBOARD
    @GetMapping("/patient/dashboard")
    public String patientDashboard(
            HttpSession session,
            Model model){

        // CHECK LOGIN

        User user =
                (User) session.getAttribute(
                        "loggedInUser");

        if(user == null){

            return "redirect:/login";
        }

        // ROLE CHECK

        if(!user.getRole()
                .equalsIgnoreCase("PATIENT")){

            return "redirect:/login";
        }

        // FETCH PATIENT USING EMAIL

        Patient patient =
                patientService.getPatientByEmail(
                        user.getEmail());

        // SEND USER

        model.addAttribute(
                "user",
                user);

        // SEND PATIENT

        model.addAttribute(
                "patient",
                patient);

        // SEND APPOINTMENTS

        model.addAttribute(
                "appointments",

                appointmentService
                        .getAppointmentsByPatientEmail(
                                user.getEmail())
        );

        return "patientDashboard";
    }

    // REGISTER PAGE

    @GetMapping("/register")
    public String registerPage(){

        return "register";
    }

    // REGISTER USER

    @PostMapping("/register")
    public String register(
            @ModelAttribute RegisterDto registerDto,
            Model model) {

        // CHECK DUPLICATE EMAIL

        User existingUser =
                userService.findBYEmail(
                        registerDto.getEmail());

        if(existingUser != null){

            model.addAttribute(
                    "error",
                    "Email already registered!"
            );

            return "register";
        }

        // SAVE PATIENT

        Patient patient = new Patient();

        patient.setName(
                registerDto.getName());

        patient.setEmail(
                registerDto.getEmail());

        patientService.savePatient(patient);

        // SAVE USER

        User user = new User();

        user.setName(
                registerDto.getName());

        user.setEmail(
                registerDto.getEmail());

        String encryptedPassword = passwordEncoder.encode(registerDto.getPassword());

        user.setPassword(encryptedPassword);

        user.setRole("PATIENT");

        userService.saveUser(user);

        return "redirect:/login";
    }
}