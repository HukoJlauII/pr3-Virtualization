package com.example.pr3;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

@RestController
public class Controller {
    @Autowired
    private UserRepo userRepo;

    @PostMapping("/")
    public User createUser(@RequestBody User user) {
        return userRepo.save(user);
    }

    @GetMapping("/")
    public List<User> createUsers() {
        return userRepo.findAll();
    }

    @GetMapping("/image")
    public ResponseEntity<byte[]> getImage() throws IOException {
        InputStream in = getClass()
                .getResourceAsStream("/mirea.png");
        return ResponseEntity.ok()
                .contentType(MediaType.IMAGE_PNG)
                .body(in.readAllBytes());
    }
}
