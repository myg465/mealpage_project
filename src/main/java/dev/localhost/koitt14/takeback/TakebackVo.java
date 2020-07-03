package dev.localhost.koitt14.takeback;

import java.sql.Timestamp;

public class TakebackVo {
  private int seqKey;
  private String charged;
  private String content;
  private Timestamp createdDate;
  private Timestamp modifiedDate;
  private String reply;
  private Timestamp replyCreatedDate;
  private Timestamp replyModifiedDate;
  private String status;
  private int accountKey;
  private String orderNumber;

  public TakebackVo() {}

  public TakebackVo(int seqKey, String charged, String content, Timestamp createdDate, Timestamp modifiedDate,
      String reply, Timestamp replyCreatedDate, Timestamp replyModifiedDate, String status, int accountKey,
      String orderNumber) {
    this.seqKey = seqKey;
    this.charged = charged;
    this.content = content;
    this.createdDate = createdDate;
    this.modifiedDate = modifiedDate;
    this.reply = reply;
    this.replyCreatedDate = replyCreatedDate;
    this.replyModifiedDate = replyModifiedDate;
    this.status = status;
    this.accountKey = accountKey;
    this.orderNumber = orderNumber;
  }

  public int getSeqKey() {
    return seqKey;
  }

  public void setSeqKey(int seqKey) {
    this.seqKey = seqKey;
  }

  public String getCharged() {
    return charged;
  }

  public void setCharged(String charged) {
    this.charged = charged;
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

  public String getStatus() {
    return status;
  }

  public void setStatus(String status) {
    this.status = status;
  }

  public int getAccountKey() {
    return accountKey;
  }

  public void setAccountKey(int accountKey) {
    this.accountKey = accountKey;
  }

  public String getOrderNumber() {
    return orderNumber;
  }

  public void setOrderNumber(String orderNumber) {
    this.orderNumber = orderNumber;
  }
}
