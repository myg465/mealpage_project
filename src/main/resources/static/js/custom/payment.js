/* eslint-disable no-useless-escape */
/* global $, alert, location */

// 총 결제금액 계산
const calculateFinalPrice = () => {
  let totalPrice = $('input[name=totalPrice]').val()
  let deliveryFee = $('input[name=deliveryFee]').val()
  let couponDiscount = $('input[name=couponDiscount]').val()
  let usedPoint = $('input[name=usedPoint]').val()

  if (couponDiscount === undefined) couponDiscount = 0
  if (usedPoint === '') usedPoint = 0

  totalPrice = Number(totalPrice)
  deliveryFee = Number(deliveryFee)
  couponDiscount = Number(couponDiscount)
  usedPoint = Number(usedPoint)

  let finalAmount = totalPrice + deliveryFee - couponDiscount - usedPoint

  $('#finalAmount').html(`${finalAmount.toLocaleString()} 원`)
  $('#totalPriceAmount').html(totalPrice.toLocaleString())
  $('#deliveryFeeAmount').html(deliveryFee.toLocaleString())

  if (couponDiscount > 0) {
    $('#couponDiscountAmount').html(` - 쿠폰할인 ${couponDiscount.toLocaleString()}원`)
    $('#orderCouponAmount').html(`- ${couponDiscount.toLocaleString()}`)

  } else {
    $('#couponDiscountAmount').html('')
    $('#orderCouponAmount').html('- 0')
  }

  if (usedPoint > 0) {
    if (usedPoint > (totalPrice + deliveryFee - couponDiscount)) {
      alert('포인트를 결제할 금액보다 많이 사용할 수 없습니다.')
      $('#pointArea').html('<input type="number" name="usedPoint" class="w134">')
      $('#usedPointAmount').html('')
      $('#orderPointAmount').html('- 0')

      finalAmount = totalPrice + deliveryFee - couponDiscount

      $('#finalAmount').html(`${finalAmount.toLocaleString()} 원`)
    } else {
      $('#usedPointAmount').html(` - 포인트사용 ${usedPoint.toLocaleString()}P`)
      $('#orderPointAmount').html(`- ${usedPoint.toLocaleString()}`)
    }
  } else {
    $('#usedPointAmount').html('')
    $('#orderPointAmount').html('- 0')
  }

  // 쿠폰 사용으로 결제액이 0원 이하로 된 경우
  if (finalAmount < 0) {
    finalAmount = 0
    $('#finalAmount').html('0 원')
  } else {}

  // 적립 포인트 계산
  let savingPoint = 0
  if (finalAmount > deliveryFee) {
    savingPoint = (finalAmount - deliveryFee) / 10
  }

  $('#orderAmount').html(finalAmount.toLocaleString())
  $('#totalPoint').html(savingPoint.toLocaleString())
  $('#orderInput').html(`
    <input type="number" name="finalAmount" value="${finalAmount}" hidden>
    <input type="number" name="finalUsedPoint" value="${usedPoint}" hidden>
    <input type="number" name="finalSavingPoint" value="${savingPoint}" hidden>
  `)
}

calculateFinalPrice()

// 이름, 주소 회원정보 수정
const updateDestination = () => {
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

  // ajax 전송
  $.ajax({
    url: '/payment/update',
    type: 'post',
    data: JSON.stringify({ name: name, addressZipcode: addressZipcode, addressNew: addressNew, addressOld: addressOld, addressDetail: addressDetail, addressExtra: addressExtra}),
    contentType: 'application/json',
    success: data => {
      switch (data.result) {
        case 'pass':
          alert('입력된 이름/주소 정보를 회원정보에 반영하였습니다.')
          break
        default:
          alert('통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: payment.update.default)')
      }
    },
    error: err => {
      // 데이터베이스 오류 메시지 표시
      alert(`통신 중 오류가 발생하였습니다. 잠시 후 다시 시도해주세요.\n오류가 반복될 경우, 고객센터로 문의 부탁드립니다.\n(error_code: payment.update.db.${err})`)
    }
  })
}

// 포인트 사용
const usePoint = () => {
  const accountPoint = Number($('input[name=accountPoint]').val())
  const usedPoint = Number($('input[name=usedPoint]').val())

  if (usedPoint === 0) {
    alert(`사용할 포인트를 입력해주세요.`)
    return
  }

  if (usedPoint > accountPoint) {
    alert(`사용 가능한 포인트 범위 내로 입력해주세요.`)
    $('#pointArea').html('<input type="number" name="usedPoint" class="w134">')
    return
  }
  
  $('#pointArea').html(`
    <input type="number" name="usedPoint" value="${usedPoint}" class="w134" style="background: gainsboro;">
  `)

  calculateFinalPrice()
}

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

// 쿠폰선택 옵션
$('#coupon').change(() => {
  const value = $('#coupon option:selected').val()

  if (value === 'none') {
    $('#couponArea').html(`
      <input name="couponDiscount" value="0" hidden>
    `)
    calculateFinalPrice()
    return
  }

  if (value === 'disable') {
    alert('주문금액 조건이 맞지 않아, 사용할 수 없는 쿠폰입니다.')
    $('#coupon').find('option:eq(0)').prop('selected', true);
    return
  }

  let discount = $('#coupon option:selected').attr('discount')
  const percent = $('#coupon option:selected').attr('percent')

  if (discount > 0) {
    $('#couponArea').html(`
      <span id="couponDiscount">
        ${Number(discount).toLocaleString()}
      </span> <strong>원</strong>
      <input name="couponDiscount" value="${discount}" hidden>
    `)
  } else {
    const totalPrice = $('input[name=totalPrice]').val()
    discount = totalPrice * (percent / 100)

    $('#couponArea').html(`
    <span id="couponDiscount">
    ${Number(discount).toLocaleString()}
      </span> <strong>원</strong>
      <input name="couponDiscount" value="${discount}" hidden>
    `)
  }

  // 쿠폰 사용 시 포인트 입력 취소
  // (포인트 먼저 입력하고 쿠폰 사용 시, 포인트를 필요금액보다 많이 쓰는 경우 방지)
  $('#pointArea').html('<input type="number" name="usedPoint" class="w134">')

  calculateFinalPrice()
})

const submitOrder = () => {
  const name = $('input[name=destName]').val()
  const addressZipcode = $('input[name=destZipcode]').val()
  const addressNew = $('input[name=destRoadAddress]').val()
  const addressOld = $('input[name=destJibunAddress]').val()
  const addressDetail = $('input[name=destDetailAddress]').val()
  const addressExtra = $('input[name=destExtraAddress]').val()
  const phone = $('input[name=destPhone]').val()

  if (name === '' || addressZipcode === '' || addressNew === '' || addressOld === '' || addressDetail === '' || addressExtra === '' || phone === '') {
    alert('수취자 주소 란에 이름, 주소, 휴대폰 번호를 입력해주세요.')
    return
  }

  $('#layer').show()
  form.submit()
}
