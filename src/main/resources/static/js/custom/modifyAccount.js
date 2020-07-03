/* eslint-disable no-unused-vars */
/* eslint-disable no-useless-escape */
/* global $, alert, form, location */

// 인증번호 발송 후 입력내용 고정 (이메일)
const fixEmail = (email) => {
  $('#emailInputArea').html(`
    <input type="text" name="emailChange" value="yes" hidden>
    <li>
      <input type="email" class="w134" name="email" value="${email}" readonly style="background: gainsboro;">
    </li>
    <li>
      <button type="button" class="nbtnMini no-outline" style="margin-left: 4px; width: 102px;">전송완료</button>
    </li>
  `)
}

// 이메일 인증번호 전송
$('#emailAuthButton').click(() => {
  const authKey = $('input[name=authKey]').val()
  const email = $('input[name=email]').val()
  const originalEmail = $('input[name=originalEmail]').val()

  if (email === originalEmail) {
    alert('이미 인증된 이메일 주소입니다.')
    return
  }

  // 유효성 검사
  if (email === '') {
    alert('이메일 주소가 입력되지 않았습니다.')
    return
  }

  const regex = /@/

  if (!regex.test(email)) {
    alert('올바르지 않은 이메일 형식입니다.')
    return
  }

  // ajax 전송
  // 외부 API에 전송 요청 후, 실제 전송까지 약간 시간이 걸릴 수 있음
  alert('전송 처리에 시간이 걸리니 잠시만 기다려주세요. :)')

  $.ajax({
    url: '/account/modify/emailcode',
    type: 'post',
    data: JSON.stringify({ authKey: authKey, email: email }),
    contentType: 'application/json',
    success: data => {
      switch (data.result) {
        case 'pass':
          alert('입력하신 이메일 주소로 인증번호를 발송하였습니다.')
          fixEmail(email)
          break
        default:
          alert('통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: emailcode.default)')
      }
    },
    error: err => {
      // 데이터베이스 오류 메시지 표시
      alert(`통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: email.authdb.${err})`)
    }
  })
})

// 인증번호 발송 후 입력내용 고정 (휴대폰)
const fixPhone = (phone) => {
  $('#phoneInputArea').html(`
    <input type="text" name="phoneChange" value="yes" hidden>
    <li><input type="text" class="w134" name="phone" value="${phone}" readonly style="background: gainsboro;"></li>
    <li>
      <button type="button" class="nbtnMini no-outline" style="margin-left: 4px; width: 102px;">전송완료</button>
    </li>
    <li class="cb"><span class="mvalign">숫자만 11자리로 입력해주세요.</span></li>
  `)
}

// 휴대폰 인증번호 전송
$('#phoneAuthButton').click(() => {
  const authKey = $('input[name=authKey]').val()
  const phone = $('input[name=phone]').val()
  const originalPhone = $('input[name=originalPhone]').val()

  if (phone === originalPhone) {
    alert('이미 인증된 휴대폰 번호입니다.')
    return
  }

  // 유효성 검사
  if (phone.length !== 11) {
    alert('휴대폰 번호를 11자리로 입력해주세요.')
    return
  }

  // ajax 전송
  // 외부 API에 전송 요청 후, 실제 전송까지 약간 시간이 걸릴 수 있음
  alert('전송 처리에 시간이 걸리니 잠시만 기다려주세요. :)')

  $.ajax({
    url: '/account/modify/phonecode',
    type: 'post',
    data: JSON.stringify({ authKey: authKey, phone: phone }),
    contentType: 'application/json',
    success: data => {
      switch (data.result) {
        case 'pass':
          alert('입력하신 휴대폰 번호로 인증번호를 발송하였습니다.')
          fixPhone(phone)
          break
        case 'today':
          alert('오늘 이미 인증번호를 전송했던 계정입니다. (SMS 인증번호 전송은 하루 1번만 가능합니다.')
          break
        default:
          alert('통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: phonecode.default)')
      }
    },
    error: err => {
      // 데이터베이스 오류 메시지 표시
      alert(`통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: phone.authdb.${err})`)
    }
  })
})

