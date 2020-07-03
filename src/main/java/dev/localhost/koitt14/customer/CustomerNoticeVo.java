package dev.localhost.koitt14.customer;

import java.sql.Timestamp;

public class CustomerNoticeVo {
  
	private int seqKey;
	private String title;
	private String content;
	private String contentImageFilename;
	private Timestamp createdDate;
	private Timestamp modifiedDate;
	private int accountKey;
	private int nowTimeDifference;
	
	public CustomerNoticeVo() {
		
	}
	
	public CustomerNoticeVo(int seqKey, String title, String content, String contentImageFilename,
							Timestamp createdDate, Timestamp modifiedDate, int accountKey, int nowTimeDifference) {
		this.seqKey = seqKey;
		this.title = title;
		this.content = content;
		this.contentImageFilename = contentImageFilename;
		this.createdDate = createdDate;
		this.modifiedDate = modifiedDate;
		this.accountKey = accountKey;
		this.nowTimeDifference = nowTimeDifference;
	}

	
	public int getSeqKey() {
		return seqKey;
	}

	public void setSeqKey(int seqKey) {
		this.seqKey = seqKey;
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

	public String getContentImageFilename() {
		return contentImageFilename;
	}

	public void setContentImageFilename(String contentImageFilename) {
		this.contentImageFilename = contentImageFilename;
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
	
	public int getNowTimeDifference() {
		return nowTimeDifference;
	}

	public void setNowTimeDifference(int nowTimeDifference) {
		this.nowTimeDifference = nowTimeDifference;
	}
	
}
