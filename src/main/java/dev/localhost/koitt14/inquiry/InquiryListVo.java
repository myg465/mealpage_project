package dev.localhost.koitt14.inquiry;

import java.sql.Timestamp;

public class InquiryListVo {
  private int seqKey;
  private String category;
  private String title;
  private Timestamp createdDate;
  private Timestamp replyCreatedDate;

  public InquiryListVo() {}

  public InquiryListVo(int seqKey, String category, String title, Timestamp createdDate, Timestamp replyCreatedDate) {
    this.seqKey = seqKey;
    this.category = category;
    this.title = title;
    this.createdDate = createdDate;
    this.replyCreatedDate = replyCreatedDate;
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
}
