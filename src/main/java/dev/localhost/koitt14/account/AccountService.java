package dev.localhost.koitt14.account;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import dev.localhost.koitt14.coupon.CouponMapper;
import dev.localhost.koitt14.order.OrderMapper;
import dev.localhost.koitt14.point.PointMapper;
import dev.localhost.koitt14.util.EmailSender;

@Service
public class AccountService {
  @Autowired
  private AccountMapper accountMapper;

  @Autowired
  private AuthMapper authMapper;

  @Autowired
  private CouponMapper couponMapper;

  @Autowired
  private OrderMapper orderMapper;

  @Autowired
  private PointMapper pointMapper;

  @Autowired
  private WithdrawalMapper withdrawalMapper;

  @Autowired
  private EmailSender emailSender;

  // 회원목록 - 페이지 당 게시물 출력 수 (최소 2 이상)
  private int rowsPerPage = 10;
  // 회원목록 - 게시판 하단에 표시되는 이동 가능 페이지 수
  private int pageSet = 5;

  // 로그인 여부 확인 메소드
  public boolean checkLogin(HttpServletRequest request) {
    HttpSession session = request.getSession();
    Object accountKey = session.getAttribute("accountKey");
    boolean result = false;

    if (accountKey != null) result = true;

    return result;
  }

  // 관리자 권한 확인 메소드
  public boolean checkAdmin(HttpServletRequest request) {
    HttpSession session = request.getSession();
    String authority = (String) session.getAttribute("authority");
    boolean result = false;

    if (authority != null && authority.equals("admin")) result = true;

    return result;
  }

  // 로그인 처리 메소드
  public String getLogin(HashMap<String, String> reqMap, Model model) {
    String id = reqMap.get("id");
    String password = reqMap.get("password");
    String result = "";

    AccountVo accountVo = accountMapper.selectAccountById(id);

    if (accountVo == null || !password.equals(accountVo.getPassword())) {
      result = "fail";
    } else {
      HttpServletRequest request = (HttpServletRequest) model.asMap().get("request");
      HttpSession session = request.getSession();
      session.setAttribute("accountKey", accountVo.getSeqKey());
      session.setAttribute("id", id);
      session.setAttribute("name", accountVo.getName());
      session.setAttribute("authority", accountVo.getAuthority());

      result = "pass";

      // 로그인 성공 시 '아이디 저장'이 체크되어 있으면 아이디 저장
      String idsave = reqMap.get("idsave");

      HttpServletResponse response = (HttpServletResponse) model.asMap().get("response");

      if (idsave.equals("true")) {
        Cookie cookie = new Cookie("id", id);
        cookie.setMaxAge(60 * 60 * 24 * 365);
        response.addCookie(cookie);
      } else {
        Cookie cookie = new Cookie("id", null);
        cookie.setMaxAge(0);
        response.addCookie(cookie);
      }
    }

    return result;
  }

  // 아이디 찾기 메소드
  public HashMap<String, String> getId(HashMap<String, String> reqMap) {
    HashMap<String, String> resMap = new HashMap<String, String>();

    String name = reqMap.get("name");
    String email = reqMap.get("email");
    String id = accountMapper.getId(name, email);

    if (id == null) {
      resMap.put("result", "fail");
    } else {
      resMap.put("result", "pass");

      try {
        emailSender.send(email, "[밀페이지] " + name + "님의 계정 아이디를 알려드립니다", name + "님의 아이디는 " + id + " 입니다.");
      } catch (Exception e) {
        e.printStackTrace();
      }
    }

    return resMap;
  }

  // 비밀번호 찾기 메소드
  public HashMap<String, String> getPw(HashMap<String, String> reqMap) {
    HashMap<String, String> resMap = new HashMap<String, String>();

    String id = reqMap.get("id");
    String email = reqMap.get("email");
    String pw = accountMapper.getPw(id, email);

    if (pw == null) {
      resMap.put("result", "fail");
    } else {
      resMap.put("result", "pass");

      int tempPw = (int) (Math.random() * 90000000) + 10000000;
      accountMapper.updateAccountPwById(tempPw, id);

      try {
        emailSender.send(email, "[밀페이지] 요청하신 계정에 임시 비밀번호가 발급되었습니다.", "발급된 임시 비밀번호는 " + tempPw + " 입니다.<br>임시 비밀번호로 로그인 후, [마이페이지 > 회원정보 수정]에서 비밀번호를 변경해주세요.<br><br><a href='https://meal.page.surf'>밀페이지 바로가기</a>");
      } catch (Exception e) {
        e.printStackTrace();
      }
    }

    return resMap;
  }

