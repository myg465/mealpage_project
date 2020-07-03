const checkForm = () => {
  const content = $('.reasontta').val()
  
  if (content === '') {
    alert('반품/교환 사유를 작성해주세요.')
    return
  }

  form.submit()
}

const checkReplyForm = () => {
  const reply = $('.reply').val()
  
  if (reply === '') {
    alert('관리자 회신을 작성해주세요.')
    return
  }

  form.submit()
}
