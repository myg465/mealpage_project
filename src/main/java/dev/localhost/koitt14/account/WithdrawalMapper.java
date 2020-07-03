package dev.localhost.koitt14.account;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface WithdrawalMapper {
  public void insertWithdrawal(Object accountKey, String id, String quitReason);
}
