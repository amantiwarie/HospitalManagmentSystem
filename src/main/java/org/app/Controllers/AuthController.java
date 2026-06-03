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
import org.springframework.web.bind.annotation.*;

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
            AppointmentService appointmentService) {
        this.userService = userService;
        this.patientService = patientService;
        this.appointmentService = appointmentService;
    }

    @GetMapping("/patient/dashboard")
    public String patientDashboard(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";
        if (!user.getRole().equalsIgnoreCase("PATIENT")) return "redirect:/login";

        Patient patient = patientService.getPatientByEmail(user.getEmail());
        model.addAttribute("user", user);
        model.addAttribute("patient", patient);
        model.addAttribute("appointments",
                appointmentService.getAppointmentsByPatientEmail(user.getEmail()));

        return "patientDashboard";
    }

    @GetMapping("/register")
    public String registerPage() {
        return "register";
    }

    @PostMapping("/register")
    public String register(@ModelAttribute RegisterDto registerDto, Model model) {

//        email check kiya ki pahle se register ha ki nhi
        User existingUser = userService.findByEmail(registerDto.getEmail());
        if (existingUser != null) {
            model.addAttribute("error", "Email already registered!");
            return "register";
        }

        Patient patient = new Patient();
        patient.setName(registerDto.getName());
        patient.setEmail(registerDto.getEmail());
        patientService.savePatient(patient);

        User user = new User();
        user.setName(registerDto.getName());
        user.setEmail(registerDto.getEmail());
        user.setPassword(passwordEncoder.encode(registerDto.getPassword()));
        user.setRole("PATIENT");
        userService.saveUser(user);

        return "register-success";
    }
}
