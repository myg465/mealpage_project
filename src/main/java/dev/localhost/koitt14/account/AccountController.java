package dev.localhost.koitt14.account;

import java.util.HashMap;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class AccountController {
  @Autowired
  private AccountService accountService;

  @Autowired
  private AuthService authService;

  // 로그인
  @GetMapping("/account/login")
  public String getLogin (HttpServletRequest request, Model model, @CookieValue(value="id", required=false) Cookie idCookie) {
    // 이미 로그인되어 있는지 확인한다
    if (accountService.checkLogin(request)) return "redirect:/";
    
    if (idCookie != null) {
      model.addAttribute("id", idCookie.getValue());
    }

    return "account/login";
  }

  // 로그인 처리 (ajax 응답)
  @ResponseBody
  @PostMapping("/account/login")
  public HashMap<String, String> postLogin (@RequestBody HashMap<String, String> reqMap, HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {
    HashMap<String, String> resMap = new HashMap<String, String>();
    model.addAttribute("request", request);
    model.addAttribute("response", response);
    resMap.put("result", accountService.getLogin(reqMap, model));

    return resMap;
  }

  // 비회원 주문조회 (ajax 응답)
  @ResponseBody
  @PostMapping("/account/nonmember")
  public HashMap<String, String> nonmemberLogin (@RequestBody HashMap<String, String> reqMap, HttpServletRequest request, Model model) throws Exception {
    HashMap<String, String> resMap = new HashMap<String, String>();
    model.addAttribute("request", request);
    resMap.put("result", accountService.getLogin(reqMap, model));

    return resMap;
  }

  // 로그아웃
  @GetMapping("/account/logout")
  public String getLogout (HttpServletRequest request) {
    HttpSession session = request.getSession();
    // 로그아웃 후에도 세션의 특정 정보를 이용하기 때문에
    // session.invalidate()를 사용하지 않는다
    session.removeAttribute("accountKey");
    session.removeAttribute("id");
    session.removeAttribute("name");
    session.removeAttribute("authority");
    
    return "account/logout";
  }

  // 아이디/비밀번호 찾기
  @GetMapping("/account/search")
  public String getSearch () {    
    return "account/search";
  }
  
  // 아이디 찾기 (ajax 응답)
  @ResponseBody
  @PostMapping("/account/search/id")
  public HashMap<String, String> searchId (@RequestBody HashMap<String, String> reqMap) {  
    return accountService.getId(reqMap);
  }

  // 비밀번호 찾기 (ajax 응답)
  @ResponseBody
  @PostMapping("/account/search/pw")
  public HashMap<String, String> searchPw (@RequestBody HashMap<String, String> reqMap) {  
    return accountService.getPw(reqMap);
  }

  // 회원가입 - 약관 동의
  @GetMapping("/account/signup")
  public String signupStep1 () {
    return "account/signup_1";
  }

  // 회원가입 - 휴대폰/이메일 인증
  @PostMapping("/account/signup")
  public String signupStep2 () {
    return "account/signup_2";
  }

  // 회원가입 - 인증번호 전송 (ajax 응답)
  @ResponseBody
  @PostMapping("/account/signup/sendcode")
  public HashMap<String, String> sendCode (@RequestBody HashMap<String, String> reqMap) throws Exception {
    HashMap<String, String> resMap = new HashMap<String, String>();
    
    // 이미 등록된 계정의 휴대폰인지 확인한다
    String checkPhoneResult = accountService.checkPhone(reqMap);

    if (!checkPhoneResult.equals("unique")) {
      resMap.put("result", "phone_" + checkPhoneResult);
    } else {
      // 인증번호를 전송한다
      resMap.put("result", authService.sendCode(reqMap));
    }

    return resMap;
  }

  // 회원가입 - 인증번호 확인 (ajax 응답)
  @ResponseBody
  @PostMapping("/account/signup/checkcode")
  public HashMap<String, String> checkCode (@RequestBody HashMap<String, String> reqMap, HttpServletRequest request) throws Exception {
    HashMap<String, String> resMap = new HashMap<String, String>();
    
    // 이미 등록된 계정의 휴대폰인지 확인한다
    String checkPhoneResult = accountService.checkPhone(reqMap);

    if (!checkPhoneResult.equals("unique")) {
      resMap.put("result", "phone_" + checkPhoneResult);
    } else {
      // 인증번호를 확인한다
      resMap.put("result", authService.checkCode(reqMap, request));
    }

    return resMap;
  }

  @GetMapping("/account/signup/detail")
  public String getSignupStep3 (HttpServletRequest request, Model model) {
    model.addAttribute("request", request);
    // 세션 확인 (휴대폰/이메일 인증 결과)
    String uri = accountService.checkAuthSession(model);

    return uri;
  }

  // 회원가입 - id 중복확인 (ajax 응답)
  @ResponseBody
  @PostMapping("/account/signup/checkid")
  public HashMap<String, String> checkId (@RequestBody HashMap<String, String> reqMap) throws Exception {    
    return accountService.checkId(reqMap);
  }

  // 회원가입 - 가입처리
  @PostMapping("/account/signup/detail")
  public String postSignupStep3 (HttpServletRequest request, Model model) {
    // 세션과 폼으로 넘어온 값 비교해야 함 (폼 조작 방지)
    model.addAttribute("request", request);
    accountService.signupAccount(model);

    return "account/signup_4";
  }

  // 회원약관 표시
  @GetMapping("/account/agreement")
  public String getAgreement () {
    return "account/agreement";
  }

  // 마이페이지 - 회원정보 수정 폼
  @GetMapping("/account/modify")
  public String getModify (HttpServletRequest request, Model model) {
    if (!accountService.checkLogin(request)) return "redirect:/account/login";

    model.addAttribute("request", request);
    accountService.getMyInfo(model);
    accountService.selectAccount(model);

    return "mypage/modifyAccount";
  }

  // 마이페이지 - 회원정보 수정 처리
  @ResponseBody
  @PostMapping("/account/modify")
  public HashMap<String, String> postModify (@RequestBody HashMap<String, String> reqMap, HttpServletRequest request) throws Exception {
    return accountService.updateAccount(reqMap, request);
  }

  // 회원정보 수정 - 이메일 인증번호 전송 (ajax 응답)
  @ResponseBody
  @PostMapping("/account/modify/emailcode")
  public HashMap<String, String> emailCode (@RequestBody HashMap<String, String> reqMap) throws Exception {
    HashMap<String, String> resMap = new HashMap<String, String>();
    resMap.put("result", authService.sendEmailCode(reqMap));

    return resMap;
  }

  // 회원정보 수정 - 이메일 인증번호 확인 및 처리
  @ResponseBody
  @PostMapping("/account/modify/email")
  public HashMap<String, String> modifyEmail (@RequestBody HashMap<String, String> reqMap, HttpServletRequest request) throws Exception {
    return accountService.updateAccountEmail(reqMap, request);
  }

  // 회원정보 수정 - 휴대폰 인증번호 전송 (ajax 응답)
  @ResponseBody
  @PostMapping("/account/modify/phonecode")
  public HashMap<String, String> phoneCode (@RequestBody HashMap<String, String> reqMap, HttpServletRequest request) throws Exception {
    HashMap<String, String> resMap = new HashMap<String, String>();
    resMap.put("result", authService.sendPhoneCode(reqMap, request));

    return resMap;
  }

  // 회원정보 수정 - 휴대폰 인증번호 확인 및 처리
  @ResponseBody
  @PostMapping("/account/modify/phone")
  public HashMap<String, String> modifyPhone (@RequestBody HashMap<String, String> reqMap, HttpServletRequest request) throws Exception {
    return accountService.updateAccountPhone(reqMap, request);
  }

  // 회원정보 수정 - 비밀번호 처리
  @ResponseBody
  @PostMapping("/account/modify/password")
  public HashMap<String, String> modifyPassword (@RequestBody HashMap<String, String> reqMap, HttpServletRequest request) throws Exception {
    return accountService.updateAccountPassword(reqMap, request);
  }

  // 마이페이지 - 회원탈퇴 폼
  @GetMapping("/account/quit")
  public String getQuit (HttpServletRequest request, Model model) {
    if (!accountService.checkLogin(request)) return "redirect:/account/login";

    model.addAttribute("request", request);
    accountService.getMyInfo(model);

    return "mypage/quit";
  }

  // 마이페이지 - 회원탈퇴 처리 (ajax 응답)
  @ResponseBody
  @PostMapping("/account/quit")
  public HashMap<String, String> postQuit (@RequestBody HashMap<String, String> reqMap, HttpServletRequest request, Model model) {
    model.addAttribute("request", request);
    return accountService.dropAccount(reqMap, model);
  }
}
