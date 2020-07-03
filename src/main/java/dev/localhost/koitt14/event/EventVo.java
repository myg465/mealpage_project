package dev.localhost.koitt14.event;

import java.sql.Timestamp;

public class EventVo {

	private int seqKey;
	private String title;
	private String titleImageFilename;
	private String content;
	private String contentImageFilename;
	private Timestamp startDate;
	private Timestamp endDate;
	private Timestamp createdDate;
	private Timestamp modifiedDate;
	private int accountKey;
	private int nowTimeDifference;
	
	public EventVo() {
		
	}
	
	public EventVo(int seqKey, String title, String titleImageFilename, String content,
					String contentImageFilename, Timestamp startDate, Timestamp endDate,
					Timestamp createdDate, Timestamp modifiedDate, int accountKey) {
		this.seqKey = seqKey;
		this.title = title;
		this.titleImageFilename = titleImageFilename;
		this.content = content;
		this.contentImageFilename = contentImageFilename;
		this.startDate = startDate;
		this.endDate = endDate;
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

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getTitleImageFilename() {
		return titleImageFilename;
	}

	public void setTitleImageFilename(String titleImageFilename) {
		this.titleImageFilename = titleImageFilename;
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

	public Timestamp getStartDate() {
		return startDate;
	}

	public void setStartDate(Timestamp startDate) {
		this.startDate = startDate;
	}

	public Timestamp getEndDate() {
		return endDate;
	}

	public void setEndDate(Timestamp endDate) {
		this.endDate = endDate;
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
