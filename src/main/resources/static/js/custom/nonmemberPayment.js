/* eslint-disable no-useless-escape */
/* global $, alert, location */

//유효성 검사
function nonPayCheck(){
	
	var tel_check=/^[0-9]{10,}$/;
	
	if(!(tel_check.test(nonPayForm.phone.value))){
		alert("휴대폰번호를 다시 입력해 주세요.");
		nonPayForm.phone.value="";
		nonPayForm.phone.focus();
		return false;
	}
	if(!(tel_check.test(nonPayForm.destPhone.value))){
		alert("휴대폰번호를 다시 입력해 주세요.");
		nonPayForm.destPhone.value="";
		nonPayForm.destPhone.focus();
		return false;
	}
	
	return true;
	
}


// 총 결제금액 계산
function itemSum(){

var sum = 0;
var count = $('input:hidden[name=length]').length;
var del_price=3000;
for(var i=0;i<count;i++){
	var stot1=$("#tot_"+i).text();
	var stot2= stot1.substring(0,(stot1.length)-2);
	var stot3= stot2.replace(",","");
	var stot4= parseInt(stot3);
	sum=sum+stot4;
	console.log(stot1);
}
console.log(sum);
if(sum>'30000'){
   $(".stot").text(sum.toLocaleString()+"원");
   $(".del_price").text(0+"원");
   $(".tot").text(sum.toLocaleString()+"원");
   $('input[name=totalPrice]').val(sum);
   $('input[name=deliveryFee]').val(0);
   $('input[name=finalAmount]').val(sum);
}
else{
	$(".stot").text(sum.toLocaleString()+"원");
	$(".del_price").text(del_price.toLocaleString()+"원");
	$(".tot").text((sum+3000).toLocaleString()+"원");
	$('input[name=totalPrice]').val(sum);
	$('input[name=deliveryFee]').val(del_price);
	$('input[name=finalAmount]').val(sum + del_price);
}
};//itemSum

itemSum();


// 수취자 주소 자동입력 체크박스
$('input:checkbox').change(() => {
  if ($('#infosame').prop('checked')) {
    // 수취자 주소로 회원정보 복사
    const name = $('input[name=name]').val()
    const addressZipcode = $('input[name=zipcode]').val()
    const addressNew = $('input[name=roadAddress]').val()
    const addressOld = $('input[name=jibunAddress]').val()
    const addressDetail = $('input[name=detailAddress]').val()
    const addressExtra = $('input[name=extraAddress]').val()
    const phone = $('input[name=phone]').val()

    $('input[name=destName]').val(name)
    $('input[name=destZipcode]').val(addressZipcode)
    $('input[name=destRoadAddress]').val(addressNew)
    $('input[name=destJibunAddress]').val(addressOld)
    $('input[name=destDetailAddress]').val(addressDetail)
    $('input[name=destExtraAddress]').val(addressExtra)
    $('input[name=destPhone]').val(phone)
  } else {
    // 수취자 주소입력 리셋
    $('input[name=destName]').val('')
    $('input[name=destZipcode]').val('')
    $('input[name=destRoadAddress]').val('')
    $('input[name=destJibunAddress]').val('')
    $('input[name=destDetailAddress]').val('')
    $('input[name=destExtraAddress]').val('')
    $('input[name=destPhone]').val('')
  }
})

