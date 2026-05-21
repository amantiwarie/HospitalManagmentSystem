package org.app.models;
import  org.app.models.Patient;

import javax.persistence.*;
import java.time.LocalDate;
import java.util.List;


@Entity
public class Insurance {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column(nullable = false)
    private LocalDate issueDate;

    @Column(nullable = false)
    private LocalDate expiryDate;

     private String CompanyName;

     @OneToMany
     private List<Patient> patients;

     public Insurance(){
     }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public LocalDate getIssueDate() {
        return issueDate;
    }

    public void setIssueDate(LocalDate issueDate) {
        this.issueDate = issueDate;
    }

    public LocalDate getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(LocalDate expiryDate) {
        this.expiryDate = expiryDate;
    }

    public String getCompanyName() {
        return CompanyName;
    }

    public void setCompanyName(String companyName) {
        CompanyName = companyName;
    }

    public List<Patient> getPatients() {
        return patients;
    }

    public void setPateints(List<Patient> patients) {
        this.patients = patients;
    }
}



