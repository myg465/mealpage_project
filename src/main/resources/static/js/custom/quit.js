/* eslint-disable no-unused-vars */
/* eslint-disable no-useless-escape */
/* global $, alert, form, location */

// 내용 직접입력란 나타내거나 숨기기
$(function () {
  $("#quitReasonInput").hide();
  $("#quitReason").change(() => {
    if($("#quitReason").val() == "input") {
      $("#quitReasonInput").show();
    } else {
      $("#quitReasonInput").hide();
    }
  }) 
})

// 회원 탈퇴
$('#quitButton').click(() => {
  const id = $('input[name=id]').val()
  const password = $('input[name=password]').val()
  const quitReason = $('select[name=quitReason]').val()
  const quitReasonInput = $('input[name=quitReasonInput]').val()

  // 유효성 검사
  if (id.length < 5 || id.length > 20 || password.length < 8 || password.length > 20) {
    alert('아이디 5~20자, 비밀번호 8~20자 사이로 입력해주세요.')
    return
  }

  // 비밀번호 유형 확인
  let pwType = 0
  const regex1 = /[A-Za-z]/
  const regex2 = /\d/
  const regex3 = /[!@#\$%\^&\*\(\)\-=`~\[\]\\\{\}\|;':",\.<>\?_/]/

  if (regex1.test(password)) pwType++
  if (regex2.test(password)) pwType++
  if (regex3.test(password)) pwType++

  if (pwType < 2) {
    alert('비밀번호는 영문, 숫자, 특수문자 중 2가지 이상의 조합으로 입력해주세요.')
    return false
  }

  // 탈퇴사유 확인
  if (quitReason === '') {
    alert('탈퇴사유를 선택해주세요.')
    return
  }

  if (quitReason === 'input' && quitReasonInput === '') {
    alert('탈퇴사유를 입력해주세요.')
    return
  }

  // ajax 전송
  $.ajax({
    url: '/account/quit',
    type: 'post',
    data: JSON.stringify({ id: id, password: password, quitReason: quitReason, quitReasonInput: quitReasonInput }),
    contentType: 'application/json',
    success: data => {
      switch (data.result) {
        case 'pass':
          alert('회원 탈퇴가 정상적으로 완료되었습니다.\n그동안 밀페이지를 이용해주셔서 감사합니다.')
          location.replace('/')
          break
        case 'fail':
          alert('없는 아이디이거나 비밀번호 입력이 잘못되었습니다.')
          break
        default:
          alert('통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: quit.default)')
      }
    },
    error: err => {
      // 데이터베이스 오류 메시지 표시
      alert(`통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: quit.db.${err})`)
    }
  })
})
