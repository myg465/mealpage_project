/* eslint-disable no-useless-escape */
/* global $, alert, location */

// 로그인
$('#loginButton').click(() => {
  const id = $('input[name=id]').val()
  const password = $('input[name=password]').val()
  const idsave = $('#idsave').prop('checked')

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

  // ajax 전송
  $.ajax({
    url: '/account/login',
    type: 'post',
    data: JSON.stringify({ id: id, password: password, idsave: idsave }),
    contentType: 'application/json',
    success: data => {
      switch (data.result) {
        case 'pass':
          location.replace('/')
          break
        case 'fail':
          alert('가입하지 않은 아이디이거나, 잘못된 비밀번호입니다.')
          break
        default:
          alert('통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: login.default)')
      }
    },
    error: err => {
      // 데이터베이스 오류 메시지 표시
      alert(`통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: login.db.${err})`)
    }
  })
})

// 비회원 주문조회
$('#orderCheckButton').click(() => {
  const orderName = $('input[name=orderName]').val()
  const orderNumber = $('input[name=orderNumber]').val()

  // 유효성 검사
  if (orderName === '' || orderNumber === '') {
    alert('주문자명과 주문번호를 입력해주세요.')
    return
  }

  // ajax 전송
  $.ajax({
    url: '/nonmember/login',
    type: 'post',
    data: JSON.stringify({ nonmemberName: orderName, orderNumber: orderNumber }),
    contentType: 'application/json',
    success: data => {
      switch (data.result) {
        case 'pass':
          alert("비회원으로 로그인 하셨습니다. \n공용컴퓨터 사용시에는 보안을 위해 로그아웃을 꼭 해주시기 바랍니다.")
          location.replace(`/nonmember/ordercheck`)
          break
        case 'fail':
          alert('주문자명 혹은 주문번호가 잘못되었습니다.')
          break
        default:
          alert('통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: nonmember.login.default)')
      }
    },
    error: err => {
      // 데이터베이스 오류 메시지 표시
      alert(`통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: nonmember.login.db.${err})`)
    }
  })
})
