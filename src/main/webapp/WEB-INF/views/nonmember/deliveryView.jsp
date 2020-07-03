<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title> 제품발송 완료 </title>


</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" style="margin:0; padding:0; font:normal 12px/1.5 돋움;">


<table width="700" cellpadding="0" cellspacing="0" align="center">
<c:if test="${delivery.deliveryCompany!=null }">
	<tr>
		<td style="width:700px;height:40px;line-height:40px;padding:0;margin:0;vertical-align:top;background:#d9d9d9;text-align:center;color:#666;">
			택배 송장번호 : <strong style="color:#444;">${delivery.deliveryCompany }(${delivery.trackingNumber })</strong>
		</td>
	</tr>
</c:if>
<tr>
	<td style="width:700px;padding:0;margin:0;vertical-align:top;">
		<p style="width:620px;margin:30px 0 10px 38px;font-size:0;line-height:0;"><img src="/img/temp/email/img_txt_payment03.jpg" alt="구매내역" /></p>
	</td>
</tr>
<tr>
	<td style="width:700px;padding:0;margin:0;vertical-align:top;">
		<table width="620" cellpadding="0" cellspacing="0" align="center" style="margin:0 0 40px 40px;">
		<tr>
			<td colspan="2" style="width:407px;height:40px;padding:0;margin:0;vertical-align:middle;font-size:0;line-height:0;border-top:1px #5b524d solid;border-bottom:1px #5b524d solid;text-align:center;">
				<img src="/img/temp/email/img_txt_payment04.jpg" alt="상품명/옵션" />
			</td>
			<td style="width:100px;height:40px;padding:0;margin:0;vertical-align:middle;font-size:0;line-height:0;border-top:1px #5b524d solid;border-bottom:1px #5b524d solid;text-align:center;">
				<img src="/img/temp/email/img_txt_payment05.jpg" alt="수량" />
			</td>
			<td style="width:113px;height:40px;padding:0;margin:0;vertical-align:middle;font-size:0;line-height:0;border-top:1px #5b524d solid;border-bottom:1px #5b524d solid;text-align:center;">
				<img src="/img/temp/email/img_txt_payment06.jpg" alt="구매일자" />
			</td>
		</tr>
		<!-- 상품정보 -->
		<tr>
			<td colspan="2" style="width:307px;padding:12px 0;margin:0;vertical-align:middle;font-size:12px;line-height:1.2;text-align:center;border-bottom:1px #d9d9d9 solid;">
				<strong>${delivery.productName }</strong>
			</td>
			<td style="width:100px;padding:12px 0;margin:0;vertical-align:middle;font-size:12px;line-height:1;text-align:center;color:#747474;border-bottom:1px #d9d9d9 solid;">
				<strong>${delivery.quantity }</strong>
			</td>
			<td style="width:113px;padding:12px 0;margin:0;vertical-align:middle;font-size:12px;line-height:1;text-align:center;color:#747474;border-bottom:1px #d9d9d9 solid;">
				<strong><fmt:formatDate value="${delivery.createdDate}" pattern="YYYY-MM-dd"/></strong>
			</td>
		</tr>
		</table>	
	</td>
</tr>
<tr>
	<td style="width:700px;padding:0;margin:0;vertical-align:top;">
		<p style="width:620px;margin:0 0 10px 38px;font-size:0;line-height:0;"><img src="/img/temp/email/img_txt_payment07.jpg" alt="결제 내역 및 배송정보" /></p>
	</td>
