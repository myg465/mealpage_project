package dev.localhost.koitt14.takeback;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface TakebackMapper {
  public ArrayList<TakebackOrderVo> getList(Object accountKey, int offset, int rowsPerPage);
  public int getCount(Object accountKey);

  public TakebackVo selectTakeback(String key, Object accountKey);
  public int selectRecentTakeback(String orderNumber, Object accountKey);

  public void insertTakeback(String charged, String content, String status, String orderNumber, Object accountKey);
  public void deleteTakeback(int key, Object accountKey);

  /* 관리자용 메소드 시작 */
  public TakebackVo selectTakebackByAdmin(String orderNumber);
  public void updateTakeback(String reply, String status, String key);
}
