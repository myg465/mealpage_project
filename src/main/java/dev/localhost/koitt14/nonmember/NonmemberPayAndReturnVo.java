package dev.localhost.koitt14.nonmember;

import java.sql.Timestamp;

public class NonmemberPayAndReturnVo {

	public NonmemberPayAndReturnVo() {}
	

	public NonmemberPayAndReturnVo(String productName, int productPrice, int quantity, Timestamp createdDate,
			String pMethod, int amountDelivery, int amountFinal, String pStatus, Timestamp refundDate, String method,
			String status, int amountCash) {
		super();
		this.productName = productName;
		this.productPrice = productPrice;
		this.quantity = quantity;
		this.createdDate = createdDate;
		this.pMethod = pMethod;
		this.amountDelivery = amountDelivery;
		this.amountFinal = amountFinal;
		this.pStatus = pStatus;
		this.refundDate = refundDate;
		this.method = method;
		this.status = status;
		this.amountCash = amountCash;
	}


	//------------주문테이블--------------
	String productName; //주문상품명
	int productPrice; //주문했던 당시의 상품가격
	int quantity; //주문수량
	Timestamp createdDate; //주문일
	//------------결제테이블--------------
	String pMethod; //결제수단
	int amountDelivery; // 배송비
	int amountFinal; //총결제금액
	String pStatus; //결제상태
	//------------환불테이블--------------
	Timestamp refundDate; //환불완료일
	String method; //환불방법
	String status; //환불상태
	int amountCash; //환불 총액
	
	
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public int getProductPrice() {
		return productPrice;
	}
	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public Timestamp getCreatedDate() {
		return createdDate;
	}
	public void setCreatedDate(Timestamp createdDate) {
		this.createdDate = createdDate;
	}
	public String getpMethod() {
		return pMethod;
	}
	public void setpMethod(String pMethod) {
		this.pMethod = pMethod;
	}
	public int getAmountDelivery() {
		return amountDelivery;
	}
	public void setAmountDelivery(int amountDelivery) {
		this.amountDelivery = amountDelivery;
	}
	public int getAmountFinal() {
		return amountFinal;
	}
	public void setAmountFinal(int amountFinal) {
		this.amountFinal = amountFinal;
	}
	public String getpStatus() {
		return pStatus;
	}
	public void setpStatus(String pStatus) {
		this.pStatus = pStatus;
	}
	public Timestamp getRefundDate() {
		return refundDate;
	}
	public void setRefundDate(Timestamp refundDate) {
		this.refundDate = refundDate;
	}
	public String getMethod() {
		return method;
	}
	public void setMethod(String method) {
		this.method = method;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public int getAmountCash() {
		return amountCash;
	}
	public void setAmountCash(int amountCash) {
		this.amountCash = amountCash;
	}
	
	
	
}