  // 이미 등록된 계정의 휴대폰 번호인지 체크하는 메소드
  public String checkPhone(HashMap<String, String> reqMap) {
    String phone = reqMap.get("phone");
    String result = accountMapper.checkPhone(phone);

    if (result == null) {
      result = "unique";
    } else {
      result = "duplicated";
    }

    return result;
  }

  // 정상적으로 휴대폰/이메일 인증을 거쳤는지 세션을 확인하는 메소드
  public String checkAuthSession(Model model) {
    HttpServletRequest request = (HttpServletRequest) model.asMap().get("request");
    HttpSession session = request.getSession();
    String phone = (String) session.getAttribute("phone");

    if (phone == null) {
      return "redirect:/account/signup";
    }

    String email = (String) session.getAttribute("email");

    model.addAttribute("phone", phone);
    model.addAttribute("email", email);

    return "account/signup_3";
  }

  // 이미 등록된 아이디인지 체크하는 메소드
  public HashMap<String, String> checkId(HashMap<String, String> reqMap) {
    HashMap<String, String> resMap = new HashMap<String, String>();

    String id = reqMap.get("id");
    String result = accountMapper.checkId(id);

    if (result == null) {
      result = "unique";
    } else {
      result = "duplicated";
    }

    resMap.put("result", result);

    return resMap;
  }
  
  // 회원 가입처리 메소드
  public void signupAccount(Model model) {
    HttpServletRequest request = (HttpServletRequest) model.asMap().get("request");
    HttpSession session = request.getSession();
    String email = (String) session.getAttribute("email");
    String phone = (String) session.getAttribute("phone");
    Object authKey = session.getAttribute("authKey");
    
    String name = request.getParameter("name");
    String id = request.getParameter("id");
    String password = request.getParameter("password");
    String emailReception = request.getParameter("receive");
    String addressZipcode = request.getParameter("zipcode");
    String addressNew = request.getParameter("roadAddress");
    String addressOld = request.getParameter("jibunAddress");
    String addressDetail = request.getParameter("detailAddress");
    String addressExtra = request.getParameter("extraAddress");

    accountMapper.insertAccount(id, password, name, email, emailReception, phone, addressZipcode, addressNew, addressOld, addressDetail, addressExtra, authKey);

    try {
      emailSender.send(email, "[밀페이지] 회원가입 축하 발송", name + "님, 밀페이지에 가입해주셔서 감사드립니다.<br><br>밀페이지에서는 고객님께 보다 나은 서비스를 제공하기 위해 항상 노력하고 있습니다.<br>앞으로 많은 관심 부탁드립니다.<br><br><a href='https://meal.page.surf'>밀페이지 바로가기</a>");
    } catch (Exception e) {
      e.printStackTrace();
    }

    Object accountKey = accountMapper.getKey(id);

    // 테스트용 쿠폰 및 포인트 발급
    couponMapper.insertPriceCoupon("가입축하 3000원 할인 쿠폰", 10000, 3000, "2020-06-01", "2021-06-01", accountKey);
    couponMapper.insertPercentCoupon("가입축하 10% 할인 쿠폰", 100, 10, "2020-06-01", "2021-06-01", accountKey);
    couponMapper.insertPercentCoupon("가입축하 20% 할인 쿠폰", 1000000, 20, "2020-06-01", "2021-06-01", accountKey);
    pointMapper.insertAddPoint("가입축하 포인트 적립", 1000000, accountKey);
    accountMapper.updatePoint(1000000, accountKey);

    // 회원가입 과정에 사용된 session 클리어
    session.invalidate();
  }

  // 회원정보 가져오는 메소드
  public void selectAccount(Model model) {
    HttpServletRequest request = (HttpServletRequest) model.asMap().get("request");
    HttpSession session = request.getSession();
    Object accountKey = session.getAttribute("accountKey");

    AccountVo accountVo = accountMapper.selectAccount(accountKey);
    model.addAttribute("accountVo", accountVo);
  }

  // 회원정보 업데이트 메소드
  public HashMap<String, String> updateAccount(HashMap<String, String> reqMap, HttpServletRequest request) {
    HashMap<String, String> resMap = new HashMap<String, String>();

    HttpSession session = request.getSession();
    Object key = session.getAttribute("accountKey");
    
    String name = reqMap.get("name");
    String addressZipcode = reqMap.get("addressZipcode");
    String addressNew = reqMap.get("addressNew");
    String addressOld = reqMap.get("addressOld");
    String addressDetail = reqMap.get("addressDetail");
    String addressExtra = reqMap.get("addressExtra");
    String emailReception = reqMap.get("emailReception");

    accountMapper.updateAccount(name, emailReception, addressZipcode, addressNew, addressOld, addressDetail, addressExtra, key);

    resMap.put("result", "pass");
    return resMap;
  }

