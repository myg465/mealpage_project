-- 템플릿 구현용 임시 테이블
CREATE TABLE template (
  seq_key INT AUTO_INCREMENT PRIMARY KEY,
  value VARCHAR(255)
);

INSERT INTO template (value) VALUES ('VALUE 1');
INSERT INTO template (value) VALUES ('VALUE 2');
INSERT INTO template (value) VALUES ('VALUE 3');
INSERT INTO template (value) VALUES ('값 4');
INSERT INTO template (value) VALUES ('값 5');

-- 상품
CREATE TABLE product (
  seq_key INT AUTO_INCREMENT PRIMARY KEY,
  category1 VARCHAR(255),
  category2 VARCHAR(255),
  name VARCHAR(255), -- 제품명
  price INT,
  stock INT, -- 재고 수
  calorie INT,
  type VARCHAR(255), -- 식품의 유형
  productor VARCHAR(255), -- 생산자 및 소재지
  importer VARCHAR(255), -- 수입자
  import_declaration VARCHAR(255), -- 식품위생법에 따른 수입신고필 여부
  use_by_date VARCHAR(255), -- 제조연원일 및 유통기한
  volume VARCHAR(255), -- 포장단위별 용량(수량)
  raw_materials VARCHAR(255), -- 원재료명 및 함량
  nutrients VARCHAR(255), -- 영양성분표시
  gm_food VARCHAR(255), -- 유전자재조합 식품 여부
  cs_phone VARCHAR(255), -- 소비자상담 전화번호
  recommend CHAR(1) DEFAULT 'N', -- 추천상품 여부
  new CHAR(1) DEFAULT 'N', -- 신규상품 여부
  sale_percent INT DEFAULT 0, -- 세일상품 여부 (할인율 0% = 세일상품 아님)
  detail_image_filename1 VARCHAR(255), -- 상품 이미지 1 (목록 대표이미지로도 쓰임)
  detail_image_filename2 VARCHAR(255),
  detail_image_filename3 VARCHAR(255),
  content_text VARCHAR(10000),
  content_image_filename VARCHAR(255)
);

-- 관련상품란 삭제 (미구현)

-- 상품리뷰 (포토/일반 구분 없이 하나의 테이블로)
CREATE TABLE user_review (
  seq_key INT AUTO_INCREMENT PRIMARY KEY,
  content VARCHAR(10000),
  grade INT,
  image_filename VARCHAR(255),
  created_date TIMESTAMP DEFAULT NOW(),
  modified_date TIMESTAMP,

  product_key INT REFERENCES product (seq_key),
  account_key INT REFERENCES account (seq_key)
);

-- COMMUNITY 메뉴 삭제 (미구현)

-- 상품 내 질문과 답변
-- 질문은 제목 없이 내용만 작성
-- 관리자만 답변 가능 (1개)
CREATE TABLE product_inquiry (
  seq_key INT AUTO_INCREMENT PRIMARY KEY,
  content VARCHAR(10000),
  created_date TIMESTAMP DEFAULT NOW(),
  modified_date TIMESTAMP,
  secret CHAR(1),
  reply VARCHAR(10000),
  reply_created_date TIMESTAMP,
  reply_modified_date TIMESTAMP,

  product_key INT REFERENCES product (seq_key),
  account_key INT REFERENCES account (seq_key)
);

-- 이벤트 (세부 메뉴 쓰지 않음)
-- 답글 기능 쓰지 않음
CREATE TABLE event (
  seq_key INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255),
  title_image_filename VARCHAR(255),
  content VARCHAR(10000),
  content_image_filename VARCHAR(255),
  start_date TIMESTAMP, -- 이벤트 시작일
  end_date TIMESTAMP, -- 이벤트 종료일
  created_date TIMESTAMP DEFAULT NOW(),
  modified_date TIMESTAMP,

  account_key INT REFERENCES account (seq_key)
);

-- 공지사항
CREATE TABLE notice (
  seq_key INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255),
  content VARCHAR(10000),
  content_image_filename VARCHAR(255),
  created_date TIMESTAMP DEFAULT NOW(),
  modified_date TIMESTAMP,

  account_key INT REFERENCES account (seq_key)
);

