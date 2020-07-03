package dev.localhost.koitt14.coupon;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.http.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

@Service
public class CouponService {
  @Autowired
  private CouponMapper couponMapper;
    
  // 쿠폰 목록을 가져온다
  public void getList(Model model) {
    HttpServletRequest request = (HttpServletRequest) model.asMap().get("request");
    HttpSession session = request.getSession();
    Object accountKey = session.getAttribute("accountKey");

    LocalDateTime time = LocalDateTime.now();
    DateTimeFormatter timeFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    String today = time.format(timeFormat);

    // 사용 가능한 쿠폰 목록
    model.addAttribute("couponList", couponMapper.getAbleList(accountKey, today));
    // 사용 불가(사용완료, 기간만료)한 쿠폰 목록
    model.addAttribute("disableList", couponMapper.getDisableList(accountKey, today));
  }

  // 사용 가능한 쿠폰의 총 갯수를 얻는다
  public void getCouponCount(Model model) {
    HttpServletRequest request = (HttpServletRequest) model.asMap().get("request");
    HttpSession session = request.getSession();
    Object accountKey = session.getAttribute("accountKey");

    LocalDateTime time = LocalDateTime.now();
    DateTimeFormatter timeFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    String today = time.format(timeFormat);

    model.addAttribute("couponCount", couponMapper.getCouponCount(accountKey, today));
  }

  // 유저 계정에 쿠폰을 발급한다
  public void insertPriceCoupon(String name, int minimumPrice, int discountPrice, String startDate, String endDate, Object accountKey) {  
    couponMapper.insertPercentCoupon(name, minimumPrice, discountPrice, startDate, endDate, accountKey);
  }

  public void insertPercentCoupon(String name, int minimumPrice, int discountPercent, String startDate, String endDate, Object accountKey) {  
    couponMapper.insertPercentCoupon(name, minimumPrice, discountPercent, startDate, endDate, accountKey);
  }

  // 기간만료된 쿠폰을 '사용불가'로 상태변경 한다
  public void updateDisable(Model model) {
    HttpServletRequest request = (HttpServletRequest) model.asMap().get("request");
    HttpSession session = request.getSession();
    Object accountKey = session.getAttribute("accountKey");

    LocalDateTime time = LocalDateTime.now();
    DateTimeFormatter timeFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    String today = time.format(timeFormat);
        
    couponMapper.updateDisable(accountKey, today);
  }

  // 사용한 쿠폰을 '사용완료'로 상태변경 한다
  public void updateUsed(String key) {
    couponMapper.updateUsed(key);
  }

  /* 관리자 페이지용 메소드 시작 */
  // 페이지 당 게시물 출력 수 (최소 2 이상)
  int rowsPerPage = 10;
  // 게시판 하단에 표시되는 이동 가능 페이지 수
  int pageSet = 5;

  // 유효쿠폰 목록을 가져온다
  public void getAbleListByAdmin(int page, Model model) {
    LocalDateTime time = LocalDateTime.now();
    DateTimeFormatter timeFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    String today = time.format(timeFormat);

    int offset = (page - 1) * rowsPerPage;
    int endPage = (int) Math.ceil((double) page / pageSet) * pageSet;
    int startPage = endPage - pageSet + 1;

    int count = couponMapper.getAbleCount(today);
    int pages = (int) Math.ceil((double) count / rowsPerPage);

    if (endPage > pages) endPage = pages;

    model.addAttribute("couponList", couponMapper.getAbleListByAdmin(today, offset, rowsPerPage));
    model.addAttribute("count", count);
    model.addAttribute("page", page);
    model.addAttribute("pages", pages);
    model.addAttribute("startPage", startPage);
    model.addAttribute("endPage", endPage);
  }

  // 만료쿠폰 목록을 가져온다
  public void getDisableListByAdmin(int page, Model model) {
    LocalDateTime time = LocalDateTime.now();
    DateTimeFormatter timeFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    String today = time.format(timeFormat);

    int offset = (page - 1) * rowsPerPage;
    int endPage = (int) Math.ceil((double) page / pageSet) * pageSet;
    int startPage = endPage - pageSet + 1;

    int count = couponMapper.getDisableCount(today);
    int pages = (int) Math.ceil((double) count / rowsPerPage);

    if (endPage > pages) endPage = pages;

    model.addAttribute("couponList", couponMapper.getDisableListByAdmin(today, offset, rowsPerPage));
    model.addAttribute("count", count);
    model.addAttribute("page", page);
    model.addAttribute("pages", pages);
    model.addAttribute("startPage", startPage);
    model.addAttribute("endPage", endPage);
  }

  // 기간만료된 쿠폰을 '사용불가'로 상태변경 한다
  public void updateDisableByAdmin() {
    LocalDateTime time = LocalDateTime.now();
    DateTimeFormatter timeFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    String today = time.format(timeFormat);
        
    couponMapper.updateDisableByAdmin(today);
  }  
}