  // 회원정보 업데이트 메소드 - 이메일
  public HashMap<String, String> updateAccountEmail (HashMap<String, String> reqMap, HttpServletRequest request) {
    HashMap<String, String> resMap = new HashMap<String, String>();

    HttpSession session = request.getSession();
    Object key = session.getAttribute("accountKey");
    
    String email = reqMap.get("email");
    String emailCode = reqMap.get("emailCode");

    String authEmailCode = authMapper.getEmailCode(email);

    if (emailCode.equals(authEmailCode)) {
      accountMapper.updateAccountEmail(email, key);
      resMap.put("result", "pass");
    } else {
      resMap.put("result", "fail");
    }

    return resMap;
  }

  // 회원정보 업데이트 메소드 - 휴대폰
  public HashMap<String, String> updateAccountPhone (HashMap<String, String> reqMap, HttpServletRequest request) {
    HashMap<String, String> resMap = new HashMap<String, String>();

    HttpSession session = request.getSession();
    Object key = session.getAttribute("accountKey");

    String phone = reqMap.get("phone");
    String phoneCode = reqMap.get("phoneCode");

    String authPhoneCode = authMapper.getPhoneCode(phone);

    if (phoneCode.equals(authPhoneCode)) {
      accountMapper.updateAccountPhone(phone, key);
      resMap.put("result", "pass");
    } else {
      resMap.put("result", "fail");
    }

    return resMap;
  }

  // 회원정보 업데이트 메소드 - 비밀번호
  public HashMap<String, String> updateAccountPassword (HashMap<String, String> reqMap, HttpServletRequest request) {
    HashMap<String, String> resMap = new HashMap<String, String>();

    HttpSession session = request.getSession();
    Object key = session.getAttribute("accountKey");

    String currentPw = reqMap.get("currentPw");
    String newPw = reqMap.get("newPw");

    String password = accountMapper.getPwByKey(key);

    if (currentPw.equals(password)) {
      accountMapper.updateAccountPw(newPw, key);
      resMap.put("result", "pass");
    } else {
      resMap.put("result", "fail");
    }

    return resMap;
  }
  
  // 회원정보 업데이트 메소드 - 이름, 주소
  public HashMap<String, String> updateDestination(HashMap<String, String> reqMap, HttpServletRequest request) {
    HashMap<String, String> resMap = new HashMap<String, String>();

    HttpSession session = request.getSession();
    Object key = session.getAttribute("accountKey");
    
    String name = reqMap.get("name");
    String addressZipcode = reqMap.get("addressZipcode");
    String addressNew = reqMap.get("addressNew");
    String addressOld = reqMap.get("addressOld");
    String addressDetail = reqMap.get("addressDetail");
    String addressExtra = reqMap.get("addressExtra");

    accountMapper.updateDestination(name, addressZipcode, addressNew, addressOld, addressDetail, addressExtra, key);

    resMap.put("result", "pass");
    return resMap;
  }

  // 회원 탈퇴 메소드
  public HashMap<String, String> dropAccount (HashMap<String, String> reqMap, Model model) {
    HashMap<String, String> resMap = new HashMap<String, String>();

    HttpServletRequest request = (HttpServletRequest) model.asMap().get("request");
    HttpSession session = request.getSession();
    Object accountKey = session.getAttribute("accountKey");
    String id = (String) session.getAttribute("id");
    String pw = accountMapper.getPwByKey(accountKey);

    String inputId = reqMap.get("id");
    String inputPw = reqMap.get("password");
    String quitReason = reqMap.get("quitReason");
    String quitReasonInput = reqMap.get("quitReasonInput");

    // 아이디 확인    
    if (id == null || !id.equals(inputId)) {
      resMap.put("result", "fail");
      return resMap;
    }

    // 비밀번호 확인
    if (pw == null || !inputPw.equals(pw)) {
      resMap.put("result", "fail");
      return resMap;
    }

    // 탈퇴 사유를 직접 입력받은 경우
    if (quitReason.equals("input")) quitReason = quitReasonInput;

    session.invalidate();
    withdrawalMapper.insertWithdrawal(accountKey, id, quitReason);
    accountMapper.deleteAccountById(id);

    resMap.put("result", "pass");
    return resMap;
  }

  // 회원 보유 포인트를 가져오는 메소드
  public int getPoint(Model model) {
    HttpServletRequest request = (HttpServletRequest) model.asMap().get("request");
    HttpSession session = request.getSession();
    Object accountKey = session.getAttribute("accountKey");

    return accountMapper.getPoint(accountKey);
  }

  // 회원 정보 업데이트 메소드 - 포인트
  public void updatePoint(int point, Model model) {
    HttpServletRequest request = (HttpServletRequest) model.asMap().get("request");
    HttpSession session = request.getSession();
    Object accountKey = session.getAttribute("accountKey");

    accountMapper.updatePoint(point, accountKey);
  }

