package dev.localhost.koitt14.order;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface OrderMapper {
  // 주문번호 생성 시 사용
  public int getOrderCount(String date);

  // 개별 유저 주문페이지 생성에 사용
  public int getUserOrderCount(Object accountKey);
  public ArrayList<OrderVo> getList(Object accountKey, int offset, int rowsPerPage);
  public ArrayList<OrderVo> getOrderDetail(String orderNumber, Object accountKey);
  public int getOrderPrice(String orderNumber, Object accountKey);

  public int getOngoingOrderCount(Object accountKey);

  public void insertOrder(String orderNumber, int orderGroup, int orderPrice, int orderQuantity, String productName, int productPrice, int quantity, String status, int productKey, Object accountKey, int paymentKey);

  // 유저 주문 취소에 사용
  public int getPaymentKey(String orderNumber);

  public void updateStatus(String status, String orderNumber, Object accountKey);

  /* 관리자 페이지용 메소드 시작 */
  public int getUserOrderCountByAdmin();
  public ArrayList<OrderListVo> getListByAdmin(int offset, int rowsPerPage);
  public String getOrderStatusByAdmin(String orderNumber);
  public ArrayList<OrderVo> getOrderDetailByAdmin(String orderNumber);
  public void updateStatusByAdmin(String status, String orderNumber);
  public int getStatusCount(String status);

  public ArrayList<OrderListVo> getStatusList(String status, int offset, int rowsPerPage);

  public int getEtcCount();
  public ArrayList<OrderListVo> getEtcList(int offset, int rowsPerPage);

  public ArrayList<OrderListVo> searchNameList(String keyword, int offset, int rowsPerPage);
  public int getSearchNameCount(String keyword);

  public ArrayList<OrderListVo> searchNumberList(String keyword, int offset, int rowsPerPage);
  public int getSearchNumberCount(String keyword);

  public ArrayList<OrderVo> getOrderProductList(String orderNumber);
}
