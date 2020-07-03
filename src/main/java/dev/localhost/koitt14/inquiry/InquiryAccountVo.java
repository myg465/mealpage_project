package dev.localhost.koitt14.inquiry;

import java.sql.Timestamp;

public class InquiryAccountVo {
  private int seqKey;
  private String category;
  private String title;
  private String content;
  private String filename;
  private Timestamp createdDate;
  private Timestamp modifiedDate;
  private String reply;
  private Timestamp replyCreatedDate;
  private Timestamp replyModifiedDate;
  private String id;
  private String name;

  public InquiryAccountVo() {}

  public InquiryAccountVo(int seqKey, String category, String title, String content, String filename,
      Timestamp createdDate, Timestamp modifiedDate, String reply, Timestamp replyCreatedDate,
      Timestamp replyModifiedDate, String id, String name) {
    this.seqKey = seqKey;
    this.category = category;
    this.title = title;
    this.content = content;
    this.filename = filename;
    this.createdDate = createdDate;
    this.modifiedDate = modifiedDate;
    this.reply = reply;
    this.replyCreatedDate = replyCreatedDate;
    this.replyModifiedDate = replyModifiedDate;
    this.id = id;
    this.name = name;
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

  public String getFilename() {
    return filename;
  }

  public void setFilename(String filename) {
    this.filename = filename;
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
