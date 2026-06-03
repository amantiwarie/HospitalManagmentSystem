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

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public User saveUser(User user) {
        return userRepository.save(user);
    }

    public User login(String email, String rawPassword) {
        User user = userRepository.findByEmail(email);
        if (user == null) return null;
        boolean match = passwordEncoder.matches(rawPassword, user.getPassword());
        return match ? user : null;
    }

    // FIX: renamed findBYEmail → findByEmail (consistent naming)
    public User findByEmail(String email) {
        return userRepository.findByEmail(email);
    }
}
