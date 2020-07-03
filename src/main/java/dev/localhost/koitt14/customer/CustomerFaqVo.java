package dev.localhost.koitt14.customer;

import java.sql.Timestamp;

public class CustomerFaqVo {
  
	private int seqKey;
	private String category;
	private String title;
	private String content;
	private Timestamp createdDate;
	private Timestamp modifiedDate;
	private int accountKey;
	
	public CustomerFaqVo() {
		
	}
	
	public CustomerFaqVo(int seqKey, String category, String title, String content, 
						Timestamp createdDate, Timestamp modifiedDate, int accountKey) {
		this.seqKey = seqKey;
		this.category = category;
		this.title = title;
		this.content = content;
		this.createdDate = createdDate;
		this.modifiedDate = modifiedDate;
		this.accountKey = accountKey;
	}

	public int getSeqKey() {
		return seqKey;
	}

	public void setSeqKey(int seqKey) {
		this.seqKey = seqKey;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
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

	public int getAccountKey() {
		return accountKey;
	}

	public void setAccountKey(int accountKey) {
		this.accountKey = accountKey;
	}
	
}
