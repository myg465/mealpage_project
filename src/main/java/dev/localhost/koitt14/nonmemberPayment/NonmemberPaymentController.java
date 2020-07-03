package dev.localhost.koitt14.nonmemberPayment;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;


@Controller
public class NonmemberPaymentController {

	
	@Autowired
	private NonmemberPaymentService nonPaymentService;
	
	//비회원 결제(nonmemberPayment)
	@PostMapping("/nonmember/payment")
	public String nonmemberPayment(HttpServletRequest request, Model model, HttpSession session) {
		
		model.addAttribute("request",request);
		nonPaymentService.insertNonmemberOrder(model, session);
		return "nonmemberPayment/confirmation";
	    
	}//nonmemberPayment
	
}
