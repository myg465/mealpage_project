package dev.localhost.koitt14.account;

import java.sql.Timestamp;

public class AccountVo {
  private int seqKey;
  private String id;
  private String password;
  private String name;
  private String email;
  private String emailReception;
  private String phone;
  private String addressZipcode;
  private String addressNew;
  private String addressOld;
  private String addressDetail;
  private String addressExtra;
  private String authority;
  private int point;
  private Timestamp createdDate;
  private Timestamp modifiedDate;
  private int authKey;

  public AccountVo() {}

  public AccountVo(int seqKey, String id, String password, String name, String email, String emailReception,
      String phone, String addressZipcode, String addressNew, String addressOld, String addressDetail,
      String addressExtra, String authority, int point, Timestamp createdDate, Timestamp modifiedDate, int authKey) {
    this.seqKey = seqKey;
    this.id = id;
    this.password = password;
    this.name = name;
    this.email = email;
    this.emailReception = emailReception;
    this.phone = phone;
    this.addressZipcode = addressZipcode;
    this.addressNew = addressNew;
    this.addressOld = addressOld;
    this.addressDetail = addressDetail;
    this.addressExtra = addressExtra;
    this.authority = authority;
    this.point = point;
    this.createdDate = createdDate;
    this.modifiedDate = modifiedDate;
    this.authKey = authKey;
  }

  public int getSeqKey() {
    return seqKey;
  }

  public void setSeqKey(int seqKey) {
    this.seqKey = seqKey;
  }

  public String getId() {
    return id;
  }

  public void setId(String id) {
    this.id = id;
  }

  public String getPassword() {
    return password;
  }

  public void setPassword(String password) {
    this.password = password;
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

  public String getEmailReception() {
    return emailReception;
  }

  public void setEmailReception(String emailReception) {
    this.emailReception = emailReception;
  }

  public String getPhone() {
    return phone;
  }

  public void setPhone(String phone) {
    this.phone = phone;
  }

  public String getAddressZipcode() {
    return addressZipcode;
  }

  public void setAddressZipcode(String addressZipcode) {
    this.addressZipcode = addressZipcode;
  }

  public String getAddressNew() {
    return addressNew;
  }

  public void setAddressNew(String addressNew) {
    this.addressNew = addressNew;
  }

  public String getAddressOld() {
    return addressOld;
  }

  public void setAddressOld(String addressOld) {
    this.addressOld = addressOld;
  }

  public String getAddressDetail() {
    return addressDetail;
  }

  public void setAddressDetail(String addressDetail) {
    this.addressDetail = addressDetail;
  }

  public String getAddressExtra() {
    return addressExtra;
  }

  public void setAddressExtra(String addressExtra) {
    this.addressExtra = addressExtra;
  }

  public String getAuthority() {
    return authority;
  }

  public void setAuthority(String authority) {
    this.authority = authority;
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

  public Timestamp getModifiedDate() {
    return modifiedDate;
  }

  public void setModifiedDate(Timestamp modifiedDate) {
    this.modifiedDate = modifiedDate;
  }

  public int getAuthKey() {
    return authKey;
  }

  public void setAuthKey(int authKey) {
    this.authKey = authKey;
  }
}
