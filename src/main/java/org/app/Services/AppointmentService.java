package org.app.Services;

import org.app.Repositories.AppointmentRepository;
import org.app.models.Appointment;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

@Service
public class AppointmentService {

    private final AppointmentRepository appointmentRepository;

    public AppointmentService(
            AppointmentRepository appointmentRepository) {

        this.appointmentRepository = appointmentRepository;
    }

    public List<Appointment> getAllAppointments() {

        return appointmentRepository.findAll();
    }
    @Transactional
    public List<Appointment> getAppointmentsByPatientEmail(
            String email){

        return appointmentRepository
                .findByPatient_Email(email);
    }

    @Transactional
    public List<Appointment> getAppointmentsByDoctorEmail(
            String email){

        return appointmentRepository
                .findByDoctor_Email(email);
    }
@Transactional
    public Appointment saveAppointment(
            Appointment appointment) {

        return appointmentRepository.save(appointment);
    }
@Transactional
    public void cancelAppointment(Long id) {

        appointmentRepository.deleteById(id);
    }@Transactional
    public Appointment changeAppointmentDateOrTime(
            Long id,
            LocalDate newDate,
            LocalTime newTime) {

        Appointment appointment =
                appointmentRepository.findById(id)
                        .orElseThrow(() ->
                                new RuntimeException(
                                        "Appointment not found"));

        appointment.setAppointmentDate(newDate);

        appointment.setAppointmentTime(newTime);

        return appointmentRepository.save(appointment);
    }
}