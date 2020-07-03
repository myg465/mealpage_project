package dev.localhost.koitt14.productInquiry;

import java.sql.Timestamp;

public class ProductInquiryVo {
	
	
	public ProductInquiryVo(int seqKey, String content, Timestamp createdDate, Timestamp modifiedDate, String reply,
			Timestamp replyCreatedDate, Timestamp replyModifiedDate, String secret, int productkey, int accountKey,
			String id, String name) {
		this.seqKey = seqKey;
		this.content = content;
		this.createdDate = createdDate;
		this.modifiedDate = modifiedDate;
		this.reply = reply;
		this.replyCreatedDate = replyCreatedDate;
		this.replyModifiedDate = replyModifiedDate;
		this.secret = secret;
		this.productkey = productkey;
		this.accountKey = accountKey;
		this.id = id;
		this.name = name;
	}
	private int seqKey; //상품문의 일련번호
	private String content; //상품문의 내용
	private Timestamp createdDate; //상품문의 등록일
	private Timestamp modifiedDate; //상품문의 수정일
	private String reply; //상품문의 답변
	private Timestamp replyCreatedDate; //답변 작성일
	private Timestamp replyModifiedDate; //답변 수정일
	private String secret; //비밀글여부
	private int productkey; //제품코드(외래키)
	private int accountKey; //회원코드(외래키)
	private String id; //아이디(조인으로 가져옴)
	private String name; //상품명(조인으로 가져옴)
	
	
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
	public String getReply() {
		return reply;
	}
	public void setReply(String reply) {
		this.reply = reply;
	}
	public Timestamp getReplyCreatedDate() {
		return replyCreatedDate;
	}
	public void setReplyCreatedDate(Timestamp replyCreatedDate) {
		this.replyCreatedDate = replyCreatedDate;
	}
	public Timestamp getReplyModifiedDate() {
		return replyModifiedDate;
	}
	public void setReplyModifiedDate(Timestamp replyModifiedDate) {
		this.replyModifiedDate = replyModifiedDate;
	}
	public String getSecret() {
		return secret;
	}
	public void setSecret(String secret) {
		this.secret = secret;
	}
	public int getProductkey() {
		return productkey;
	}
	public void setProductkey(int productkey) {
		this.productkey = productkey;
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
	
	

}
