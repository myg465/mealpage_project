// 1:1 문의 입력 폼 유효성 검사
// (HTML5 input 태그에서 미리 걸러내지 못하는 부분만 검사한다)
const checkForm = () => {
  const category = $("select[name=category").val();

  if (category === 'none') {
    alert('분류를 선택해주세요.')
    return false
  }

  return true
}
