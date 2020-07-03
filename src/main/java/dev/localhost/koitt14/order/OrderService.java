package dev.localhost.koitt14.order;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import dev.localhost.koitt14.account.AccountMapper;
import dev.localhost.koitt14.cart.*;
import dev.localhost.koitt14.payment.*;
import dev.localhost.koitt14.point.PointService;
import dev.localhost.koitt14.product.ProductService;
import dev.localhost.koitt14.wishlist.*;

@Service
public class OrderService {
  // 페이지 당 게시물 출력 수 (최소 2 이상)
  int rowsPerPage = 10;
  // 게시판 하단에 표시되는 이동 가능 페이지 수
  int pageSet = 5;

  @Autowired
  private AccountMapper accountMapper;

  @Autowired
  private CartService cartService;

  @Autowired
  private CartMapper cartMapper;

  @Autowired
  private OrderMapper orderMapper;

  @Autowired
  private PaymentService paymentService;

  @Autowired
  private PaymentMapper paymentMapper;

  @Autowired
  private PointService pointService;

  @Autowired
  private ProductService productService;

  @Autowired
  private WishlistService wishlistService;

  @Autowired
  private WishlistMapper wishlistMapper;

  // 유저 주문 목록을 가져오는 메소드
  public void getList(int page, Model model) {
    HttpServletRequest request = (HttpServletRequest) model.asMap().get("request");
    HttpSession session = request.getSession();
    Object accountKey = session.getAttribute("accountKey");

    int offset = (page - 1) * rowsPerPage;
    int endPage = (int) Math.ceil((double) page / pageSet) * pageSet;
    int startPage = endPage - pageSet + 1;
    int count = orderMapper.getUserOrderCount(accountKey);
    int pages = (int) Math.ceil((double) count / rowsPerPage);

    if (endPage > pages) endPage = pages;

    model.addAttribute("orderList", orderMapper.getList(accountKey, offset, rowsPerPage));
    model.addAttribute("page", page);
    model.addAttribute("pages", pages);
    model.addAttribute("startPage", startPage);
    model.addAttribute("endPage", endPage);
    model.addAttribute("accountKey", accountKey);
  }

  // 주문 상세 내역을 가져오는 메소드
  public void getOrderDetail(String orderNumber, Model model) {
    HttpServletRequest request = (HttpServletRequest) model.asMap().get("request");
    HttpSession session = request.getSession();
    Object accountKey = session.getAttribute("accountKey");

    model.addAttribute("orderList", orderMapper.getOrderDetail(orderNumber, accountKey));
    model.addAttribute("orderPrice", orderMapper.getOrderPrice(orderNumber, accountKey));
    model.addAttribute("accountKey", accountKey);
  }

