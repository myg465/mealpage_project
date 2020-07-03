$(document).ready(function (){ // 모두 입금완료시 일괄배송 버튼 활성화
	$("#deliAll").hide();
	
	var count = $('input:hidden[name=status]').length;
	var depositOk = 0;
	for(var i=0;i<count;i++){
		if($('input:hidden[name=status]').eq(i).val()=='배송준비중'){
			depositOk=depositOk+1;
		}
	}
	console.log(depositOk);
	if(depositOk==count){
		$("#deliAll").show();
	}
});
/*입금확인*/
function depositOk(orderNumber){
	
	if(confirm('고객의 결제금액 입금이 확인되었습니까?')){
		$.ajax({
	        url : "/admin/order/nonmember/depositOk",
	        type : "POST",
	        data: JSON.stringify({orderNumber:orderNumber}),
	        contentType: "application/json",
	        success : function(data){
	           if(data.result == "ok"){
	        	  alert("입금확인이 완료되었습니다.");
	              location.reload();
	           }
	        },
	        error : function(){
	           alert("통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: updateError)");
	        }
	     });
	}
}
/*반품등 승인*/
function returnApproval(seqKey,status){
	if(confirm('승인처리 하시겠습니까?')){
		$.ajax({
	        url : "/admin/order/nonmember/returnApproval",
	        type : "POST",
	        data: JSON.stringify({seqKey:seqKey,status:status}),
	        contentType: "application/json",
	        success : function(data){
	           if(data.result == "ok"){
	        	  alert("승인완료되었습니다.");
	              location.reload();
	           }
	        },
	        error : function(){
	           alert("통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: updateError)");
	        }
	     });
	}
}

/*반품등 완료처리*/
function returnSubmit(seqKey,status,productKey,productPrice,quantity){
	if(confirm('완료처리 하시겠습니까?')){
		$.ajax({
	        url : "/admin/order/nonmember/returnSubmit",
	        type : "POST",
	        data: JSON.stringify({seqKey:seqKey,status:status,productKey:productKey,productPrice:productPrice,quantity:quantity}),
	        contentType: "application/json",
	        success : function(data){
	           if(data.result == "ok"){
	        	  alert("완료처리가 되었습니다.");
	              location.reload();
	           }
	        },
	        error : function(){
	           alert("통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: updateError)");
	        }
	     });
	}
}