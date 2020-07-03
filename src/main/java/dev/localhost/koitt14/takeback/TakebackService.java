package dev.localhost.koitt14.takeback;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import dev.localhost.koitt14.order.OrderMapper;
import dev.localhost.koitt14.order.OrderVo;
import dev.localhost.koitt14.product.ProductService;

@Service
public class TakebackService {
  // 페이지 당 게시물 출력 수 (최소 2 이상)
  int rowsPerPage = 10;
  // 게시판 하단에 표시되는 이동 가능 페이지 수
  int pageSet = 5;

  @Autowired
  private OrderMapper orderMapper;

  @Autowired
  private ProductService productService;

  @Autowired
  private TakebackMapper takebackMapper;

  // 반품/교환 목록을 가져오는 메소드
  public void getList(int page, Model model) {
    HttpServletRequest request = (HttpServletRequest) model.asMap().get("request");
    HttpSession session = request.getSession();
    Object accountKey = session.getAttribute("accountKey");

    int offset = (page - 1) * rowsPerPage;
    int endPage = (int) Math.ceil((double) page / pageSet) * pageSet;
    int startPage = endPage - pageSet + 1;
    int count = takebackMapper.getCount(accountKey);
    int pages = (int) Math.ceil((double) count / rowsPerPage);

    if (endPage > pages) endPage = pages;

    model.addAttribute("takebackList", takebackMapper.getList(accountKey, offset, rowsPerPage));
    model.addAttribute("page", page);
    model.addAttribute("pages", pages);
    model.addAttribute("startPage", startPage);
    model.addAttribute("endPage", endPage);
    model.addAttribute("accountKey", accountKey);
  }

  // 반품/교환 처리 메소드
  public void takebackOrder(String status, String orderNumber, Model model) {
    HttpServletRequest request = (HttpServletRequest) model.asMap().get("request");
    HttpSession session = request.getSession();
    Object accountKey = session.getAttribute("accountKey");

    String charged = request.getParameter("charged");
    if (charged.equals("buyer")) {
      charged = "구매자";
    } else {
      charged = "판매자";
    }

    String content = request.getParameter("content");

    takebackMapper.insertTakeback(charged, content, status, orderNumber, accountKey);
    orderMapper.updateStatus(status, orderNumber, accountKey);
  }  

  // 반품/교환 요청취소 메소드
  public void cancelTakeback(String orderNumber, Model model) {
    HttpServletRequest request = (HttpServletRequest) model.asMap().get("request");
    HttpSession session = request.getSession();
    Object accountKey = session.getAttribute("accountKey");

    int key = takebackMapper.selectRecentTakeback(orderNumber, accountKey);
    takebackMapper.deleteTakeback(key, accountKey);
    String status = orderMapper.getOrderStatusByAdmin(orderNumber);

    switch (status) {
      case "반품요청(배송중)":
        status = "배송중";
        break;
      default:
        status = "배송완료";
    }

    orderMapper.updateStatus(status, orderNumber, accountKey);
  }

  // 교환/반품 사유 읽기
  public void selectTakeback(String key, Model model) {
    HttpServletRequest request = (HttpServletRequest) model.asMap().get("request");
    HttpSession session = request.getSession();
    Object accountKey = session.getAttribute("accountKey");

    model.addAttribute("takeback", takebackMapper.selectTakeback(key, accountKey));
  }

  /* 관리자 페이지용 메소드 시작 */
  // 유저가 입력한 교환/반품 사유를 불러온다
  public void selectTakebackByAdmin(String orderNumber, Model model) {
    model.addAttribute("takeback", takebackMapper.selectTakebackByAdmin(orderNumber));
  }

  public void replyTakeback(String key, Model model) {
    HttpServletRequest request = (HttpServletRequest) model.asMap().get("request");
    String orderNumber = request.getParameter("orderNumber");
    Object accountKey = request.getParameter("accountKey");

    String acceptation = request.getParameter("acceptation");
    String reply = request.getParameter("reply");
    String charged = request.getParameter("charged");
    String status = request.getParameter("status");
    String orderStatus = "";
 
    if (acceptation.equals("yes")) {
      switch (status) {
        case "교환요청":
          status = "교환승인";

          if (charged.equals("구매자")) orderStatus = "배송준비중(교환배송비)";
          else orderStatus = "배송준비중(교환)";
          break;
        default:
          status = "반품승인";
          
          if (charged.equals("구매자")) orderStatus = "환불대기(배송비제외)";
          else orderStatus = "환불대기(반품)";

          // 주문 수량 복원
          ArrayList<OrderVo> orders = orderMapper.getOrderProductList(orderNumber);
          for (int i = 0; i < orders.size(); i++) {
            OrderVo order = orders.get(i);
            productService.stockUp(order.getQuantity(), order.getProductKey());
          }
        }
    } else {
      if (status.equals("반품요청(배송중)")) orderStatus = "배송중";
      else orderStatus = "배송완료";

      switch (status) {
        case "교환요청":
          status = "교환거절";
          break;
        default:
          status = "반품거절";
      }
    }

    orderMapper.updateStatus(orderStatus, orderNumber, accountKey);
    takebackMapper.updateTakeback(reply, status, key);
  }
}
