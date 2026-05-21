package org.app.Services;

import org.app.Repositories.UserRepository;
import org.app.models.User;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    private final UserRepository userRepository;

    public UserService(
            UserRepository userRepository){

        this.userRepository = userRepository;
    }

    // SAVE USER

    public User saveUser(User user){

        return userRepository.save(user);
    }

    // LOGIN

    public User login(
            String email,
            String password){

        return userRepository
                .findByEmailAndPassword(
                        email,
                        password
                );
    }
    public User findBYEmail(String email){
       return userRepository.findByEmail(email);
    }
}