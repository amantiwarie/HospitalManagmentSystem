package org.app.Services;

import org.app.Repositories.DoctorRepository;
import org.app.models.Doctor;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

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
    public Doctor updateDoctor(Long id, Doctor newDoctor) {
        Doctor existing = doctorRepository.findById(id).orElse(null);
        if (existing == null) return null;
        existing.setName(newDoctor.getName());
        existing.setEmail(newDoctor.getEmail());
        existing.setAge(newDoctor.getAge());
        existing.setDepartment(newDoctor.getDepartment());
        return doctorRepository.save(existing);
    }

    // SAVE IMAGE to disk, returns path stored in DB
    public String saveImage(MultipartFile file, String subFolder) throws Exception {
        File dir = new File(subFolder);
        if (!dir.exists()) {
            dir.mkdirs(); // auto-create folder
        }
        String filename = UUID.randomUUID() + "_" + file.getOriginalFilename();
        Path path = Paths.get(subFolder + filename);
        Files.write(path, file.getBytes());
        return subFolder + filename;
    }
    public Doctor getDoctorById(Long id){

        return doctorRepository
                .findById(id)
                .orElse(null);
    }


}
