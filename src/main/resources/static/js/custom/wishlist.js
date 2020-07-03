/* eslint-disable no-useless-escape */
/* global $, alert, location */

// 결제/주문으로 넘길 상품 정보를 담는다
let orderItems = []

// 레이어 팝업 위치계산
const setLayer = () => {
  const width = 200;
  const height = 30;
  const borderWidth = 2;

  $('#layer').css('width', width + 'px')
  $('#layer').css('height', height + 'px')
  $('#layer').css('border', borderWidth + 'px solid')
  $('#layer').css('left', (((window.innerWidth || document.documentElement.clientWidth) - width) / 2 - borderWidth) + 'px')
  $('#layer').css('top', (((window.innerHeight || document.documentElement.clientHeight) - height) / 2 - borderWidth) + 'px')
}

// 전체상품 선택 시 이벤트 핸들러
$('.selectAll').change(() => {
  if ($('.selectAll').prop('checked')) {
    orderItems = []

    $('input[type=checkbox]').prop('checked', true)
    $('input[class=select]:checked').each(function () {
      const key = $(this).attr('key')
      orderItems.push(key)
    })
  } else {
    $('input[type=checkbox]').prop('checked', false)
    orderItems = []
  }
})

// 상품 선택 시 이벤트 핸들러
$('.select').change(function () {
  const wishlistKey = $(this).attr('key')
  const checkStatus = $(this).prop('checked')

  if (checkStatus === true) {
    orderItems.push(wishlistKey)
  } else {
    const index = orderItems.indexOf(wishlistKey)
    if (index > -1) orderItems.splice(index, 1)
  }
})

// 수량 변화 시 이벤트 핸들러
$('.quantity').change(function () {
  setLayer()
  $('#layer').show()
  const key = $(this).attr('key')
  const quantity = $(this).val()

  $.ajax({
    url: '/wishlist/update',
    type: 'post',
    data: JSON.stringify({ key: key, quantity: quantity }),
    contentType: 'application/json',
    success: data => {
      switch (data.result) {
        case 'pass':
          location.reload()
          break
        default:
          alert('통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: updateWishlist.default)')
      }
    },
    error: err => {
      // 데이터베이스 오류 메시지 표시
      alert(`통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: updateWishlist.db.${err})`)
    }
  })
})

// 상품삭제 버튼 처리
const deleteWishlist = key => {
  $.ajax({
    url: '/wishlist/delete',
    type: 'post',
    data: JSON.stringify({ key: key }),
    contentType: 'application/json',
    success: data => {
      switch (data.result) {
        case 'pass':
          $('#contents').load(window.location.href + '#contents #mypage');
          break
        default:
          alert('통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: deleteWishlist.default)')
      }
    },
    error: err => {
      // 데이터베이스 오류 메시지 표시
      alert(`통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: deleteWishlist.db.${err})`)
    }
  })
}

// 전체선택 버튼 처리
const selectAll = () => {
  orderItems = []

  $('input[type=checkbox]').prop('checked', true)
  $('input[class=select]:checked').each(function () {
    const key = $(this).attr('key')
    orderItems.push(key)
  })
}

// 선택해제 버튼 처리
const deselectAll = () => {
  $('input[type=checkbox]').prop('checked', false)

  orderItems = []
}

// 선택삭제 버튼 처리
const deleteWishlists = () => {
  orderItems.forEach(key => {
    deleteWishlist(key)
  })
}

// 선택상품 내역 전송
const sendItems = () => {
  $.ajax({
    url: '/payment/senditem',
    type: 'post',
    data: {'orderItems': orderItems},
    success: data => {
      switch (data.result) {
        case 'pass':
          location.href = '/payment/wishlist'
          break
        default:
          alert('통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: senditem.default)')
      }
    },
    error: err => {
      // 데이터베이스 오류 메시지 표시
      alert(`통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: senditem.db.${err})`)
    }
  })  
}

// 바로구매 버튼 처리
const buyNow = key => {
  orderItems = [key]

  setLayer()
  $('#layer').html('주문내역 생성 중입니다.')
  $('#layer').show()

  sendItems()
}

// 선택상품 주문 버튼 처리
const orderSelected = () => {
  const checkedNum = $("input:checkbox:checked").length

  if (checkedNum === 0) {
    alert('선택된 상품이 없습니다.')
    return
  }

  setLayer()
  $('#layer').html('주문내역 생성 중입니다.')
  $('#layer').show()

  sendItems()
}

// 전체상품 주문 버튼 처리
const orderAll = () => {
  setLayer()
  $('#layer').html('주문내역 생성 중입니다.')
  $('#layer').show()

  selectAll()
  sendItems()
}