  // MyInfo 영역에 출력할 내용을 가져오는 메소드 
  public void getMyInfo(Model model) {
    HttpServletRequest request = (HttpServletRequest) model.asMap().get("request");
    HttpSession session = request.getSession();
    Object accountKey = session.getAttribute("accountKey");

    LocalDateTime time = LocalDateTime.now();
    DateTimeFormatter timeFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    String today = time.format(timeFormat);    

    model.addAttribute("nameInfo", session.getAttribute("name"));
    model.addAttribute("couponInfo", couponMapper.getCouponCount(accountKey, today));
    model.addAttribute("pointInfo", accountMapper.getPoint(accountKey));
    model.addAttribute("orderInfo", orderMapper.getOngoingOrderCount(accountKey));
  }

  /* 관리자 페이지용 메소드 시작*/
  // 회원 보유 포인트를 가져오는 메소드
  public int getPointByAdmin(int accountKey) {
    return accountMapper.getPoint(accountKey);
  }

  // 회원 정보 업데이트 메소드 - 포인트
  public void updatePointByAdmin(int point, int accountKey) {
    accountMapper.updatePoint(point, accountKey);
  }

    // 회원 목록 메소드
  public void getList(int page, Model model) {
    int offset = (page - 1) * rowsPerPage;
    int endPage = (int) Math.ceil((double) page / pageSet) * pageSet;
    int startPage = endPage - pageSet + 1;
    int count = accountMapper.getCount();
    int pages = (int) Math.ceil((double) count / rowsPerPage);

    if (endPage > pages) endPage = pages;

    model.addAttribute("accountList", accountMapper.getList(offset, rowsPerPage));
    model.addAttribute("page", page);
    model.addAttribute("pages", pages);
    model.addAttribute("startPage", startPage);
    model.addAttribute("endPage", endPage);
  }  

  // 회원 삭제 메소드
  public int dropAccountByAdmin (Object key, String id, Model model) {
    // 현재 진행 중인 회원주문이 있는지 확인한다
    int orderCount = orderMapper.getOngoingOrderCount(key);

    if (orderCount == 0) {
      withdrawalMapper.insertWithdrawal(key, id, "(관리자에 의한 회원삭제)");
      accountMapper.deleteAccountById(id);
    }

    return orderCount;
  }

  // 회원정보 상세보기 메소드
  public void selectAccountByAdmin(Object key, Model model) {
    AccountVo accountVo = accountMapper.selectAccount(key);
    model.addAttribute("accountVo", accountVo);
  }

  // 회원정보 업데이트 메소드
  public void updateAccountByAdmin(Model model) {
    HttpServletRequest request = (HttpServletRequest) model.asMap().get("request");
    
    String name = request.getParameter("name");
    String password = request.getParameter("password");
    String email = request.getParameter("email");
    String emailReception = request.getParameter("receive");
    String addressZipcode = request.getParameter("zipcode");
    String addressNew = request.getParameter("roadAddress");
    String addressOld = request.getParameter("jibunAddress");
    String addressDetail = request.getParameter("detailAddress");
    String addressExtra = request.getParameter("extraAddress");
    String key = request.getParameter("key");

    accountMapper.updateAccountByAdmin(name, password, email, emailReception, addressZipcode, addressNew, addressOld, addressDetail, addressExtra, key);
  }

  // 검색결과 목록 표시
  public void searchList(String type, String keyword, int page, Model model) {
    int offset = (page - 1) * rowsPerPage;
    int endPage = (int) Math.ceil((double) page / pageSet) * pageSet;
    int startPage = endPage - pageSet + 1;
    int count = 0;

    switch (type) {
      case "name":
        model.addAttribute("accountList", accountMapper.searchNameList("%" + keyword + "%", offset, rowsPerPage));
        count = accountMapper.getSearchNameCount("%" + keyword + "%");      
        break;
      case "email":
        model.addAttribute("accountList", accountMapper.searchEmailList("%" + keyword + "%", offset, rowsPerPage));
        count = accountMapper.getSearchEmailCount("%" + keyword + "%");      
        break;
      default:
        model.addAttribute("accountList", accountMapper.searchPhoneList("%" + keyword + "%", offset, rowsPerPage));
        count = accountMapper.getSearchPhoneCount("%" + keyword + "%");      
        break;
    }

    int pages = (int) Math.ceil((double) count / rowsPerPage);

    if (endPage > pages) endPage = pages;

    model.addAttribute("page", page);
    model.addAttribute("pages", pages);
    model.addAttribute("startPage", startPage);
    model.addAttribute("endPage", endPage);
    model.addAttribute("type", type);
    model.addAttribute("keyword", keyword);
  }
}
