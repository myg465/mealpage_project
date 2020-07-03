package dev.localhost.koitt14.inquiry;

import java.sql.Timestamp;

public class InquiryAccountListVo {
  private int seqKey;
  private String category;
  private String title;
  private Timestamp createdDate;
  private Timestamp replyCreatedDate;
  private String id;
  private String name;

  public InquiryAccountListVo(int seqKey, String category, String title, Timestamp createdDate,
      Timestamp replyCreatedDate, String id, String name) {
    this.seqKey = seqKey;
    this.category = category;
    this.title = title;
    this.createdDate = createdDate;
    this.replyCreatedDate = replyCreatedDate;
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

  public Timestamp getCreatedDate() {
    return createdDate;
  }

  public void setCreatedDate(Timestamp createdDate) {
    this.createdDate = createdDate;
  }

  public Timestamp getReplyCreatedDate() {
    return replyCreatedDate;
  }

  public void setReplyCreatedDate(Timestamp replyCreatedDate) {
    this.replyCreatedDate = replyCreatedDate;
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