// 수정내용 전송
$('#modifyButton').click(() => {
  /* 이메일 주소 변경처리 시작 */
  const emailChange = $('input[name=emailChange]').val()

  if (emailChange === 'yes') {
    const email = $('input[name=email]').val()
    const emailCode = $('input[name=emailCode]').val()

    $.ajax({
      url: '/account/modify/email',
      type: 'post',
      data: JSON.stringify({ email: email, emailCode: emailCode }),
      contentType: 'application/json',
      success: data => {
        switch (data.result) {
          case 'pass':
            break
          case 'fail':
            alert('이메일 인증번호가 맞지 않습니다.')
            break
          default:
            alert('통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: emailchange.default)')
        }
      },
      error: err => {
        // 데이터베이스 오류 메시지 표시
        alert(`통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: emailchange.db.${err})`)
      }
    })
  }
  /* 이메일 주소 변경처리 끝 */

  /* 휴대폰 번호 변경처리 시작 */
  const phoneChange = $('input[name=phoneChange]').val()

  if (phoneChange === 'yes') {
    const phone = $('input[name=phone]').val()
    const phoneCode = $('input[name=phoneCode]').val()

    $.ajax({
      url: '/account/modify/phone',
      type: 'post',
      data: JSON.stringify({ phone: phone, phoneCode: phoneCode }),
      contentType: 'application/json',
      success: data => {
        switch (data.result) {
          case 'pass':
            break
          case 'fail':
            alert('휴대폰 인증번호가 맞지 않습니다.')
            break
          default:
            alert('통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: phonechange.default)')
        }
      },
      error: err => {
        // 데이터베이스 오류 메시지 표시
        alert(`통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: phonechange.db.${err})`)
      }
    })
  }
  /* 휴대폰 번호 변경처리 끝 */

  /* 비밀번호 변경처리 시작 */
  const newPw = $('input[name=newPw]').val()

  if (newPw !== '') {
    const currentPw = $('input[name=currentPw]').val()
    const newPwCheck = $('input[name=newPwCheck]').val()
  
    // 비밀번호 유효성 검사
    if (currentPw === '') {
      alert('비밀번호 변경을 하려면 기존 비밀번호를 입력해주세요.')
      return
    }
  
    if (newPw.length < 8 || newPw.length > 20) {
      alert('비밀번호는 8~20자 사이로 입력해주세요.')
      return
    }
  
    // 비밀번호 유형 확인
    let pwType = 0
    const regex1 = /[A-Za-z]/
    const regex2 = /\d/
    const regex3 = /[!@#\$%\^&\*\(\)\-=`~\[\]\\\{\}\|;':",\.<>\?_/]/
  
    if (regex1.test(newPw)) pwType++
    if (regex2.test(newPw)) pwType++
    if (regex3.test(newPw)) pwType++
  
    if (pwType < 2) {
      alert('비밀번호를 영문, 숫자, 특수문자 중 2가지 이상의 조합으로 만들어주세요.')
      return
    }
  
    if (newPw !== newPwCheck) {
      alert('신규 비밀번호가 확인란과 일치하지 않습니다.')
      return
    }

    $.ajax({
      url: '/account/modify/password',
      type: 'post',
      data: JSON.stringify({ currentPw: currentPw, newPw: newPw }),
      contentType: 'application/json',
      success: data => {
        switch (data.result) {
          case 'pass':
            break
          case 'fail':
            alert('기존 비밀번호가 맞지 않습니다.')
            break
          default:
            alert('통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: pwchange.default)')
        }
      },
      error: err => {
        // 데이터베이스 오류 메시지 표시
        alert(`통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: pwchange.db.${err})`)
      }
    })
  }
  /* 비밀번호 변경처리 끝 */

  /* 그 외 내용 변경처리 시작 */
  const name = $('input[name=name]').val()

  // 이름 유효성 검사
  if (name === '') {
    alert('이름은 빈 칸으로 둘 수 없습니다.')
    return
  }
  
  const addressZipcode = $('input[name=zipcode]').val()
  const addressNew = $('input[name=roadAddress]').val()
  const addressOld = $('input[name=jibunAddress]').val()
  const addressDetail = $('input[name=detailAddress]').val()
  const addressExtra = $('input[name=extraAddress]').val()

  const emailReception = $('input[name=receive]:checked').val()

  // ajax 전송
  $.ajax({
    url: '/account/modify',
    type: 'post',
    data: JSON.stringify({ name: name, addressZipcode: addressZipcode, addressNew: addressNew, addressOld: addressOld, addressDetail: addressDetail, addressExtra: addressExtra, emailReception: emailReception }),
    contentType: 'application/json',
    success: data => {
      switch (data.result) {
        case 'pass':
          alert('회원정보의 수정 처리가 완료되었습니다.\n(올바르게 입력된 정보만 반영됩니다.)')
          $('html').scrollTop(0);
          break
        default:
          alert('통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: modify.account.default)')
      }
    },
    error: err => {
      // 데이터베이스 오류 메시지 표시
      alert(`통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: modify.account.db.${err})`)
    }
  })
  /* 그 외 내용 변경처리 끝 */
})

// 관리자 수정 폼에 쓰는 메소드 (비밀번호 유효성 검사)
const checkForm = () => {
  const password = $('input[name=password]').val()

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

  return true
}