-- 고객센터 > 1:1 문의 (미로그인 방문자가 문의할 수 있는 폼으로 만듬)
-- ref. https://www.shopintake.com/inquiry/
-- 로그인 방문자의 1:1 문의는 마이페이지에서 (로그인 후 고객센터 > 1:1 문의 방문 시 마이페이지의 게시판 띄움)
CREATE TABLE nonmember_inquiry (
  seq_key INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255),
  email VARCHAR(255),
  phone VARCHAR(255),
  title VARCHAR(255),
  content VARCHAR(10000),
  filename VARCHAR(255),
  created_date TIMESTAMP DEFAULT NOW(),
  replied CHAR(1),
  reply VARCHAR(10000),
  reply_created_date TIMESTAMP
);

-- 자주 묻는 질문
CREATE TABLE faq (
  seq_key INT AUTO_INCREMENT PRIMARY KEY,
  category VARCHAR(255),
  title VARCHAR(255),
  content VARCHAR(10000),
  created_date TIMESTAMP DEFAULT NOW(),
  modified_date TIMESTAMP,

  account_key INT REFERENCES account (seq_key)
);

-- 이용안내
CREATE TABLE guide (
  seq_key INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255),
  content VARCHAR(20000),
  created_date TIMESTAMP DEFAULT NOW(),
  modified_date TIMESTAMP,

  account_key INT REFERENCES account (seq_key)
);

-- 약관
CREATE TABLE terms (
  seq_key INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255),
  content VARCHAR(20000),
  created_date TIMESTAMP DEFAULT NOW(),
  modified_date TIMESTAMP,

  account_key INT REFERENCES account (seq_key)
);

-- 회원가입: 휴대폰/이메일 인증
-- auth = authentication
CREATE TABLE auth (
  seq_key INT AUTO_INCREMENT PRIMARY KEY,
  phone VARCHAR(255) UNIQUE,
  email VARCHAR(255),
  phone_code VARCHAR(255), -- 전송된 인증코드
  email_code VARCHAR(255),
  phone_send_date TIMESTAMP DEFAULT NOW(),
  email_send_date TIMESTAMP DEFAULT NOW()
);

-- 회원 계정
-- 일부 항목 제거 (유선전화, 생년월일, 기업회원)
CREATE TABLE account (
  seq_key INT AUTO_INCREMENT PRIMARY KEY,
  -- id는 추후 관리자가 수정할 수도 있기 때문에, primary key로 쓰지 않는다
  -- 예) se*, fuc* 등 미풍양속에 어긋나는 단어를 포함하는 id
  -- id의 앞 4자리는 작성글에 노출됨
  id VARCHAR(255) UNIQUE,
  password VARCHAR(255),
  name VARCHAR(255),
  email VARCHAR(255),
  email_reception CHAR(1),
  phone VARCHAR(255) UNIQUE,
  address_zipcode VARCHAR(255), -- 우편번호
  address_new VARCHAR(255), -- 도로명주소
  address_old VARCHAR(255), -- 지번주소
  address_detail VARCHAR(255), -- 상세주소
  address_extra VARCHAR(255), -- 참고항목
  authority VARCHAR(255) DEFAULT 'user', -- 권한
  point int DEFAULT 0, -- 현재 보유 포인트
  created_date TIMESTAMP DEFAULT NOW(),
  modified_date TIMESTAMP,
  
  auth_key INT REFERENCES auth (seq_key)
);

-- 탈퇴한 회원내역
CREATE TABLE withdrawal (
  seq_key INT AUTO_INCREMENT PRIMARY KEY,
  account_key INT,
  id VARCHAR(255),
  quit_reason VARCHAR(10000),
  created_date TIMESTAMP DEFAULT NOW()
);

