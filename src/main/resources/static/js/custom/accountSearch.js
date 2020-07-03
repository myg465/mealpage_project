/* eslint-disable no-useless-escape */
/* global $, alert */

// 아이디 찾기
$('#idSearchButton').click(() => {
  const name = $('input[name=name]').val()
  const email = $('input[name=email]').val()

  // 유효성 검사
  if (name === '' || email === '') {
    alert('이름 및 이메일을 입력해주세요.')
    return
  }

  const regex = /@/

  if (!regex.test(email)) {
    alert('올바르지 않은 이메일 형식입니다.')
    return
  }

  // ajax 전송
  $.ajax({
    url: '/account/search/id',
    type: 'post',
    data: JSON.stringify({ name: name, email: email }),
    contentType: 'application/json',
    success: data => {
      switch (data.result) {
        case 'pass':
          alert('입력하신 이메일로 아이디를 전송하였습니다.')
          break
        case 'fail':
          alert('해당 이름 및 이메일로 검색되는 아이디가 없습니다.')
          break
        default:
          alert('통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: idsearch.default)')
      }
    },
    error: err => {
      // 데이터베이스 오류 메시지 표시
      alert(`통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: idsearch.db.${err})`)
    }
  })
})

// 비밀번호 찾기
$('#pwSearchButton').click(() => {
  const id = $('input[name=id]').val()
  const email2 = $('input[name=email2]').val()

  // 유효성 검사
  if (id === '' || email2 === '') {
    alert('아이디 및 이메일을 입력해주세요.')
    return
  }

  // 아이디 글자수 검사
  if (id < 5 || id > 20) {
    alert('아이디는 5~20자 이내로 입력해주세요.')
    return
  }

  const regex = /@/

  if (!regex.test(email2)) {
    alert('올바르지 않은 이메일 형식입니다.')
    return
  }

  // ajax 전송
  $.ajax({
    url: '/account/search/pw',
    type: 'post',
    data: JSON.stringify({ id: id, email: email2 }),
    contentType: 'application/json',
    success: data => {
      switch (data.result) {
        case 'pass':
          alert('입력하신 이메일로 임시 비밀번호를 전송하였습니다.')
          break
        case 'fail':
          alert('해당 아이디 및 이메일로 검색되는 비밀번호가 없습니다.')
          break
        default:
          alert('통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: pwsearch.default)')
      }
    },
    error: err => {
      // 데이터베이스 오류 메시지 표시
      alert(`통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: pwsearch.db.${err})`)
    }
  })
})

const checkAdminSearch = () => {
  const searchType = $("select[name=searchType]").val()
  const searchInput = $("input[name=searchText]").val()

  if (searchType === "phone") {
    const regex = /^[0-9]+$/

    if (!regex.test(searchInput)) {
      alert('전화번호는 숫자만 입력해주세요')
      return false
    }
  }

  return true
}
