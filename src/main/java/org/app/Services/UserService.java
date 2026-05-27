package org.app.Services;

import org.app.Repositories.UserRepository;
import org.app.models.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    private final UserRepository userRepository;
    @Autowired
    private BCryptPasswordEncoder passwordEncoder;


    public UserService(
            UserRepository userRepository){

        this.userRepository = userRepository;
    }

    // SAVE USER

    public User saveUser(User user){

        return userRepository.save(user);
    }

    // LOGIN

    public User login(String email, String rawPassword) {

        // find user by email only (not password)
        User user = userRepository.findByEmail(email);

        if (user == null) {
            return null; // email not found
        }

        // compare raw password with stored hash
        boolean match = passwordEncoder.matches(rawPassword, user.getPassword());

        if (match) {
            return user; // login success
        }

        return null; // wrong password
    }
    public User findBYEmail(String email){
       return userRepository.findByEmail(email);
    }
}