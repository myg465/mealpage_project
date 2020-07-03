/* eslint-disable no-unused-vars */
/* eslint-disable no-useless-escape */
/* global $, alert, form, location */

// 약관 동의 확인
const checkAgreement = () => {
  if (!$('#agree1').prop('checked')) {
    alert('이용약관에 동의하셔야 진행 가능합니다.')
    return
  }

  if (!$('#agree2').prop('checked')) {
    alert('개인정보 수집, 이용에 동의하셔야 진행 가능합니다.')
    return
  }

  if (!$('#agree3').prop('checked')) {
    alert('개인정보 취급위탁에 동의하셔야 진행 가능합니다.')
    return
  }

  form.submit()
}

// 인증코드 발송 후 입력내용 고정
const fixInputForm = (phone, email) => {
  $('#phoneInputArea').html(`
    <ul>
      <li><input type="number" class="input-box" name="phone" value="${phone}" readonly style="background: gainsboro;" /></li>
      <li><input type="email" class="input-box" name="email" value="${email}" readonly style="background: gainsboro;" /></li>
    </ul>

    <div class="btn"><button type="button" class="gbtn no-outline">전송완료</button></div>
  `)
}

// 인증코드 전송
$('#sendButton1').click(() => {
  const phone = $('input[name=phone]').val()
  const email = $('input[name=email]').val()

  // 유효성 검사
  if (phone === '' || email === '') {
    alert('휴대폰 번호 및 이메일 주소를 입력해주세요.')
    return
  }

  if (phone.length !== 11) {
    alert('휴대폰 번호는 숫자 11자로 입력해주세요.')
    return
  }

  const regex = /@/

  if (!regex.test(email)) {
    alert('올바르지 않은 이메일 형식입니다.')
    return
  }

  // ajax 전송
  // 외부 API에 SMS / Email 전송 요청 후, 실제 전송까지 약간 시간이 걸릴 수 있음
  alert('전송 처리에 시간이 걸리니 잠시만 기다려주세요. (최대 10초)')

  $.ajax({
    url: '/account/signup/sendcode',
    type: 'post',
    data: JSON.stringify({ phone: phone, email: email }),
    contentType: 'application/json',
    success: data => {
      switch (data.result) {
        case 'phone_duplicated':
          alert('이미 해당 전화번호로 가입된 계정이 있습니다.')
          break
        case 'resend_email':
          alert('- 오늘 인증번호를 전송한 전화번호입니다. (SMS 인증번호 전송은 하루 1번만 가능합니다.)\n- 입력하신 이메일 주소로 신규 인증코드를 발송하였습니다.')
          fixInputForm(phone, email)
          break
        case 'resend_both':
        case 'send_both':
          alert('입력하신 휴대폰 번호 및 이메일 주소로 신규 인증코드를 발송하였습니다.')
          fixInputForm(phone, email)
          break
        default:
          alert('통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: auth.default)')
      }
    },
    error: err => {
      // 데이터베이스 오류 메시지 표시
      alert(`통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: authdb.${err})`)
    }
  })
})

// 인증코드 확인
$('#sendButton2').click(() => {
  const phone = $('input[name=phone]').val()
  const email = $('input[name=email]').val()
  const phoneCode = $('input[name=phoneCode]').val()
  const emailCode = $('input[name=emailCode]').val()

  // 유효성 검사
  if (phone === '' || email === '') {
    alert('인증받을 휴대폰 번호와 이메일 주소가 입력되지 않았습니다.')
    return
  }

  if (phoneCode.length !== 6 || emailCode.length !== 6) {
    alert('휴대폰 및 이메일에 전송된 숫자 6자리를 각각 입력해주세요.')
    return
  }

  // ajax 전송
  $.ajax({
    url: '/account/signup/checkcode',
    type: 'post',
    data: JSON.stringify({ phone: phone, email: email, phoneCode: phoneCode, emailCode: emailCode }),
    contentType: 'application/json',
    success: data => {
      switch (data.result) {
        case 'phone_duplicated':
          alert('이미 해당 전화번호로 가입된 계정이 있습니다.')
          break
        case 'auth_pass':
          location.replace('/account/signup/detail')
          break
        case 'auth_fail':
          alert('잘못된 인증번호입니다. 확인 후 다시 입력해주세요.')
          break
        default:
          alert('통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: authcheck.default)')
      }
    },
    error: err => {
      // 데이터베이스 오류 메시지 표시
      alert(`통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: authcheck.db.${err})`)
    }
  })
})

// 아이디 중복확인 후 입력내용 고정
const fixIdForm = (id) => {
  $('#idInputArea').html(`
    <li class="r10"><input type="text" class="w134" name="id" value="${id}" readonly style="background: gainsboro;"></li>
    <li><button type="button" class="nbtnMini no-outline">확인완료</button></li>
    <li class="pt5"><span class="mvalign">사용 가능한 아이디입니다.</span></li>
    <input type="text" name="idCheck" value="yes" hidden>
  `)
}

// 아이디 중복확인
$('#sendButton3').click(() => {
  const id = $('input[name=id]').val()

  // 유효성 검사
  if (id.length < 5 || id.length > 20) {
    alert('5~20자 사이로 아이디를 입력해주세요.')
    return
  }

  const regex = /^[a-z0-9]+$/

  if (!regex.test(id)) {
    alert('아이디에는 영문 소문자와 숫자만 사용 가능합니다.')
    return
  }

  // ajax 전송
  $.ajax({
    url: '/account/signup/checkid',
    type: 'post',
    data: JSON.stringify({ id: id }),
    contentType: 'application/json',
    success: data => {
      switch (data.result) {
        case 'unique':
          fixIdForm(id)
          break
        case 'duplicated':
          alert('이미 등록된 아이디입니다. 다른 아이디로 입력해주세요.')
          break
        default:
          alert('통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: idcheck.default)')
      }
    },
    error: err => {
      // 데이터베이스 오류 메시지 표시
      alert(`통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: idcheck.db.${err})`)
    }
  })
})

// 회원가입 폼 유효성 검사
// (아이디 중복확인 함수 및 HTML5 input 태그에서 미리 걸러내지 못하는 부분만 검사한다)
const checkSignup = () => {
  // 아이디 중복확인 여부
  const idCheck = $('input[name=idCheck]').val()
  if (idCheck !== 'yes') {
    alert('아이디 중복확인을 해주세요.')
    return false
  }

  // 비밀번호 대조
  const password = $('input[name=password]').val()
  const passwordCheck = $('input[name=passwordCheck]').val()
  if (password !== passwordCheck) {
    alert('비밀번호가 확인란과 일치하지 않습니다.')
    return false
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
    alert('비밀번호를 영문, 숫자, 특수문자 중 2가지 이상의 조합으로 만들어주세요.')
    return false
  }

  const zipcode = $('input[name=zipcode]').val()
  const roadAddress = $('input[name=roadAddress]').val()
  const jibunAddress = $('input[name=jibunAddress]').val()
  const extraAddress = $('input[name=extraAddress]').val()

  if (zipcode === '' || roadAddress === '' || jibunAddress === '' || extraAddress === '') {
    alert('"우편번호 찾기" 버튼을 이용하여 주소를 검색해주세요.')
    return false
  }

  return true
}
