package com.sachinlakshitha.springboot3jspjdbcmysqlcrud.dto;

import lombok.Data;

import java.util.Date;

@Data
public class CustomerDto {
    private String id;
    private String name;
    private String email;
    private Date createdTime;
}
