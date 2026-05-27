package org.app.Services;

import org.app.Repositories.DoctorRepository;
import org.app.models.Doctor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class DoctorService {

    private final DoctorRepository doctorRepository;

    public DoctorService(DoctorRepository doctorRepository){
        this.doctorRepository=doctorRepository;
    }

    public List<Doctor> getAllDoctors(){
        return doctorRepository.findAll();
    }
    public Doctor saveDoctor(Doctor doctor){
        return doctorRepository.save(doctor);
    }
    public Optional<Doctor> findById(Long id){
        return doctorRepository.findById(id);
    }
    public void deleteDoctor(Long id){
        doctorRepository.deleteById(id);
    }

    public Doctor updateDoctor(Long id,Doctor newDoctor){
        Doctor existingDoctor =doctorRepository.findById(id).orElse(null);

        if(existingDoctor==null){
            return null;
        }
        existingDoctor.setEmail(newDoctor.getEmail());
        return doctorRepository.save(existingDoctor);
    }
    public Doctor getDoctorById(Long id){

        return doctorRepository
                .findById(id)
                .orElse(null);
    }


}
