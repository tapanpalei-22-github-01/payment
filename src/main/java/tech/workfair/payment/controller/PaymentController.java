package tech.workfair.payment.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/payment")
public class PaymentController {

    @GetMapping("/process")
    public String processPayment() {
        return "Payment processed successfully!";
    }

    
}