-- 주문내역
CREATE TABLE user_order (
  seq_key INT AUTO_INCREMENT PRIMARY KEY,
  order_number VARCHAR(255), -- 주문번호
  -- 주문 이후 해당 상품이 삭제되어도, 이미 주문했던 상품명은 유지되어야 함 (주문 시 상품명 저장)
  order_group INT, -- 해당 주문번호의 상품 유형 수
  order_price INT, -- 해당 주문번호의 상품 총액
  order_quantity INT, -- 해당 주문번호의 상품 총 갯수 
  product_name VARCHAR(255), -- 상품명
  -- 주문 이후 해당 상품가격이 바뀌어도, 이미 주문된 물품의 가격은 바뀔 수 없다 (주문 시 가격 저장)
  product_price INT, -- 상품가격
  quantity INT, -- 주문수량
  status VARCHAR(255), -- 주문상태
  review CHAR(1) DEFAULT 'N', -- 리뷰 여부
  delivery_company VARCHAR(255) DEFAULT '직접배송', -- 택배회사 
  tracking_number VARCHAR(255), -- 운송장 번호
  created_date TIMESTAMP DEFAULT NOW(),

  -- ref. 추후 상품이 삭제된 경우, 상품 이미지를 '삭제된 상품' 이미지로 대체
  -- (product의 seq_key 값을 가져올 수 없는 경우)
  product_key INT REFERENCES product (seq_key),
  account_key INT REFERENCES account (seq_key),
  user_payment_key INT REFERENCES user_payment (seq_key)
);

-- 회원 반품/교환
CREATE TABLE user_return (
  seq_key INT AUTO_INCREMENT PRIMARY KEY,
  charged VARCHAR(255), -- 반품/교환 귀책 (구매자, 판매자)
  content VARCHAR(10000), -- 반품/교환 사유
  created_date TIMESTAMP DEFAULT NOW(),
  modified_date TIMESTAMP,
  reply VARCHAR(10000), -- 관리자 회신
  reply_created_date TIMESTAMP,
  reply_modified_date TIMESTAMP,
  status VARCHAR(255),

  account_key INT REFERENCES account (seq_key),
  order_number VARCHAR(255) REFERENCES user_order (order_number)
);

-- 오늘 본 상품 (X)
-- 최근 본 상품으로 구현 (24시간 이내)
-- 최근 본 상품은 쿠키로 저장한다

-- 장바구니
CREATE TABLE user_cart (
  seq_key INT AUTO_INCREMENT PRIMARY KEY,
  quantity INT,

  product_key INT REFERENCES product (seq_key),
  account_key INT REFERENCES account (seq_key)
);

-- 관리자 쿠폰 등록
CREATE TABLE coupon (
  seq_key INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255), -- 쿠폰명
  minimum_price INT, -- 쿠폰 사용 조건 (최저 구매금액)
  discount_price INT, -- 할인가격
  discount_percent INT, -- 할인율
  start_date TIMESTAMP, -- 쿠폰 시작일 (시작/종료일 특정하는 경우)
  end_date TIMESTAMP, -- 쿠폰 종료일 (시작/종료일 특정하는 경우)
  due_date TIMESTAMP, -- 발행일로부터 ~일까지 유효한 쿠폰
  created_date TIMESTAMP DEFAULT NOW(),
  modified_date TIMESTAMP,
  
  account_key INT REFERENCES account (seq_key)
);

-- 유저 보유 쿠폰
CREATE TABLE user_coupon (
  seq_key INT AUTO_INCREMENT PRIMARY KEY,
  -- 이미 발행된 쿠폰은 발행시점의 내용을 계속 유지한다
  name VARCHAR(255), -- 쿠폰명
  minimum_price INT, -- 쿠폰 사용 조건 (최저 구매금액)
  discount_price INT, -- 할인가격
  discount_percent INT, -- 할인율
  start_date TIMESTAMP, -- 쿠폰 시작일
  end_date TIMESTAMP, -- 쿠폰 종료일
  status VARCHAR(255) DEFAULT '사용가능', -- 쿠폰 상태 (사용가능, 사용완료, 기간만료)
  created_date TIMESTAMP DEFAULT NOW(),

  account_key INT REFERENCES account (seq_key)
);

