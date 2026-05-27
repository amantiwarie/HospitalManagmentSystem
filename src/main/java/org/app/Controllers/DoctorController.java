package org.app.Controllers;

import org.app.Services.AppointmentService;
import org.app.Services.DoctorService;
import org.app.models.Doctor;
import org.app.models.Patient;
import org.app.models.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.Optional;

@Controller
@RequestMapping("/doctors")
public class DoctorController {

    private final DoctorService doctorService;
    private  final AppointmentService appointmentService;

    @Autowired
    public DoctorController(DoctorService doctorService,AppointmentService appointmentService){
        this.doctorService=doctorService;
        this.appointmentService=appointmentService;
    }

    @GetMapping
    public String getAllDoctors(HttpSession session,Model model){
        User user =
                (User) session.getAttribute(
                        "loggedInUser"
                );

        // NOT LOGGED IN

        if(user == null){

            return "redirect:/login";
        }

        model.addAttribute("doctors",doctorService.getAllDoctors());

        model.addAttribute("doctor",new Doctor());
        return "doctors-list";
    }

       @PostMapping("/save")
        public String saveDoctor(@ModelAttribute Doctor doctor){
            doctorService.saveDoctor(doctor);
            return "redirect:/doctors";
    }
    @GetMapping("/delete/{id}")
    public String deleteDoctor(@PathVariable Long id){
        doctorService.deleteDoctor(id);
        return "redirect:/doctors";
    }
    @GetMapping("/{id}")
    public String getDoctorById(
            @PathVariable Long id,
            Model model) {

        Optional<Doctor> patient =
                doctorService.findById(id);

        model.addAttribute("doctor", patient);

        return "doctor-details";
    }

    @GetMapping("/dashboard")
    public String doctorDashboard(
            HttpSession session,
            Model model){

        User user =
                (User) session.getAttribute(
                        "loggedInUser");

        if(user == null){

            return "redirect:/login";
        }

        model.addAttribute(
                "appointments",

                appointmentService
                        .getAppointmentsByDoctorEmail(
                                user.getEmail())
        );

        return "DoctorDashboard";
    }

}
