<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
	<%@ include file="../common/head.jsp" %>
	<link rel="stylesheet" type="text/css" href="/css/custom/productDetail.css" />
</head>
<body>
<%@ include file="../common/explorer.jsp" %>
<div id="allwrap">
<div id="wrap">
	<%@ include file="../common/header.jsp" %>
	<%@ include file="../common/nav.jsp" %>
	<c:choose>
		<c:when test="${param.productFlag=='nmCart' }">
			<script type="text/javascript">
				var check=confirm("장바구니에 상품이 추가되었습니다.\n 장바구니로 이동하시겠습니까?");
				if(check){
					window.location.href="/nonmember/cartList";
				}
			</script>
		</c:when>
		<c:when test="${param.productFlag=='mCart' }">
			<script type="text/javascript">
				var check=confirm("장바구니에 상품이 추가되었습니다.\n 장바구니로 이동하시겠습니까?");
				if(check){
					window.location.href="/cart";
				}
			</script>
		</c:when>
		<c:when test="${param.productFlag=='mWishList' }">
			<script type="text/javascript">
				var check=confirm("찜한목록에 상품이 추가되었습니다.\n 찜한목록으로 이동하시겠습니까?");
				if(check){
					window.location.href="/wishlist";
				}
			</script>
		</c:when>
	</c:choose>
	<c:set var="detail" value="${productDetail }"/>
	<!-- container -->
	<div id="container">

		<div id="location">
			<ol>
				<li><a href="#">HOME</a></li>
				<li>${detail.category1 }</li>
				<li class="last">${detail.category2 }</li>
			</ol>
		</div>
					
		<!-- maxcontents -->
		<div id="maxcontents">
		<!-- product -->
			<div id="pDetail">
				
				<!-- Slide -->
				<div class="imgSlide">
					<div class="img">
						<ul>
							<c:if test="${detail.detailImageFilename1!=null }">
								<li><img src="/files/product/${detail.detailImageFilename1 }" alt="제품이미지" width="347px" height="347px"/></li>
							</c:if>
							<c:if test="${detail.detailImageFilename2!=null }">
								<li><img src="/files/product/${detail.detailImageFilename2 }" alt="제품이미지" width="347px" height="347px"/></li>
							</c:if>
							<c:if test="${detail.detailImageFilename3!=null }">
								<li><img src="/files/product/${detail.detailImageFilename3 }" alt="제품이미지" width="347px" height="347px"/></li>
							</c:if>
						</ul>
					</div>

					<div class="thum">
						<ul>
							<c:if test="${detail.detailImageFilename1!=null }">
								<li><img src="/files/product/${detail.detailImageFilename1 }" alt="썸네일 제품이미지" /></li>
							</c:if>
							<c:if test="${detail.detailImageFilename2!=null }">
								<li><img src="/files/product/${detail.detailImageFilename2 }" alt="썸네일 제품이미지" /></li>
							</c:if>
							<c:if test="${detail.detailImageFilename3!=null }">
								<li><img src="/files/product/${detail.detailImageFilename3 }" alt="썸네일 제품이미지" /></li>
							</c:if>
						</ul>
					</div>
				</div>
				<!-- //Slide -->
				
				<!-- info -->
				<div class="info">
					<p class="title">
						<span>[${detail.category2 }]</span>
						${detail.name }
					</p>
					<form name="detailForm" action="#" method="post" onsubmit="return stockCheck();">
					
						<!-- 주문시 같이 넘어갈값 설정 -->
						<input type="hidden" name="productKey" value="${detail.seqKey }">
						<input type="hidden" name="accountKey" id="accountKey" value="${accountKey }">
						<div class="priceInfo">
							<ul>
								<li>
									<div class="stit">판매가</div> 
									<div class="heavygray">
										<strong>
											<del style="font-size: 14px; color: red;">
												<fmt:formatNumber value="${(detail.price * ((detail.salePercent / 100)+1)) }" type="currency" pattern="#,###,### 원" />
											</del>
										</strong>
										&nbsp;&nbsp;&nbsp;
										<strong style="font-size: 14px; color: darkblue;">
											<fmt:formatNumber value="${detail.price }" type="currency" pattern="#,###,### 원" />
										</strong>
									</div>
								</li>
								<li>
									<!-- 포인트 정책이 상의되면 표시예정 -->
									<div class="stit">포인트</div> 
									<div class="orange">
										<strong>
											<fmt:formatNumber value="${(detail.price*0.1)+(1-((detail.price*0.1)%1))%1}" type="currency" pattern="#,###,### 포인트" />
										</strong>
									</div>
								</li>
								<li>
									<div class="stit">칼로리</div> 
									<div>
										<fmt:formatNumber value="${detail.calorie }" pattern="#,###,### kcal" />
									</div>
								</li>
								<li>
									<div class="stit">용량</div> 
									<div>${detail.volume }</div>
								</li>
								<li>
									<div class="stit">수량</div> 
									<div class="num">
										<input type="number" name="quantity" id="quantity" min="1" value="1" class="quantity" onchange="totalCal('<c:out value="${detail.price}"/>')"/>
										<span class="stock">(주문가능 수량 : ${detail.stock } 개)</span>
									</div>
								</li>
								<li>
									<div class="stit">평점</div> 
									<div>
										<c:forEach begin="1" end="${gradeAvg }">
											<img src="/img/temp/ico/ico_star.gif" alt="별점" />
										</c:forEach>
										<c:forEach begin="1" end="${5-gradeAvg }">
											<img src="/img/temp/ico/ico_star_off.gif" alt="별점" />
										</c:forEach>
									</div>
								</li>
								<li>
									<div class="totalText">총금액</div>
									<span class="totalPrice"><fmt:formatNumber value="${detail.price }" type="currency" pattern="#,###,### 원" /></span>
								</li>
							</ul>
						</div>
						
						<c:if test="${detail.stock>0 }">
							<!-- 판매중 -->
							<div class="infobtn">
								<ul>
									<!-- 바로구매 -->
									<c:if test="${accountKey!=null }">
										<li><a href="#" class="ty1" onclick="memberBuyNow();">바로 구매하기</a></li>
									</c:if>
									<c:if test="${accountKey==null }">
										<li><a href="#" class="ty1" onclick="nonmemberBuyNow();" style="width:170px;">바로 구매하기</a></li>
									</c:if>
									<!-- 장바구니 -->
									<c:if test="${accountKey!=null }">
										<li><input type="submit" class="ty2" value="장바구니 담기" onclick="javascript: form.action='/mypage/cartAdd';"/></li>
									</c:if>
									<c:if test="${accountKey==null }">
										<li><input type="submit" class="ty2" value="장바구니 담기" style="width:170px; margin-left:40px;" onclick="javascript: form.action='/nonmember/cartAdd';"/></li>
									</c:if>
									<!-- 위시리스트 -->
									<c:if test="${accountKey!=null }">
										<li class="last"><input type="submit" class="ty3" value="찜한목록 추가" onclick="javascript: form.action='/mypage/wishlistAdd';"/></li>
									</c:if>
								</ul>
							</div>
							<!-- //판매중 -->
						</c:if>
					</form>
					<c:if test="${detail.stock<=0 }">
						<!-- 판매중지 -->
						<div class="endbtn" style="display:display: ;">
							<ul>
								<li><a href="#" style="cursor: default;">판매중지</a></li>
								<li><a href="#" style="cursor: default;">SOLD OUT</a></li>
							</ul>
						</div>
						<!-- //판매중지 -->
					</c:if>

				</div>
				<!-- //info -->

			</div>
		<!-- //product -->
		
			<!-- 관련상품 url만들기 -->
			<c:set var="relationProductUrl" value="${detail.category1 }/${detail.category2 }" />
			<!-- tab -->
			<div class="detailTab">
				<ul>
					<li class="dep">
						<a href="javascript:;" onclick="open_in_frame('/product/detailContent/');"
						id="detailInfo">상품상세 정보
						</a>
					</li>
					<li>
						<a href="javascript:;" 
						onclick="open_in_frame('/product/relationProduct/');" 
						id="goodsRelation">관련상품
						</a>
					</li>
					<li class="dep">
						<a href="javascript:;" onclick="open_in_frame('/review/reviewList/')" 
						id="goodsReview">상품리뷰
							<span>(${reviewListCount })</span>
						</a>
					</li>
					<li>
						<a href="javascript:;" onclick="open_in_frame('/productInquiry/inquiryList/')"
						id="goodsQna">질문과 답변 
							<span>(${inquiryListCount })</span>
						</a>
					</li>
					<li class="last">
						<a href="javascript:;" onclick="open_in_frame('/product/productNotice/')" 
						id="goodsNotice">정책 및 공지
						</a>
					</li>
				</ul>
			</div>
			<script type="text/javascript">$(function(){$(".detailTab ul li a:eq(0)").click();});</script>
			<!-- //tab -->
					<!-- iframe -->
					<iframe src="" 
					id="tabIframe" onload="calcHeight();" frameborder="0" scrolling="no" style="overflow-x:hidden; overflow:auto; width:100%; min-height:800px;"></iframe>
		</div>
			
	</div>
		<!-- //container -->

