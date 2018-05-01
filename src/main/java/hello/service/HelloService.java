package hello.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import hello.entity.Customer;
import hello.repository.CustomerRepository;

@Service
public class HelloService {
	@Autowired
	CustomerRepository customerRepository;
	
	Customer getCustomer(Integer customerId) {
		 return customerRepository.getOne(customerId);
	}


}
