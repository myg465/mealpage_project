package dev.localhost.koitt14.admin;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import dev.localhost.koitt14.account.AccountService;

@Controller
public class AdminController {
  @Autowired
  AccountService accountService;
  
  @Autowired
  AdminService adminService;
  
  @GetMapping("/admin")
  public String adminMain (HttpServletRequest request, Model model) {
    if (!accountService.checkAdmin(request)) return "/admin/unauthorized";

    adminService.adminMain(model);
    
    return "admin/main";
  }  
}
