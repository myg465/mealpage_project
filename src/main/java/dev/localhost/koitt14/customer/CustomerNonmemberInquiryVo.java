package dev.localhost.koitt14.customer;

import java.sql.Timestamp;

public class CustomerNonmemberInquiryVo {
  
	private int seqKey;
	private String name;
	private String email;
	private String phone;
	private String title;
	private String content;
	private String fileName;
	private Timestamp createdDate;
	private String replied;
	private String reply;
	private Timestamp replyCreatedDate;
	
	public CustomerNonmemberInquiryVo() {
		
	}
	
	public CustomerNonmemberInquiryVo(int seqKey, String name, String email, String phone,
								String title, String content, String fileName, Timestamp createdDate,
								String replied, String reply, Timestamp replyCreatedDate) {
		this.seqKey = seqKey;
		this.name = name;
		this.email = email;
		this.phone = phone;
		this.title = title;
		this.content = content;
		this.fileName = fileName;
		this.createdDate = createdDate;
		this.replied = replied;
		this.reply = reply;
		this.replyCreatedDate = replyCreatedDate;
	}

	public int getSeqKey() {
		return seqKey;
	}

	public void setSeqKey(int seqKey) {
		this.seqKey = seqKey;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public Timestamp getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Timestamp createdDate) {
		this.createdDate = createdDate;
	}

	public String getReplied() {
		return replied;
	}

	public void setReplied(String replied) {
		this.replied = replied;
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
	
}
