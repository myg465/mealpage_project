$(document).ready(function() {
	$("#emailTailDropbox").change(function() {
		var index = document.getElementById("emailTailDropbox").selectedIndex;
		switch(index) {
			case 0:
				$("#nonmemberInquiryEmailTail").val("");
				break;
			case 1: 
				$("#nonmemberInquiryEmailTail").val("naver.com");
				break;
			case 2:
				$("#nonmemberInquiryEmailTail").val("gmail.com");
				break;
			case 3:
				$("#nonmemberInquiryEmailTail").val("hanmail.net");
				break;
			case 4:
				$("#nonmemberInquiryEmailTail").val("nate.com");
				break;
			case 5: 
				$("#nonmemberInquiryEmailTail").val("yahoo.com");
				break;
		}
	});
	
});


// 미로그인 1:1 문의 유효성 검사
function nonmemberinquiryCheck() {
	//이름 유효성 검사
	var nameCheck = /^[a-zA-Z가-힣]{1,}$/;
	
	if(nonmemberInquiryForm.nonmemberInquiryName.value == "") {
		alert("이름을 입력해 주세요.");
		nonmemberInquiryForm.nonmemberInquiryName.focus();
		return false;
	}
 	if(!(nameCheck.test(nonmemberInquiryForm.nonmemberInquiryName.value))) {
 		alert("이름은 영문자, 한글만 가능합니다.");
 		nonmemberInquiryForm.nonmemberInquiryName.focus();
		return false;
 	}
	
	// 이메일 유효성 검사
	var emailTailCheck = /[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
	
	if(nonmemberInquiryForm.nonmemberInquiryEmailHead.value == "") {
		alert("이메일 아이디를 입력해 주세요.");
		nonmemberInquiryForm.nonmemberInquiryEmailHead.focus();
		return false;
	}
	if(nonmemberInquiryForm.nonmemberInquiryEmailTail.value== "") {
		alert("이메일 뒷부분을 입력해 주세요.");
		nonmemberInquiryForm.nonmemberInquiryEmailTail.focus();
		return false;
	}
	if(!(emailTailCheck.test(nonmemberInquiryForm.nonmemberInquiryEmailTail.value))) {
		alert("이메일 뒷부분은 영문/숫자.영문/숫자 형식으로 입력하셔야 합니다.");
		nonmemberInquiryForm.nonmemberInquiryEmailTail.focus();
		return false;
	}
	
	// 연락처 유효성 검사
	var tellCheck = /^[0-9]*$/;
	if(nonmemberInquiryForm.nonmemberInquiryTell.value == "") {
		alert("연락처를 입력해 주세요.");
		nonmemberInquiryForm.nonmemberInquiryTell.focus();
		return false;
	}
	if(nonmemberInquiryForm.nonmemberInquiryTell.value.length > 11) {
		alert("연락처는 숫자만 입력이 가능하며, 최대 11자 입니다.");
		nonmemberInquiryForm.nonmemberInquiryTell.focus();
		return false;
	}
	if(!(tellCheck.test(nonmemberInquiryForm.nonmemberInquiryTell.value))) {		
		alert("연락처는 숫자만 입력이 가능하며, 최대 11자 입니다.");
		nonmemberInquiryForm.nonmemberInquiryTell.focus();
		return false;
	}
	
	// 제목 유효성 검사
	if(nonmemberInquiryForm.nonmemberInquiryTitle.value == "") {
		alert("제목을 입력해 주세요.");
		nonmemberInquiryForm.nonmemberInquiryTitle.focus();
		return false;
	}
	
	// 상세 내용 유효성 검사
	if(nonmemberInquiryForm.nonmemberInquiryContent.value == "") {
		alert("상세 내용을 입력해 주세요.");
		nonmemberInquiryForm.nonmemberInquiryContent.focus();
		return false;
	}
		
	nonmemberInquiryForm.submit();
}