-- 찜한 상품
-- (위시리스트 대신 '찜한 상품'으로 메뉴 출력)
CREATE TABLE user_wishlist (
  seq_key INT AUTO_INCREMENT PRIMARY KEY,
  quantity INT,

  product_key INT REFERENCES product (seq_key),
  account_key INT REFERENCES account (seq_key)
);

-- 포인트 적립내역
CREATE TABLE point_add (
  seq_key INT AUTO_INCREMENT PRIMARY KEY,
  content VARCHAR(255),
  point INT,
  created_date TIMESTAMP DEFAULT NOW(),

  account_key INT REFERENCES account (seq_key)
);

-- 포인트 사용내역
CREATE TABLE point_used (
  seq_key INT AUTO_INCREMENT PRIMARY KEY,
  content VARCHAR(255),
  point INT,
  created_date TIMESTAMP DEFAULT NOW(),

  account_key INT REFERENCES account (seq_key)
);

-- 마이페이지 > 1:1 문의
CREATE TABLE user_inquiry (
  seq_key INT AUTO_INCREMENT PRIMARY KEY,
  category VARCHAR(255),
  title VARCHAR(255),
  content VARCHAR(10000),
  filename VARCHAR(255),
  created_date TIMESTAMP DEFAULT NOW(),
  modified_date TIMESTAMP,
  reply VARCHAR(10000),
  reply_created_date TIMESTAMP,
  reply_modified_date TIMESTAMP,

  account_key INT REFERENCES account (seq_key)
);

-- 비회원 주문
-- 비회원은 리뷰 불가
CREATE TABLE nonmember_order (
  seq_key INT AUTO_INCREMENT PRIMARY KEY,
  nonmember_name VARCHAR(255), -- 주문자명
  order_number VARCHAR(255), -- 주문번호
  product_name VARCHAR(255), -- 상품명
  product_price INT, -- 상품가격
  quantity INT, -- 주문수량
  status VARCHAR(255), -- 주문상태
  delivery_company VARCHAR(255), -- 택배회사 
  tracking_number VARCHAR(255), -- 운송장 번호
  created_date TIMESTAMP DEFAULT NOW(),

  product_key INT REFERENCES product (seq_key),
  nonmember_payment_key INT REFERENCES nonmember_payment (seq_key)
);

-- 비회원 반품
CREATE TABLE nonmember_return (
  seq_key INT AUTO_INCREMENT PRIMARY KEY,
  content VARCHAR(10000), -- 반품 사유
  created_date TIMESTAMP DEFAULT NOW(),
  modified_date TIMESTAMP,
  reply VARCHAR(10000), -- 관리자 회신
  reply_created_date TIMESTAMP,
  reply_modified_date TIMESTAMP,

  nonmember_order_key INT REFERENCES nonmember_order (seq_key)
);

-- 비회원 장바구니는 DB에 저장하지 않음 (세션으로 구현)

-- 회원 결제내역
-- 결제는 신용카드, 무통장 입금(계좌이체) 2가지로 구현한다
CREATE TABLE user_payment (
  seq_key INT AUTO_INCREMENT PRIMARY KEY,

  orderer_name VARCHAR(255), -- 주문자
  orderer_address_zipcode VARCHAR(255),
  orderer_address_new VARCHAR(255),
  orderer_address_old VARCHAR(255),
  orderer_address_detail VARCHAR(255),
  orderer_address_extra VARCHAR(255),
  orderer_email VARCHAR(255),
  orderer_phone VARCHAR(255),

  recipient_name VARCHAR(255), -- 수취자
  recipient_address_zipcode VARCHAR(255),
  recipient_address_new VARCHAR(255),
  recipient_address_old VARCHAR(255),
  recipient_address_detail VARCHAR(255),
  recipient_address_extra VARCHAR(255),
  recipient_phone VARCHAR(255),
  recipient_request VARCHAR(255), -- 배송 시 요구사항 (form에서 제한 수 결정, 예: 40자)

  amount_total INT, -- 총주문금액
  amount_delivery INT, -- 배송비
  amount_discount_coupon INT, -- 쿠폰할인액
  amount_discount_point INT, -- 포인트 사용액
  amount_final INT, -- 최종 결제금액

  method VARCHAR(255), -- 결제수단
  detail VARCHAR(10000), -- 결제내용 상세
  status VARCHAR(255), -- 결제상태
  paid_date TIMESTAMP, -- 결제일
  -- 사이트에서 주문정보는 주문번호, 결제수단, 주문일만 표시
  -- 주문번호는 user_payment 테이블의 seq_key를 이용하여 user_order 테이블에서 가져온다
  created_date TIMESTAMP DEFAULT NOW(),
  modified_date TIMESTAMP,

  account_key INT REFERENCES account (seq_key)
);

