//선택한 제품 장바구니에서 삭제
function cart_del(index) {
	console.log(index);
	$.ajax({
        url : "/nonmember/cartDel",
        type : "POST",
        data: JSON.stringify({index:index}),
        contentType: "application/json",
        success : function(data){
           if(data.result == "ok"){
              location.reload();
           }
        },
        error : function(){
           alert("통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: deleteError)");
        }
     });
}
 
//수량 변경에 따른 해당 제품 총합계 변경
function ch1(num){
	
	var id = document.getElementById("num_"+num);
	
	$.ajax({
        url : "/nonmember/quantityModify",
        type : "POST",
        data: JSON.stringify({quantity:id.value,num:num}),
        contentType: "application/json",
        success : function(data){
           if(data.result == "ok"){
        	   itemSum();
           }
        },
        error : function(){
           alert("통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: modifyError)");
        }
     });
	var pri = document.getElementById("pri_"+num);
	$('#stot_'+num).text((pri.value * id.value).toLocaleString()+" 원");
	
	
}

//체크박스 
$("#checkAll").click(function(){
	// 전체 선택 체크박스가 체크된 상태일 경우
	if($('#checkAll').attr('checked')){
		// 해당 화면에 있는 모든 checkbox들 체크
		$('input[name=chk]:checkbox').each(function(){
			$(this).attr('checked', true);
		});
		itemSum();
		
		// 전체 선택 체크박스 해제된 경우
	}else{
		// 해당 화면에 있는 모든 checkbox들 체크 해제
		$('input[name=chk]:checkbox').each(function(){
			$(this).attr('checked', false);
		});
		
		$('#sum1').text("0");
		$('#del_price').text("0");
		$('#tot').text("0");
	}
});
//체크박스(전체선택을 누를경우) 
$(".selectbtn").click(function(){
	// 해당 화면에 있는 모든 checkbox들 체크
	$('#checkAll').attr('checked', true);
	$('input[name=chk]:checkbox').each(function(){
		$(this).attr('checked', true);
		itemSum();
	});
	
});



//선택상품 삭제
function chk_del(){
	
	if(confirm("선택하신 제품을 장바구니에서 삭제하시겠습니까?")){
		var count = $('input:checkbox[name=chk]').length;
		for(var i=count;i>=0;i--){
			if($('input[name=chk]:checkbox').eq(i).is(":checked")==true){
				cart_del($('input[name=chk]:checkbox').eq(i).val());
			}
		};
	}
}

//바로구매
function buyNow(index){

$.ajax({
    	url : "/nonmember/buyNow",
    	type:"POST",
    	data: JSON.stringify({index:index}),
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

//전체상품 주문하기
function orderAll(){
	$('input[name=chk]:checkbox').each(function(){
		$(this).attr('checked', true);
	});
	cartForm.submit();
}



//체크한 상품 총 주문금액 & 적립 포인트
function itemSum(){

var sum = 0;
var del_price=3000;
var count = $('input:checkbox[name=chk]').length;
for(var i=0;i<count;i++){
	if($('input[name=chk]:checkbox').eq(i).is(":checked")==true){
		var stot1=$("#stot_"+i).text();
		var stot2= stot1.substring(0,(stot1.length)-2);
		var stot3= stot2.replace(",","");
		var stot4= parseInt(stot3);
		sum=sum+stot4;
	}
}
console.log(sum);
if(sum>'30000'){
   $("#sum1").text(sum.toLocaleString()+"원");
   $("#del_price").text(0+"원");
   $("#tot").text(sum.toLocaleString()+"원");
}
else{
	$("#sum1").text(sum.toLocaleString()+"원");
	$("#del_price").text(del_price.toLocaleString()+"원");
	$("#tot").text((sum+3000).toLocaleString()+"원");
}
};//itemSum


