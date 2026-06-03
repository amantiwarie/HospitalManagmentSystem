package org.app.Controllers;

import org.app.Services.AppointmentService;
import org.app.Services.DoctorService;
import org.app.Services.PatientService;
import org.app.models.Appointment;
import org.app.models.Doctor;
import org.app.models.Patient;
import org.app.models.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.LocalTime;

@Controller
@RequestMapping("/appointments")
public class AppointmentController {

    private final AppointmentService appointmentService;
    private final PatientService patientService;
    private final DoctorService doctorService;

    @Autowired
    public AppointmentController(
            AppointmentService appointmentService,
            PatientService patientService,
            DoctorService doctorService) {
        this.appointmentService = appointmentService;
        this.patientService = patientService;
        this.doctorService = doctorService;
    }

    @GetMapping("/book")
    public String bookAppointmentPage(HttpSession session, Model model) {
        // FIX: session check on book page too
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";
        model.addAttribute("doctors", doctorService.getAllDoctors());
        return "BookAppointment";
    }

    @PostMapping("/save")
    public String saveAppointment(
            @RequestParam String appointmentDate,
            @RequestParam String appointmentTime,
            @RequestParam String reason,
            @RequestParam Long doctorId,
            HttpSession session) {

        User loggedInUser = (User) session.getAttribute("loggedInUser");
        if (loggedInUser == null) return "redirect:/login";

        Patient patient = patientService.getPatientByEmail(loggedInUser.getEmail());
        Doctor doctor = doctorService.getDoctorById(doctorId);

        if (patient == null || doctor == null) {
            return "redirect:/appointments/book";
        }

        Appointment appointment = new Appointment();
        appointment.setAppointmentDate(LocalDate.parse(appointmentDate));
        appointment.setAppointmentTime(LocalTime.parse(appointmentTime));
        appointment.setReason(reason);
        appointment.setPatient(patient);
        appointment.setDoctor(doctor);

        appointmentService.saveAppointment(appointment);

        // FIX: added success message
        session.setAttribute("successMessage", "Appointment booked successfully!");
        return "redirect:/appointments/my";
    }

    @GetMapping("/my")
    public String myAppointments(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null) return "redirect:/login";
        model.addAttribute("appointments",
                appointmentService.getAppointmentsByPatientEmail(user.getEmail()));
        return "MyAppointments";
    }

    @GetMapping("/delete/{id}")
    public String deleteAppointment(@PathVariable Long id, HttpSession session) {
        appointmentService.cancelAppointment(id);
        // FIX: added success message
        session.setAttribute("successMessage", "Appointment cancelled successfully!");
        return "redirect:/appointments/my";
    }
}
