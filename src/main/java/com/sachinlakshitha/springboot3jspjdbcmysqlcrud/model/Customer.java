package com.sachinlakshitha.springboot3jspjdbcmysqlcrud.model;

import lombok.Data;

import java.util.Date;

@Data
public class Customer {
    private String id;
    private String name;
    private String email;
    private Date createdTime;
}
