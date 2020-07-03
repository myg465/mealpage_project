package dev.localhost.koitt14.payment;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import dev.localhost.koitt14.account.AccountService;
import dev.localhost.koitt14.cart.CartProductVo;
import dev.localhost.koitt14.cart.CartService;
import dev.localhost.koitt14.coupon.CouponService;
import dev.localhost.koitt14.point.PointService;
import dev.localhost.koitt14.wishlist.WishlistService;

@Service
public class PaymentService {
  @Autowired
  private AccountService accountService;

  @Autowired
  private CartService cartService;

  @Autowired
  private WishlistService wishlistService;

  @Autowired
  private PaymentMapper paymentMapper;

  @Autowired
  private PointService pointService;

  @Autowired
  private CouponService couponService;

  // 결제할 상품목록을 '장바구니'에서 가져온다
  public void getOrderFromCart(Model model) {
    accountService.selectAccount(model);
    couponService.getList(model);

    HttpServletRequest request = (HttpServletRequest) model.asMap().get("request");
    HttpSession session = request.getSession();
    String[] orderItems = (String[]) session.getAttribute("orderItems");
    
    ArrayList<CartProductVo> orderItemList = new ArrayList<>();

    for (int i = 0; i < orderItems.length; i++) {
      orderItemList.add(cartService.selectCartProduct(orderItems[i]));
    }

    model.addAttribute("orderItemList", orderItemList);
  }

  // 결제할 상품목록을 '찜한 상품'에서 가져온다
  public void getOrderFromWishlist(Model model) {
    accountService.selectAccount(model);
    couponService.getList(model);

    HttpServletRequest request = (HttpServletRequest) model.asMap().get("request");
    HttpSession session = request.getSession();
    String[] orderItems = (String[]) session.getAttribute("orderItems");
    
    ArrayList<CartProductVo> orderItemList = new ArrayList<>();

    for (int i = 0; i < orderItems.length; i++) {
      orderItemList.add(wishlistService.selectWishlistProduct(orderItems[i]));
    }

    model.addAttribute("orderItemList", orderItemList);
    model.addAttribute("wishlist", "yes");
  }

  // 결제정보를 가져온다
  public PaymentVo selectPayment(int key) {
    return paymentMapper.selectPayment(key);
  }

  // 결제정보를 기입한다
  public int insertPayment(Model model) {
    HttpServletRequest request = (HttpServletRequest) model.asMap().get("request");
    HttpSession session = request.getSession();
    Object accountKey = session.getAttribute("accountKey");

    String ordererName = request.getParameter("name");
    String ordererAddressZipcode = request.getParameter("zipcode");    
    String ordererAddressNew = request.getParameter("roadAddress");
    String ordererAddressOld = request.getParameter("jibunAddress");
    String ordererAddressDetail = request.getParameter("detailAddress");
    String ordererAddressExtra = request.getParameter("extraAddress");
    String ordererEmail = request.getParameter("email");
    String ordererPhone = request.getParameter("phone");

    String recipientName = request.getParameter("destName");
    String recipientAddressZipcode = request.getParameter("destZipcode");    
    String recipientAddressNew = request.getParameter("destRoadAddress");
    String recipientAddressOld = request.getParameter("destJibunAddress");
    String recipientAddressDetail = request.getParameter("destDetailAddress");
    String recipientAddressExtra = request.getParameter("destExtraAddress");
    String recipientPhone = request.getParameter("destPhone");
    String recipientRequest = request.getParameter("destRequest");
    
    int amountTotal = Integer.parseInt(request.getParameter("totalPrice"));
    int amountDelivery = Integer.parseInt(request.getParameter("deliveryFee"));

    int amountDiscountCoupon = 0;
    if ( request.getParameter("couponDiscount") != null) {
      amountDiscountCoupon = Integer.parseInt(request.getParameter("couponDiscount"));
    }

    int amountDiscountPoint = 0;
    if (!request.getParameter("usedPoint").equals("")) {
      amountDiscountPoint = Integer.parseInt(request.getParameter("usedPoint"));
    }
    
    String method = request.getParameter("method");
    int amountFinal = Integer.parseInt(request.getParameter("finalAmount"));

    String status = "";
    String paidDate = "";

    if (amountFinal == 0) {
      status = "결제완료";

      LocalDateTime time = LocalDateTime.now();
      DateTimeFormatter timeFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
      paidDate = time.format(timeFormat);

    } else {
      status = "입금대기";
      paidDate = null;
    }

    paymentMapper.insertPayment(
      ordererName, ordererAddressZipcode, ordererAddressNew, ordererAddressOld, ordererAddressDetail, ordererAddressExtra, ordererEmail, ordererPhone,
      recipientName, recipientAddressZipcode, recipientAddressNew, recipientAddressOld, recipientAddressDetail, recipientAddressExtra, recipientPhone, recipientRequest,
      amountTotal, amountDelivery, amountDiscountCoupon, amountDiscountPoint, amountFinal,
      method, null, status, paidDate, accountKey);

    // 사용한 쿠폰 소멸
    String coupon = request.getParameter("coupon");
    if (coupon != null && !coupon.equals("none")) {
      couponService.updateUsed(coupon);
    }

    // 사용한 포인트 소멸
    if (amountDiscountPoint > 0) {
      // 계정 포인트 변동
      int point = accountService.getPoint(model);
      accountService.updatePoint(point - amountDiscountPoint, model);
      // 포인트 내역 기입
      pointService.insertUsedPoint("상품구매 포인트 사용", amountDiscountPoint, model);
    }

    return paymentMapper.getPaymentKey(accountKey);
  }

