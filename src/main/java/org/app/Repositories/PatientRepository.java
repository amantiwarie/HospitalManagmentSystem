package org.app.Repositories;

import org.app.Enums.BloodType;
import org.app.models.Patient;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PatientRepository extends JpaRepository<Patient,Long> {

    List<Patient> findByName(String name);

    Patient findByEmail(String email);

    List<Patient> findByBloodType(BloodType bloodType);
    List<Patient> findTop5ByOrderByIdDesc();

    @Query("SELECT p FROM Patient p WHERE LOWER(p.name) LIKE LOWER(CONCAT(:name, '%'))")
    List<Patient> findByNameStartingWith(@Param("name") String name);




}
