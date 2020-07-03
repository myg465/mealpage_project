package dev.localhost.koitt14.review;

import java.sql.Timestamp;

public class ReviewVo {
	
	public ReviewVo() {}
	

	public ReviewVo(int seqKey, String content, int grade, String imageFileName, Timestamp createdDate,
			Timestamp modifiedDate, int productKey, int accountKey, String id, String name,String category1,String category2) {
		super();
		this.seqKey = seqKey;
		this.content = content;
		this.grade = grade;
		this.imageFileName = imageFileName;
		this.createdDate = createdDate;
		this.modifiedDate = modifiedDate;
		this.productKey = productKey;
		this.accountKey = accountKey;
		this.id = id;
		this.name = name;
		this.category1 = category1;
		this.category2 = category2;
	}


	private int seqKey; //리뷰일련번호
	private String content; //리뷰내용
	private int grade; //별점
	private String imageFileName; //본문이미지
	private Timestamp createdDate; //등록일
	private Timestamp modifiedDate; //수정일
	private int productKey; //상품코드(상품테이블과 연결)
	private int accountKey; //회원코드(회원테이블과 연결)
	//----------------------------------------------//
	private String id; //회원코드로 불러온 아이디
	private String name; // 상품코드로 불러온 상품명
	private String category1; // 상품코드로 불러온 대분류
	private String category2; // 상품코드로 불러온 소분류
	
	
	//getter and setter
	
	public int getSeqKey() {
		return seqKey;
	}
	public void setSeqKey(int seqKey) {
		this.seqKey = seqKey;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	public String getImageFileName() {
		return imageFileName;
	}
	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}
	public Timestamp getCreatedDate() {
		return createdDate;
	}
	public void setCreatedDate(Timestamp createdDate) {
		this.createdDate = createdDate;
	}
	public Timestamp getModifiedDate() {
		return modifiedDate;
	}
	public void setModifiedDate(Timestamp modifiedDate) {
		this.modifiedDate = modifiedDate;
	}
	public int getProductKey() {
		return productKey;
	}
	public void setProductKey(int productKey) {
		this.productKey = productKey;
	}
	public int getAccountKey() {
		return accountKey;
	}
	public void setAccountKey(int accountKey) {
		this.accountKey = accountKey;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}


	public String getCategory1() {
		return category1;
	}


	public void setCategory1(String category1) {
		this.category1 = category1;
	}


	public String getCategory2() {
		return category2;
	}


	public void setCategory2(String category2) {
		this.category2 = category2;
	}
	
	
	
	
}