  // 비회원 결제정보를 기입한다
  public int insertNonmemberPayment(Model model) {
    HttpServletRequest request = (HttpServletRequest) model.asMap().get("request");

    String ordererName = request.getParameter("name");
    String ordererAddressZipcode = request.getParameter("zipcode");    
    String ordererAddressNew = request.getParameter("roadAddress");
    String ordererAddressOld = request.getParameter("jibunAddress");
    String ordererAddressDetail = request.getParameter("detailAddress");
    String ordererAddressExtra = request.getParameter("extraAddress");
    String ordererEmail = request.getParameter("email");
    String ordererPhone = request.getParameter("phone");

    String recipientName = request.getParameter("destName");
    String recipientAddressZipcode = request.getParameter("destZipcode");    
    String recipientAddressNew = request.getParameter("destRoadAddress");
    String recipientAddressOld = request.getParameter("destJibunAddress");
    String recipientAddressDetail = request.getParameter("destDetailAddress");
    String recipientAddressExtra = request.getParameter("destExtraAddress");
    String recipientPhone = request.getParameter("destPhone");
    String recipientRequest = request.getParameter("destRequest");
    
    int amountTotal = Integer.parseInt(request.getParameter("totalPrice"));
    int amountDelivery = Integer.parseInt(request.getParameter("deliveryFee"));
    int amountFinal = Integer.parseInt(request.getParameter("finalAmount"));
    
    String method = request.getParameter("method");

    String status = "입금대기";
    String paidDate = null;

    paymentMapper.insertNonmemberPayment(
      ordererName, ordererAddressZipcode, ordererAddressNew, ordererAddressOld, ordererAddressDetail, ordererAddressExtra, ordererEmail, ordererPhone,
      recipientName, recipientAddressZipcode, recipientAddressNew, recipientAddressOld, recipientAddressDetail, recipientAddressExtra, recipientPhone, recipientRequest,
      amountTotal, amountDelivery, amountFinal,
      method, null, status, paidDate);

      return paymentMapper.getNonmemberKey(ordererPhone);
  }

  // 유저 주문 취소
  public String cancelPayment(int paymentKey, Model model) {
    HttpServletRequest request = (HttpServletRequest) model.asMap().get("request");
    HttpSession session = request.getSession();
    Object accountKey = session.getAttribute("accountKey");

    PaymentVo paymentVo = paymentMapper.selectPayment(paymentKey);
    
    // 포인트 환불
    int point = paymentVo.getAmountDiscountPoint();

    if (point > 0) {
      int accountPoint = accountService.getPoint(model);
      accountService.updatePoint(point + accountPoint, model);
      pointService.insertAddPoint("구매 포인트 환불", point, model);
    }


    // 현금 환불 관련 처리
    int finalAmount = paymentVo.getAmountFinal();
    String status = paymentVo.getStatus();

    String result = "";
    if (finalAmount > 0 && !status.equals("입금대기")) {
      result = "환불대기";
    } else {
      result = "주문취소";
    }

    paymentMapper.updateStatus(result, paymentKey, accountKey);

    return result;
  }

  /* 관리자 페이지용 메소드 시작 */
  public String cancelPaymentByAdmin(int paymentKey) {
    PaymentVo paymentVo = paymentMapper.selectPayment(paymentKey);
    int accountKey = paymentVo.getAccountKey();
    
    // 포인트 환불
    int point = paymentVo.getAmountDiscountPoint();

    if (point > 0) {
      int accountPoint = accountService.getPointByAdmin(accountKey);
      accountService.updatePointByAdmin(point + accountPoint, accountKey);
      pointService.insertAddPointByAdmin("구매 포인트 환불", point, accountKey);
    }


    // 현금 환불 관련 처리
    int finalAmount = paymentVo.getAmountFinal();
    String status = paymentVo.getStatus();

    String result = "";
    if (finalAmount > 0 && !status.equals("입금대기")) {
      result = "환불대기";
    } else {
      result = "주문취소";
    }

    paymentMapper.updateStatus(result, paymentKey, accountKey);

    return result;
  }

  // 결제상태 수정 메소드
  public String updateStatusByAdmin(String status, int paymentKey) {
    paymentMapper.updateStatusByAdmin(status, paymentKey);

    return status;
  }
}
