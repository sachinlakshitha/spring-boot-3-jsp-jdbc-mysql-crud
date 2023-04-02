package com.sachinlakshitha.springboot3jspjdbcmysqlcrud.controller;

import com.sachinlakshitha.springboot3jspjdbcmysqlcrud.dto.CustomerDto;
import com.sachinlakshitha.springboot3jspjdbcmysqlcrud.service.CustomerService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class CustomerController {
    private CustomerService customerService;
    @Value("${application.name}")
    String applicationName;

    public CustomerController(CustomerService customerService) {
        this.customerService = customerService;
    }

    @GetMapping("/add_customer")
    public ModelAndView viewAddCustomer() {
        ModelAndView mav = new ModelAndView("customer/add_customer");
        mav.addObject("title", applicationName + " | Customer | Add Customer");
        return mav;
    }

    @PostMapping("/add_customer")
    @ResponseBody
    public String saveCustomer(@RequestBody CustomerDto customerDto) {
        return customerService.save(customerDto) ? "201" : "500";
    }

    @GetMapping("/")
    public ModelAndView viewViewCustomer() {
        ModelAndView mav = new ModelAndView("customer/view_customer");
        mav.addObject("title", applicationName + " | Customer | View Customer");
        return mav;
    }

    @GetMapping("/view_customer_dt")
    @ResponseBody
    public Map<String, List<List<String>>> viewCustomerDt() {
        List<CustomerDto> customerDtoList = customerService.findAll();

        List<List<String>> entityList=new ArrayList<>();

        for (CustomerDto customerDto : customerDtoList) {
            List<String> entity=new ArrayList<>();

            entity.add(customerDto.getName());
            entity.add(customerDto.getEmail());
            entity.add(String.valueOf(customerDto.getCreatedTime()));

            String action = "<a href=\"/update_customer/" + customerDto.getId() + "\" title=\"Update\" class=\"btn btn-sm btn-warning\" style=\"margin: 2px;\"><i class=\"fas fa-edit\"></i></a>";
            action += "<a type=\"button\" onclick=\"deleteCustomer('" + customerDto.getId() + "')\" title=\"Delete\" class=\"btn btn-sm btn-danger deleteBtn\" style=\"margin: 2px;\"><i class=\"fas fa-trash\"></i></a>";

            entity.add(action);

            entityList.add(entity);
        }

        Map<String, List<List<String>>> responseMap=new HashMap<>();
        responseMap.put("data", entityList);
        return responseMap;
    }

    @GetMapping("/update_customer/{id}")
    public ModelAndView viewUpdateCustomer(@PathVariable String id) {
        ModelAndView mav = new ModelAndView("customer/update_customer");
        mav.addObject("title", applicationName + " | Customer | Update Customer");
        mav.addObject("customer", customerService.findById(id));
        return mav;
    }

    @PutMapping("/update_customer")
    @ResponseBody
    public String updateCustomer(@RequestBody CustomerDto customerDto) {
        return customerService.update(customerDto) ? "200" : "500";
    }

    @DeleteMapping("/delete_customer/{id}")
    @ResponseBody
    public String deleteCustomer(@PathVariable String id) {
        return customerService.delete(id) ? "200" : "500";
    }
}