</tr>
<tr>
	<td style="width:700px;padding:0;margin:0;vertical-align:top;">
		<table width="612" cellpadding="0" cellspacing="0" align="center" style="margin:0 0 20px 40px;border:4px #999999 solid;">
		<tr>
			<td style="width:305px;border-right:1px #dcdcdc solid;">
				<table width="305" cellpadding="0" cellspacing="0" align="center" style="margin:0;">
					<tr>
						<td style="padding:15px 0 5px 19px; color:#888;background:#f9f9f9;">
							<img src="/img/temp/email/arrow.jpg">&nbsp;주문금액
						</td>
						<td style="padding:15px 20px 5px 0;color:#666;text-align:right;background:#f9f9f9;">
							<strong style="color:#888;">
								<fmt:formatNumber value="${delivery.productPrice * delivery.quantity }" type="currency" pattern="#,###,### 원" />
							</strong>
						</td>
					</tr>
					<tr>
						<td style="padding:5px 0 5px 19px; color:#888;background:#f9f9f9;">
							<img src="/img/temp/email/arrow.jpg">&nbsp;배송비
						</td>
						<td style="padding:5px 20px 5px 0;color:#666;text-align:right;background:#f9f9f9;">
							<strong style="color:#888;">
								<fmt:formatNumber value="${delivery.amountDelivery }" type="currency" pattern="#,###,### 원" />
							</strong> 
						</td>
					</tr>
					
					<tr>
						<td style="padding:5px 0 15px 19px; color:#888;background:#f9f9f9;border-top:1px #eeeeee solid;border-bottom:1px #dcdcdc soilid;">
							<img src="/img/temp/email/arrow.jpg">&nbsp;<strong style="color:#444;">총 결제금액</strong>
						</td>
						<td style="padding:5px 20px 15px 0;color:#666;text-align:right;background:#f9f9f9;border-top:1px #eeeeee solid;border-bottom:1px #dcdcdc soilid;">
							<strong style="color:#f7703c;font-size:15px;">
								<fmt:formatNumber value="${delivery.productPrice * delivery.quantity + delivery.amountDelivery }" type="currency" pattern="#,###,### 원" />
							</strong>
						</td>
					</tr>
					<!-- 카드결제 -->
					<tr>
						<td style="padding:20px 0 20px 19px; color:#888;background:#ffffff;border-top:1px #eeeeee solid;border-bottom:1px #dcdcdc soilid;" colspan="2">
							<img src="/img/temp/email/arrow.jpg">&nbsp;결제 수단 : <span style="color:#666;">${delivery.method }</span>  (<strong style="color:#444;">${delivery.status }</strong>)
						</td>
					</tr>
				</table>
			</td>
			<td style="width:306px;vertical-align:top;">
				<table width="306" cellpadding="0" cellspacing="0" align="center" style="margin:0;">
					<tr>
						<td style="width:79px;padding:15px 0 5px 19px; color:#888;">
							<img src="/img/temp/email/arrow.jpg">&nbsp;수령인
						</td>
						<td style="padding:15px 20px 5px 0;color:#666;text-align:left;">
							${delivery.recipientName }
						</td>
					</tr>
					<tr>
						<td style="width:79px;padding:5px 0 5px 19px; color:#888;">
							<img src="/img/temp/email/arrow.jpg">&nbsp;휴대전화
						</td>
						<td style="padding:5px 20px 5px 0;color:#666;text-align:left;">
							${delivery.recipientPhone }
						</td>
					</tr>
					<tr>
						<td style="width:79px;padding:5px 0 5px 19px; color:#888;vertical-align:top;">
							<img src="/img/temp/email/arrow.jpg">&nbsp;배송지
						</td>
						<td style="padding:5px 20px 5px 0;color:#666;text-align:left;">
							<c:if test="${delivery.recipientAddressNew!=null }">
								${delivery.recipientAddressNew } ${delivery.recipientAddressDetail }
							</c:if>
							<c:if test="${delivery.recipientAddressNew==null }">
								${delivery.recipientAddressOld } ${delivery.recipientAddressDetail }
							</c:if>
						</td>
					</tr>
					<tr>
						<td style="width:79px;padding:5px 0 5px 19px; color:#888;">
							<img src="/img/temp/email/arrow.jpg">&nbsp;요구사항
						</td>
						<td style="padding:5px 20px 5px 0;color:#666;text-align:left;">
							${delivery.recipientRequest }
						</td>
					</tr>
				</table>
			</td>
		</tr>
		</table>
	</td>
</tr>

</table>




</body>
</html>