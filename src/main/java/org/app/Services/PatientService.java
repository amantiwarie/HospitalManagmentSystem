package org.app.Services;

import org.app.Repositories.PatientRepository;
import org.app.models.Patient;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class PatientService {


    private final PatientRepository patientRepository;

    public PatientService(PatientRepository patientRepository){
        this.patientRepository=patientRepository;
    }

    public Patient savePatient(Patient patient){
        return patientRepository.save(patient);
    }
    public List<Patient> getAllPatients(){
        return patientRepository.findAll();
    }

    public Patient getPatientById(Long id){

        Optional<Patient> patient =
                patientRepository.findById(id);

        return patient.orElse(null);
    }

    public void deletePatient(Long id){

        patientRepository.deleteById(id);
    }
    public List<Patient> findByName(String name){
        List<Patient> list = patientRepository.findByName(name);
        return list;
    }
    public List<Patient> getRecentPatients() {

        return patientRepository.findTop5ByOrderByIdDesc();

    }
    public Patient findByEmail(String email){

        return patientRepository.findByEmail(email);
    }

    public Patient updatePatient(Long id, Patient updatedPatient) {

        Patient existingPatient =
                patientRepository.findById(id)
                        .orElse(null);

        if (existingPatient == null) {
            return null;
        }

        existingPatient.setName(updatedPatient.getName());
        existingPatient.setEmail(updatedPatient.getEmail());
        existingPatient.setBloodType(updatedPatient.getBloodType());

        return patientRepository.save(existingPatient);
    }
}