  // 유저 주문 생성 메소드
  public void insertOrder(String type, int paymentKey, Model model) {
    // 주문번호 생성
    LocalDateTime time = LocalDateTime.now();
    DateTimeFormatter timeFormat1 = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    String today = time.format(timeFormat1);
    DateTimeFormatter timeFormat2 = DateTimeFormatter.ofPattern("yyyyMMdd");
    String todayNum = time.format(timeFormat2);

    int count = orderMapper.getOrderCount(today + "%") + 1001;
    String orderNumber = todayNum + "-" + count;

    // DB 삽입
    HttpServletRequest request = (HttpServletRequest) model.asMap().get("request");
    HttpSession session = request.getSession();
    Object accountKey = session.getAttribute("accountKey");

    PaymentVo paymentVo = paymentMapper.selectPayment(paymentKey);
    String status = paymentVo.getStatus();
    int deliveryFee = paymentVo.getAmountDelivery();

    String[] orderItems = (String[]) session.getAttribute("orderItems");
    ArrayList<CartProductVo> orderItemList = new ArrayList<>();

    int orderPrice = 0;
    int orderQuantity = 0;

    // 상품재고 확인
    for (int i = 0; i < orderItems.length; i++) {
      CartProductVo orderItem = null;

      if (type.equals("cart")) {
        orderItem = cartService.selectCartProduct(orderItems[i]);
      } else {
        orderItem = wishlistService.selectWishlistProduct(orderItems[i]);
      }

      if (orderItem.getQuantity() > orderItem.getStock()) {
        model.addAttribute("error", "stock");
        model.addAttribute("productName", orderItem.getName());
        model.addAttribute("quantity", orderItem.getQuantity());
        model.addAttribute("stock", orderItem.getStock());

        return;
      }
    }

    // 주문상품 총액, 총 상품갯수 계산
    for (int i = 0; i < orderItems.length; i++) {
      CartProductVo orderItem = null;

      if (type.equals("cart")) {
        orderItem = cartService.selectCartProduct(orderItems[i]);
      } else {
        orderItem = wishlistService.selectWishlistProduct(orderItems[i]);
      }

      orderPrice += orderItem.getPrice() * orderItem.getQuantity();
      orderQuantity += orderItem.getQuantity();

      // 재고에서 주문수량 삭감
      productService.stockDown(orderItem.getQuantity(), orderItem.getProductKey());
    }

    orderPrice += deliveryFee;

    // 주문 기록
    for (int i = 0; i < orderItems.length; i++) {
      CartProductVo orderItem = null;

      if (type.equals("cart")) {
        orderItem = cartService.selectCartProduct(orderItems[i]);
      } else {
        orderItem = wishlistService.selectWishlistProduct(orderItems[i]);
      }

      orderItemList.add(orderItem);

      String productName = orderItem.getName();
      int productPrice = orderItem.getPrice();
      int quantity = orderItem.getQuantity();
      int productKey = orderItem.getProductKey();
      int orderGroup = orderItems.length;

      orderMapper.insertOrder(orderNumber, orderGroup, orderPrice, orderQuantity, productName, productPrice, quantity, status, productKey, accountKey, paymentKey);

      if (type.equals("cart")) {
        cartMapper.deleteCart(orderItems[i]);
      } else {
        wishlistMapper.deleteWishlist(orderItems[i]);
      }
    }

    model.addAttribute("orderItemList", orderItemList);
    model.addAttribute("paymentVo", paymentVo);
    model.addAttribute("orderNumber", orderNumber);
    model.addAttribute("today", today);
  }

  // 유저 주문 취소 메소드
  public void cancelOrder(String orderNumber, Model model) {
    HttpServletRequest request = (HttpServletRequest) model.asMap().get("request");
    HttpSession session = request.getSession();
    Object accountKey = session.getAttribute("accountKey");

    int paymentKey = orderMapper.getPaymentKey(orderNumber);
    String status = paymentService.cancelPayment(paymentKey, model);
    orderMapper.updateStatus(status, orderNumber, accountKey);

    // 주문 수량 복원
    ArrayList<OrderVo> orders = orderMapper.getOrderProductList(orderNumber);
    for (int i = 0; i < orders.size(); i++) {
      OrderVo order = orders.get(i);
      productService.stockUp(order.getQuantity(), order.getProductKey());
    }
  }

  // 유저 주문 구매확정 메소드
  public void confirmOrder(String orderNumber, Model model) {
    HttpServletRequest request = (HttpServletRequest) model.asMap().get("request");
    HttpSession session = request.getSession();
    Object accountKey = session.getAttribute("accountKey");

    int paymentKey = orderMapper.getPaymentKey(orderNumber);
    PaymentVo paymentVo = paymentService.selectPayment(paymentKey);

    if (paymentVo.getAmountFinal() > paymentVo.getAmountDelivery()) {
      int point = paymentVo.getAmountFinal() - paymentVo.getAmountDelivery();
      pointService.insertAddPoint("구매 적립 포인트", point, model);

      int accountPoint = accountMapper.getPoint(accountKey);
      accountMapper.updatePoint(accountPoint + point, accountKey);
    }

    orderMapper.updateStatus("구매확정", orderNumber, accountKey);
  }
  
  /* 관리자 페이지용 메소드 시작*/
  // 주문 목록 읽기
  public void getListByAdmin(int page, Model model) {
    int offset = (page - 1) * rowsPerPage;
    int endPage = (int) Math.ceil((double) page / pageSet) * pageSet;
    int startPage = endPage - pageSet + 1;
    int count = orderMapper.getUserOrderCountByAdmin();
    int pages = (int) Math.ceil((double) count / rowsPerPage);

    if (endPage > pages) endPage = pages;

    model.addAttribute("orderList", orderMapper.getListByAdmin(offset, rowsPerPage));
    model.addAttribute("page", page);
    model.addAttribute("pages", pages);
    model.addAttribute("startPage", startPage);
    model.addAttribute("endPage", endPage);
  }