-- 비회원 결제내역
CREATE TABLE nonmember_payment (
  seq_key INT AUTO_INCREMENT PRIMARY KEY,
  
  orderer_name VARCHAR(255), -- 주문자
  orderer_address_zipcode VARCHAR(255),
  orderer_address_new VARCHAR(255),
  orderer_address_old VARCHAR(255),
  orderer_address_detail VARCHAR(255),
  orderer_address_extra VARCHAR(255),
  orderer_email VARCHAR(255),
  orderer_phone VARCHAR(255),
  
  recipient_name VARCHAR(255), -- 수취자
  recipient_address_zipcode VARCHAR(255),
  recipient_address_new VARCHAR(255),
  recipient_address_old VARCHAR(255),
  recipient_address_detail VARCHAR(255),
  recipient_address_extra VARCHAR(255),
  recipient_phone VARCHAR(255),
  recipient_request VARCHAR(255), -- 배송 시 요구사항
  
  amount_total INT, -- 총주문금액
  amount_delivery INT, -- 배송비
  amount_final INT, -- 최종 결제금액
  
  method VARCHAR(255), -- 결제수단
  detail VARCHAR(10000), -- 결제내용 상세
  status VARCHAR(255), -- 결제상태
  paid_date TIMESTAMP, -- 결제일
  created_date TIMESTAMP DEFAULT NOW(),
  modified_date TIMESTAMP
);

-- 회원주문 환불내역
-- CREATE TABLE user_refund (
--   seq_key INT AUTO_INCREMENT PRIMARY KEY,
--   method VARCHAR(255), -- 환불방법
--   detail VARCHAR(10000), -- 환불내용 상세 (객체)
--   status VARCHAR(255), -- 환불상태
--   amount_cash INT, -- 현금 환불액
--   refund_date TIMESTAMP, -- 환불 완료일
--   created_date TIMESTAMP DEFAULT NOW(),
--   modified_date TIMESTAMP,

--   user_payment_key INT REFERENCES user_payment (seq_key)
-- );

-- 비회원주문 환불내역
CREATE TABLE nonmember_refund (
  seq_key INT AUTO_INCREMENT PRIMARY KEY,
  method VARCHAR(255), -- 환불방법
  detail VARCHAR(10000), -- 환불내용 상세 (객체)
  status VARCHAR(255), -- 환불상태
  amount_cash INT, -- 현금 환불액
  refund_date TIMESTAMP, -- 환불 완료일
  created_date TIMESTAMP DEFAULT NOW(),
  modified_date TIMESTAMP,

  nonmember_payment_key INT REFERENCES nonmember_payment (seq_key)
);

-- 배너
CREATE TABLE banner (
  seq_key INT AUTO_INCREMENT PRIMARY KEY,
  -- category 설명
  -- "main"으로 지정되면, 메인화면용 배너임 (main은 여러개 등록 가능)
  -- 그 외에는 카테고리 "대분류명" 직접 기입 (main 외에는 카테고리명 당 하나만 등록 가능)
  category VARCHAR(255), 
  filename VARCHAR(255)
);

-- 쇼핑몰 설정
CREATE TABLE settings (
  seq_key INT AUTO_INCREMENT PRIMARY KEY,
  point_rate INT,
  delivery_type VARCHAR(255),
  delivery_fee INT
);

commit;
