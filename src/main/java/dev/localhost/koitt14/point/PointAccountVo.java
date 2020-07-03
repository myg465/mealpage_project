package dev.localhost.koitt14.point;

import java.sql.Timestamp;

public class PointAccountVo {
  private int seqKey;
  private String content;
  private int point;
  private Timestamp createdDate;
  private int accountKey;
  private String id;
  private String name;

  public PointAccountVo() {}

  public PointAccountVo(int seqKey, String content, int point, Timestamp createdDate, int accountKey, String id,
      String name) {
    this.seqKey = seqKey;
    this.content = content;
    this.point = point;
    this.createdDate = createdDate;
    this.accountKey = accountKey;
    this.id = id;
    this.name = name;
  }

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

  public int getPoint() {
    return point;
  }

  public void setPoint(int point) {
    this.point = point;
  }

  public Timestamp getCreatedDate() {
    return createdDate;
  }

  public void setCreatedDate(Timestamp createdDate) {
    this.createdDate = createdDate;
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
