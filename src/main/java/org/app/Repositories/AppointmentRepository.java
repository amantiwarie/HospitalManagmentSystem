package org.app.Repositories;

import org.app.models.Appointment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AppointmentRepository extends JpaRepository<Appointment,Long> {
    List<Appointment> findByPatient_Email(
            String email);
    List<Appointment> findByDoctor_Email(
            String email);
}


