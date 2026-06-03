package org.app.Controllers;

import org.app.Services.DepartmentService;
import org.app.models.Department;
import org.app.models.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/departments")
public class DepartmentController {

    private final DepartmentService departmentService;

    public DepartmentController(DepartmentService departmentService) {
        this.departmentService = departmentService;
    }

    // LIST ALL DEPARTMENTS
    @GetMapping
    public String getAllDepartments(HttpSession session, Model model) {

        User user = (User) session.getAttribute("loggedInUser");

        if (user == null) {
            return "redirect:/login";
        }

        model.addAttribute(
                "departments",
                departmentService.getAllDepartments()
        );

        model.addAttribute("department", new Department());

        return "departments";
    }

    // SAVE DEPARTMENT
    @PostMapping("/save")
    public String saveDepartment(@ModelAttribute Department department) {
        departmentService.saveDepartment(department);
        return "redirect:/departments";
    }

    // DELETE DEPARTMENT
    @GetMapping("/delete/{id}")
    public String deleteDepartment(@PathVariable Long id) {
        departmentService.deleteDepartment(id);
        return "redirect:/departments";
    }
}
