package org.app.Services;

import org.app.Repositories.PatientRepository;
import org.app.models.Patient;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
public class PatientService {

    private final PatientRepository patientRepository;

    public PatientService(PatientRepository patientRepository) {
        this.patientRepository = patientRepository;
    }

    public Patient savePatient(Patient patient) {
        return patientRepository.save(patient);
    }

    public List<Patient> getAllPatients() {
        return patientRepository.findAll();
    }

    public Patient getPatientById(Long id) {
        Optional<Patient> patient = patientRepository.findById(id);
        return patient.orElse(null);
    }

    public List<Patient> searchByName(String name) {
        return patientRepository.findByNameStartingWith(name);
    }

    public void deletePatient(Long id) {
        patientRepository.deleteById(id);
    }

    public List<Patient> findByName(String name) {
        return patientRepository.findByName(name);
    }

    public List<Patient> getRecentPatients() {
        return patientRepository.findTop5ByOrderByIdDesc();
    }

    public Patient getPatientByEmail(String email) {
        return patientRepository.findByEmail(email);
    }

    // FIX: added age to update, consistent field copying
    public Patient updatePatient(Long id, Patient updatedPatient) {
        Patient existingPatient = patientRepository.findById(id).orElse(null);
        if (existingPatient == null) return null;

        existingPatient.setName(updatedPatient.getName());
        existingPatient.setEmail(updatedPatient.getEmail());
        existingPatient.setAge(updatedPatient.getAge()); // FIX: was missing
        existingPatient.setBloodType(updatedPatient.getBloodType());

        return patientRepository.save(existingPatient);
    }

    public String saveImage(MultipartFile file, String subFolder) throws IOException {
        File dir = new File(subFolder);
        if (!dir.exists()) {
            dir.mkdirs();
        }
        String filename = UUID.randomUUID() + "_" + file.getOriginalFilename();
        Path path = Paths.get(subFolder + filename);
        Files.write(path, file.getBytes());
        return subFolder + filename;
    }
}
