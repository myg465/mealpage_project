package dev.localhost.koitt14.account;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dev.localhost.koitt14.util.*;

@Service
public class AuthService {
  @Autowired
  private AuthMapper authMapper;

  @Autowired
  private SmsSender smsSender;

  @Autowired
  private EmailSender emailSender;

  public String sendCode(HashMap<String, String> reqMap) {
    String phone = reqMap.get("phone");
    String email = reqMap.get("email");
    String result = "send_both";
    int key = -1;

    // 이미 인증번호를 보낸 적 있는 휴대폰 번호인가?
    AuthVo authVo = authMapper.selectAuth(phone);

    if (authVo != null) {
      key = authVo.getSeqKey();

      // 인증번호를 보냈던 시각 확인
      Timestamp date = authVo.getPhoneSendDate();
      String sendDate = date.toString().substring(0,10);

      LocalDateTime time = LocalDateTime.now();
      DateTimeFormatter timeFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd");
      String today = time.format(timeFormat);

      if (sendDate.equals(today)) {
        result = "resend_email";
      } else {
        result = "resend_both";
      }
    }

    // SMS 인증번호 전송
    // SMS는 하루에 한번만 전송 가능하도록 제약을 둔다
    int phoneCode = 0;
    if (!result.equals("resend_email")) {
      phoneCode = (int) (Math.random() * 900000) + 100000;
      String sendNumber = "+82" + phone.substring(1,11);
      smsSender.send(sendNumber, "[밀페이지] 홈페이지 하단 입력란에 인증번호 [" + phoneCode + "]를 입력해주세요.");
    }

    // 이메일 인증번호 전송
    int emailCode = (int) (Math.random() * 900000) + 100000;
    try {
      emailSender.send(email, "[밀페이지] 회원가입 이메일 인증", "홈페이지 하단 입력란에 인증번호 [" + emailCode + "]를 입력해주세요.");
    } catch (Exception e) {
      e.printStackTrace();
    }

    // 결과에 따른 DB 저장
    switch (result) {
      case "resend_email":
        authMapper.updateAuthEmail(email, emailCode, key);
        break;
      case "resend_both":
        authMapper.updateAuth(phone, email, phoneCode, emailCode, key);
        break;
      default:
        authMapper.insertAuth(phone, email, phoneCode, emailCode);
    }

    return result;
  }

  public String checkCode(HashMap<String, String> reqMap, HttpServletRequest request) {
    String phone = reqMap.get("phone");
    String email = reqMap.get("email");
    String phoneCode = reqMap.get("phoneCode");
    String emailCode = reqMap.get("emailCode");

    String result = "";
    AuthVo authVo = authMapper.selectAuth(phone);

    if (authVo == null) {
      return "auth_err";
    }

    int authKey = authVo.getSeqKey();
    String authEmail = authVo.getEmail();
    String authPhoneCode = authVo.getPhoneCode();
    String authEmailCode = authVo.getEmailCode();

    if (email.equals(authEmail) && phoneCode.equals(authPhoneCode) && emailCode.equals(authEmailCode)) {
      HttpSession session = request.getSession();
      session.setAttribute("authKey", authKey);
      session.setAttribute("phone", phone);
      session.setAttribute("email", email);

      result = "auth_pass";
    } else {
      result = "auth_fail";
    }

    return result;
  }

  public String sendEmailCode(HashMap<String, String> reqMap) {
    int key = Integer.parseInt(reqMap.get("authKey"));
    String email = reqMap.get("email");
    String result = "pass";

    // 이메일 인증번호 전송
    int emailCode = (int) (Math.random() * 900000) + 100000;

    try {
      emailSender.send(email, "[밀페이지] 회원정보 수정 이메일 인증", "이메일 인증번호 란에 [" + emailCode + "]를 입력해주세요.");
      authMapper.updateAuthEmail(email, emailCode, key);
    } catch (Exception e) {
      e.printStackTrace();
      result = "fail";
    }

    return result;
  }

  public String sendPhoneCode(HashMap<String, String> reqMap, HttpServletRequest request) {
    int key = Integer.parseInt(reqMap.get("authKey"));
    String phone = reqMap.get("phone");

    // 인증번호를 보냈던 시각 확인
    Timestamp date = authMapper.getPhoneSendDate(key);
    String sendDate = date.toString().substring(0,10);

    LocalDateTime time = LocalDateTime.now();
    DateTimeFormatter timeFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    String today = time.format(timeFormat);

    if (sendDate.equals(today)) {
      return "today";
    }
    
    // 휴대폰 인증번호 전송
    int phoneCode = (int) (Math.random() * 900000) + 100000;

    String sendNumber = "+82" + phone.substring(1,11);
    smsSender.send(sendNumber, "[밀페이지] 휴대폰 인증번호 란에 [" + phoneCode + "]를 입력해주세요.");
    authMapper.updateAuthPhone(phone, phoneCode, key);

    return "pass";
  }
}
