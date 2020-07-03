package dev.localhost.koitt14.account;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AccountMapper {
  public AccountVo selectAccount(Object accountKey);
  public AccountVo selectAccountById(String id);

  public Object getKey(String id);
  public String getId(String name, String email);
  public String getPw(String id, String email);
  public String getPwByKey(Object key);
  public int getPoint(Object key);
  
  public String checkPhone(String phone);
  public String checkId(String id);

  public void insertAccount(String id, String password, String name, String email, String emailReception, String phone, String addressZipcode, String addressNew, String addressOld, String addressDetail, String addressExtra, Object authKey);

  public void updateAccount(String name, String emailReception, String addressZipcode, String addressNew, String addressOld, String addressDetail, String addressExtra, Object key);

  public void updateAccountEmail(String email, Object key);
  public void updateAccountPhone(String phone, Object key);
  public void updateAccountPw(String password, Object key);
  public void updateAccountPwById(int password, String id);
  public void updateDestination(String name, String addressZipcode, String addressNew, String addressOld, String addressDetail, String addressExtra, Object key);
  public void updatePoint(int point, Object key);

  public void deleteAccountById(String id);

  /* 관리자 페이지용 메소드 */
  public int getCount();
  public ArrayList<AccountVo> getList(int offset, int rowsPerPage);
  // 유효성 js
  public void updateAccountByAdmin(String name, String password, String email, String emailReception, String addressZipcode, String addressNew, String addressOld, String addressDetail, String addressExtra, String key);

  // 검색목록 출력
  public ArrayList<AccountVo> searchNameList(String keyword, int offset, int rowsPerPage);
  public int getSearchNameCount(String keyword);

  public ArrayList<AccountVo> searchEmailList(String keyword, int offset, int rowsPerPage);
  public int getSearchEmailCount(String keyword);

  public ArrayList<AccountVo> searchPhoneList(String keyword, int offset, int rowsPerPage);
  public int getSearchPhoneCount(String keyword);
}
