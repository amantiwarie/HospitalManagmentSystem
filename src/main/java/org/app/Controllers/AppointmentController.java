package org.app.Controllers;

import org.app.Services.AppointmentService;
import org.app.models.Appointment;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.LocalTime;

@Controller
@RequestMapping("/appointments")
public class AppointmentController {

    private final AppointmentService appointmentService;

    public AppointmentController(
            AppointmentService appointmentService) {

        this.appointmentService = appointmentService;
    }

    @GetMapping
    public String getAllAppointments(Model model) {

        model.addAttribute(
                "appointments",
                appointmentService.getAllAppointments()
        );

        model.addAttribute(
                "appointment",
                new Appointment()
        );

        return "appointment-list";
    }

    @PostMapping("/save")
    public String saveAppointment(
            @ModelAttribute Appointment appointment) {

        appointmentService.saveAppointment(appointment);

        return "redirect:/appointments";
    }

    @GetMapping("/delete/{id}")
    public String deleteAppointment(
            @PathVariable Long id) {

        appointmentService.cancelAppointment(id);

        return "redirect:/appointments";
    }

    @PostMapping("/update/{id}")
    public String updateAppointment(
            @PathVariable Long id,

            @RequestParam LocalDate appointmentDate,

            @RequestParam LocalTime appointmentTime) {

        appointmentService.changeAppointmentDateOrTime(
                id,
                appointmentDate,
                appointmentTime
        );

        return "redirect:/appointments";
    }
}