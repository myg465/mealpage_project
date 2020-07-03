package dev.localhost.koitt14.nonmember;

import java.sql.Timestamp;

public class NonmemberReturnVo {

	public NonmemberReturnVo() {}
	
	public NonmemberReturnVo(int seqKey, String content, Timestamp createdDate, Timestamp modifiedDate, String reply,
			Timestamp replyCreatedDate, Timestamp replyModifiedDate, int nonmemberOrderKey) {
		super();
		this.seqKey = seqKey;
		this.content = content;
		this.createdDate = createdDate;
		this.modifiedDate = modifiedDate;
		this.reply = reply;
		this.replyCreatedDate = replyCreatedDate;
		this.replyModifiedDate = replyModifiedDate;
		this.nonmemberOrderKey = nonmemberOrderKey;
	}

	int seqKey; //반품 등 신청 일련번호
	String content; //사유
	Timestamp createdDate; //신청일
	Timestamp modifiedDate; //수정일
	String reply; //관리자 답변
	Timestamp replyCreatedDate; //답변등록일
	Timestamp replyModifiedDate; //답변수정일
	int nonmemberOrderKey; //비회원 주문 일련번호 (주문번호 아님)
	
	
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
	public int getNonmemberOrderKey() {
		return nonmemberOrderKey;
	}
	public void setNonmemberOrderKey(int nonmemberOrderKey) {
		this.nonmemberOrderKey = nonmemberOrderKey;
	}
	
	
	
}
