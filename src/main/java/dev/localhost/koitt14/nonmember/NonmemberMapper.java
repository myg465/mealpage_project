package dev.localhost.koitt14.nonmember;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface NonmemberMapper {

	//----------------------------------------로그인-----------------------------------------------------------------
	public String nonmemberLogin(String nonmemberName, String orderNumber);
	//---------------------------------------주문내역-----------------------------------------------------------------
	public ArrayList<NonmemberOrderVo> nonmemberOrderList(String nonmemberName, String orderNumber);
	public ArrayList<NonmemberOrderVo> nonmemberOrderListAll(String nonmemberName, String orderNumber, int startRow, int limit);
	public int getNonmemberOrderListCount(String nonmemberName, String orderNumber);
	public int getTotalPrice(String nonmemberName, String orderNumber);
	public NonmemberPayAndOrderVo nonmemberDeliveryView(int seqKey);
	//--------------------------------------반품교환내역---------------------------------------------------------------
	public NonmemberOrderVo takebackStateList(String orderNumber, String nonmemberName) ;//
	public int TakebackStateListCount(String orderNumber, String nonmemberName);
	public int totalTakebackPrice(String orderNumber, String nonmemberName);
	public ArrayList<NonmemberOrderVo> takebackStateListAll(String orderNumber, String nonmemberName, int startRow,int limit);
	public NonmemberReturnVo takebackReasonView(int seqKey); //사유보기
	public Integer getOrderKey(int seqKey);//주문일련번호 얻어오기
	public NonmemberPayAndReturnVo nonmemberRefundView(int orderKey);
	
	//---------------------------------------반품교환신청---------------------------------------------------------------
	public int orderStateChange(int seqKey, String category); //주문 상태를 바꿈
	public int takebackWrite(int seqKey, String content); //반품 교환 테이블에 삽입
	public int takebackReasonModify(int seqKey,String content); //사유수정하기
	
	//---------------------------------------관리자 전용----------------------------------------------------------------
	//주문수 얻기(전체 게시물수)
	public int orderListSearchCount(String search);
	//주문수 얻기(전체 게시물수 - 메인표시용)
	public int orderStateSearchCount(String search);
	//주문현황 얻기
	public ArrayList<NonmemberAdminOrderVo> orderListAll(int orderStartRow,String search,String sqlOrder); 
	//반품 등 사유 답변달기
	public int reasonReplyWrite(String reply, int seqKey);
	//반품 등 사유 답변수정
	public int reasonReplyModify(String replyModify, int seqKey);
	//반품테이블 고유번호 얻기
	public int getReturnKey(int seqKey);
	
	
	
}
