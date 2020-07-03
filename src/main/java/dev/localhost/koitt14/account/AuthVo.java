package dev.localhost.koitt14.account;

import java.sql.Timestamp;

public class AuthVo {
  private int seqKey;
  private String phone;
  private String email;
  private String phoneCode;
  private String emailCode;
  private Timestamp phoneSendDate;
  private Timestamp emailSendDate;

  public AuthVo(int seqKey, String phone, String email, String phoneCode, String emailCode, Timestamp phoneSendDate,
      Timestamp emailSendDate) {
    this.seqKey = seqKey;
    this.phone = phone;
    this.email = email;
    this.phoneCode = phoneCode;
    this.emailCode = emailCode;
    this.phoneSendDate = phoneSendDate;
    this.emailSendDate = emailSendDate;
  }

  public int getSeqKey() {
    return seqKey;
  }

  public void setSeqKey(int seqKey) {
    this.seqKey = seqKey;
  }

  public String getPhone() {
    return phone;
  }

  public void setPhone(String phone) {
    this.phone = phone;
  }

  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
  }

  public String getPhoneCode() {
    return phoneCode;
  }

  public void setPhoneCode(String phoneCode) {
    this.phoneCode = phoneCode;
  }

  public String getEmailCode() {
    return emailCode;
  }

  public void setEmailCode(String emailCode) {
    this.emailCode = emailCode;
  }

  public Timestamp getPhoneSendDate() {
    return phoneSendDate;
  }

  public void setPhoneSendDate(Timestamp phoneSendDate) {
    this.phoneSendDate = phoneSendDate;
  }

  public Timestamp getEmailSendDate() {
    return emailSendDate;
  }

  public void setEmailSendDate(Timestamp emailSendDate) {
    this.emailSendDate = emailSendDate;
  }
}
