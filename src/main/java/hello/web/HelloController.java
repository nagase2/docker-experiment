package hello.web;

import org.springframework.web.bind.annotation.RestController;

import hello.service.HelloService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@RestController
public class HelloController {
    @Autowired
    HelloService helloService;

    @RequestMapping("/")
    public String index() {
        System.out.println("/ has been called");
        return "hello!!";

    }

    @RequestMapping("/hello")
    public String hello() {
        System.out.println("hello has been called");
        return "Greetings from Spring Boot!";

    }

    @RequestMapping(method = RequestMethod.GET, value="/customer")
    public String getCustomer(Integer customerId) {

        return "customer";
    }

}
