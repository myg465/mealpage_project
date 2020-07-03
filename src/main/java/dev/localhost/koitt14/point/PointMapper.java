package dev.localhost.koitt14.point;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface PointMapper {
  public ArrayList<PointVo> getAddList(Object accountKey);
  public ArrayList<PointVo> getUsedList(Object accountKey);
  public void insertAddPoint(String content, int point, Object accountKey);
  public void insertUsedPoint(String content, int point, Object accountKey);

  public int getAddCount();
  public int getUsedCount();
  public ArrayList<PointVo> getAddListByAdmin(int offset, int rowsPerPage);
  public ArrayList<PointVo> getUsedListByAdmin(int offset, int rowsPerPage);
}
