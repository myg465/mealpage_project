package dev.localhost.koitt14.account;

import java.sql.Timestamp;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AuthMapper {
  public AuthVo selectAuth(String phone);
  public String getEmailCode(String email);
  public String getPhoneCode(String phone);
  public Timestamp getPhoneSendDate(Object key);

  public void insertAuth(String phone, String email, int phoneCode, int emailCode);

  public void updateAuth(String phone, String email, int phoneCode, int emailCode, int key);
  public void updateAuthEmail(String email, int emailCode, int key);
  public void updateAuthPhone(String phone, int phoneCode, int key);

  public void deleteAuth(String phone);

}
