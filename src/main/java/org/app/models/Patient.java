package org.app.models;

import org.app.Enums.BloodType;

import javax.persistence.*;
import java.time.LocalDate;
import java.util.List;


@Entity
public class Patient {
    @Id
    @GeneratedValue(strategy =
            GenerationType.IDENTITY)
    private long id;




    @Column(nullable = false)
    private String name;

    @Column(nullable = false,unique=true)
    private String email;
    private int age;

    @Enumerated(EnumType.STRING)

    private BloodType bloodType;

    private LocalDate registeredAt;

    @OneToMany(
            mappedBy = "patient",
            cascade = CascadeType.ALL,
            fetch = FetchType.LAZY
    )
    private List<Appointment> appointmentList;

    @ManyToMany
    private List<Doctor> doctors;

    @ManyToOne
    private Insurance insurance;



    public Patient(){}

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public BloodType getBloodType() {
        return bloodType;
    }

    public void setBloodType(BloodType bloodType) {
        this.bloodType = bloodType;
    }

    public LocalDate getRegisteredAt() {
        return registeredAt;
    }

    public void setRegisteredAt(LocalDate registeredAt) {
        this.registeredAt = registeredAt;
    }
    public List<Appointment> getAppointmentList() {
        return appointmentList;
    }

    public void setAppointmentList(
            List<Appointment> appointmentList) {

        this.appointmentList = appointmentList;
    }


    public List<Doctor> getDoctors() {
        return doctors;
    }

    public void setDoctors(List<Doctor> doctors) {
        this.doctors = doctors;
    }

    public Insurance getInsurance() {
        return insurance;
    }

    public void setInsurance(Insurance insurance) {
        this.insurance = insurance;
    }
}
