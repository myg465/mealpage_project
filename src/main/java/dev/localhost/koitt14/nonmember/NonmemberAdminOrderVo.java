package dev.localhost.koitt14.nonmember;

import java.sql.Timestamp;

public class NonmemberAdminOrderVo {

	
	
	public NonmemberAdminOrderVo(String orderNumber, String nonmemberName, String productName, String oStatus,
			int amountFinal, String pStatus, Timestamp createdDate, int orderGroup) {
		super();
		this.orderNumber = orderNumber;
		this.nonmemberName = nonmemberName;
		this.productName = productName;
		this.oStatus = oStatus;
		this.amountFinal = amountFinal;
		this.pStatus = pStatus;
		this.createdDate = createdDate;
		this.orderGroup = orderGroup;
	}
	
	
	String orderNumber;
	String nonmemberName;
	String productName;
	String oStatus;
	int amountFinal;
	String pStatus;
	Timestamp createdDate;
	int orderGroup;
	
	
	public String getOrderNumber() {
		return orderNumber;
	}
	public void setOrderNumber(String orderNumber) {
		this.orderNumber = orderNumber;
	}
	public String getNonmemberName() {
		return nonmemberName;
	}
	public void setNonmemberName(String nonmemberName) {
		this.nonmemberName = nonmemberName;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getoStatus() {
		return oStatus;
	}
	public void setoStatus(String oStatus) {
		this.oStatus = oStatus;
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
	public Timestamp getCreatedDate() {
		return createdDate;
	}
	public void setCreatedDate(Timestamp createdDate) {
		this.createdDate = createdDate;
	}
	public int getOrderGroup() {
		return orderGroup;
	}
	public void setOrderGroup(int orderGroup) {
		this.orderGroup = orderGroup;
	}
	
	
	
	
	
	
	
}
