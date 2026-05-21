package org.app.Controllers;

import org.app.Services.UserService;
import org.app.models.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
@Controller
public class LoginController {

    private final UserService userService;

    public LoginController(UserService userService){
        this.userService= userService;
    }

    @GetMapping("/login")
    public String loginPage(){

        return "login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String email,
                        @RequestParam String password,
                        Model model,
                        HttpSession session) {

        // CHECK USER

        User user =
                userService.login(email, password);

        // LOGIN FAILED

        if(user == null){

            model.addAttribute("error",
                    "Invalid email or password!");

            return "login";
        }

        // SAVE SESSION

        session.setAttribute("loggedInUser", user);

        // ROLE BASED LOGIN

        if(user.getRole().equalsIgnoreCase("ADMIN")){

            return "redirect:/admin/dashboard";
        }

        else if(user.getRole().equalsIgnoreCase("PATIENT")){

            return "redirect:/patient/dashboard";
        }

        // DEFAULT

        return "redirect:/";
    }
    @GetMapping("/logout")
    public String logout(HttpSession session){

        // REMOVE SESSION

        session.invalidate();

        // REDIRECT TO LOGIN PAGE

        return "redirect:/login";
    }
}