</div>
<!-- //wrap -->
</div>
<!-- //allwrap -->

<%@ include file="../common/footer.jsp" %>

<script type="text/javascript" src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<script type="text/javascript" src="/js/temp/jquery.fancybox-1.3.4.pack.js"></script>
<script type="text/javascript" src="/js/custom/product.js"></script>
<link rel="stylesheet" type="text/css" href="/css/temp/jquery.fancybox-1.3.4.css" />
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
<style type="text/css">
.ui-corner-all{border-bottom-right-radius:0 !important; border-bottom-left-radius:0 !important; border-top-left-radius:0 !important; border-top-right-radius:0 !important;}
.ui-widget-content{border:0;}
.ui-spinner-input{width:70px; margin:0; border:1px #ddd solid; padding:2px 0 2px 5px; font-family:'Nanum Gothic' !important; font-size:12px !important;}
</style>

<script>

//iframe url change 
var url;
function open_in_frame(url) {
	//url 클릭시 자동으로 상품키값을 주입해줌
	if(url!='/product/relationProduct/'){
		url=url+'${productDetail.seqKey}';
		};
	if(url=='/product/relationProduct/'){
		url=url+'${relationProductUrl}';
		};
	
	
	$('#tabIframe').attr('src', url);
	
}
//iframe 자동 사이즈 계산
function calcHeight(){

 var the_height=
 document.getElementById('tabIframe').contentWindow.
 document.body.scrollHeight;
 
 document.getElementById('tabIframe').height=
 the_height;

 document.getElementById('tabIframe').style.overflow = "hidden";
};

//주문수량이 재고량이내인지 확인
function stockCheck(){
	
	if(detailForm.quantity.value>${detail.stock}){
		alert("입력가능수량을 초과하였습니다.");
		return false;
	};
	return true;
};
// 수량 변경에 따른 해당 제품 총합계 변경
function totalCal(price){
  
  var id = document.getElementById("quantity");
  $('.totalPrice').text((price * id.value).toLocaleString()+'원');
  
};
// 비회원 바로구매
function nonmemberBuyNow(){
	var productKey=${detail.seqKey};
	var quantity=$("#quantity").val();
	$.ajax({
	    	url : "/nonmember/detailBuyNow",
	    	type:"POST",
	    	data: JSON.stringify({productKey:productKey,quantity:quantity}),
	     	contentType: "application/json",
	        success : function(data){
	                    if(data.result == "ok"){
	                   window.location.href="/nonmemberPayment/payment";
	    	       	}
	        	  },
		    error:function(){
				alert("서버통신실패");
			  }
	});
};
// 선택상품 내역 전송(출처:회원 카트js)
const sendItems = () => {
  $.ajax({
    url: '/payment/senditem',
    type: 'post',
    data: {'orderItems': orderItems},
    success: data => {
      switch (data.result) {
        case 'pass':
          location.href = '/payment'
          break
        default:
          alert('통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: senditem.default)')
      }
    },
    error: err => {
      // 데이터베이스 오류 메시지 표시
      alert(`통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: senditem.db.${err})`)
    }
  });
};

// 바로구매 버튼 처리(출처:회원 카트js)
const buyNow = key => {
  orderItems = [key]

  sendItems();
};
//회원 바로구매
function memberBuyNow(){
	var productKey=${detail.seqKey};
	var quantity=$("#quantity").val();
	var accountKey=$("#accountKey").val();
	$.ajax({
    	url : "/mypage/buyNow",
    	type:"POST",
    	data: JSON.stringify({productKey:productKey,quantity:quantity,accountKey:accountKey}),
     	contentType: "application/json",
        success : function(data){
                    if(data.result == "ok"){
                   buyNow(data.cartSeqKey);
    	       	}
        	  },
	    error:function(){
			alert("서버통신실패");
		}
	});
};

</script>

	

</body>
</html>