  public void statusList(String status, int page, Model model) {
    int offset = (page - 1) * rowsPerPage;
    int endPage = (int) Math.ceil((double) page / pageSet) * pageSet;
    int startPage = endPage - pageSet + 1;
    int count = orderMapper.getStatusCount(status + "%");
    int pages = (int) Math.ceil((double) count / rowsPerPage);

    if (endPage > pages) endPage = pages;

    model.addAttribute("orderList", orderMapper.getStatusList(status + "%", offset, rowsPerPage));
    model.addAttribute("page", page);
    model.addAttribute("pages", pages);
    model.addAttribute("startPage", startPage);
    model.addAttribute("endPage", endPage);
    model.addAttribute("status", status);
  }

  public void etcList(int page, Model model) {
    int offset = (page - 1) * rowsPerPage;
    int endPage = (int) Math.ceil((double) page / pageSet) * pageSet;
    int startPage = endPage - pageSet + 1;
    int count = orderMapper.getEtcCount();
    int pages = (int) Math.ceil((double) count / rowsPerPage);

    if (endPage > pages) endPage = pages;

    model.addAttribute("orderList", orderMapper.getEtcList(offset, rowsPerPage));
    model.addAttribute("page", page);
    model.addAttribute("pages", pages);
    model.addAttribute("startPage", startPage);
    model.addAttribute("endPage", endPage);
    model.addAttribute("status", "기타");
  }

  public void searchList(String type, String keyword, int page, Model model) {
    int offset = (page - 1) * rowsPerPage;
    int endPage = (int) Math.ceil((double) page / pageSet) * pageSet;
    int startPage = endPage - pageSet + 1;
    int count = 0;

    switch (type) {
      case "name":
        model.addAttribute("orderList", orderMapper.searchNameList("%" + keyword + "%", offset, rowsPerPage));
        count = orderMapper.getSearchNameCount("%" + keyword + "%");
        break;
      default:
        model.addAttribute("orderList", orderMapper.searchNumberList("%" + keyword + "%", offset, rowsPerPage));
        count = orderMapper.getSearchNumberCount("%" + keyword + "%");      
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

  // 주문 상세 내역을 가져오는 메소드
  public void getOrderDetailByAdmin(String orderNumber, Model model) {
    model.addAttribute("orderStatus", orderMapper.getOrderStatusByAdmin(orderNumber));
    model.addAttribute("orderList", orderMapper.getOrderDetailByAdmin(orderNumber));

    int paymentKey = orderMapper.getPaymentKey(orderNumber);
    model.addAttribute("paymentVo", paymentMapper.selectPayment(paymentKey));
  }

  // 주문 취소 메소드
  public void cancelOrderByAdmin(String orderNumber) {
    int paymentKey = orderMapper.getPaymentKey(orderNumber);
    String status = paymentService.cancelPaymentByAdmin(paymentKey);
    orderMapper.updateStatusByAdmin(status, orderNumber);

    // 주문 수량 복원
    ArrayList<OrderVo> orders = orderMapper.getOrderProductList(orderNumber);
    for (int i = 0; i < orders.size(); i++) {
      OrderVo order = orders.get(i);
      productService.stockUp(order.getQuantity(), order.getProductKey());
    }    
  }

  // 주문 입금확인 및 입금확인 취소에 사용하는 메소드
  public void updatePaidStatusByAdmin(String status, String orderNumber) {
    int paymentKey = orderMapper.getPaymentKey(orderNumber);
    paymentMapper.updateStatusByAdmin(status, paymentKey);
    orderMapper.updateStatusByAdmin(status, orderNumber);
  }

  // 주문상태 업데이트 메소드
  public void updateStatusByAdmin(String status, String orderNumber) {
    orderMapper.updateStatusByAdmin(status, orderNumber);
  }

  // 주문상태 count를 가져오는 메소드
  public int getStatusCount(String status) {
    return orderMapper.getStatusCount(status + "%");
  }
}
