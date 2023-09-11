package com.example.pr3;

import lombok.Data;

import javax.persistence.*;

@Entity
@Table
@Data
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;

    String username;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }
}
