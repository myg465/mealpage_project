## 프로젝트 파일 목록

파일명|담당자|역할
-|-|-
\- src\main\java\dev\localhost\koitt14|김우혁,마윤근|(JAVA 소스 폴더 루트)
AppController.java|김우혁,마윤근|사이트 메인, 소개 페이지 Controller
\- src\main\java\dev\localhost\koitt14\admin|김우혁,마윤근,이재욱|(관리자 페이지)
AdminController_Banner.java|마윤근|배너관리 Controller
AdminController_NonmemberOrder.java|마윤근|비회원주문관리 Controller
AdminController_Product.java|마윤근|상품관리 Controller
AdminController_ProductInquiry.java|마윤근|상품문의관리 Controller
AdminController_ProductReview.java|마윤근|상품리뷰관리 Controller
BannerVo.java|마윤근|배너 VO
\- src\main\java\dev\localhost\koitt14\nonmember|마윤근|(비회원 주문조회)
NonmemberAdminOrderVo.java|마윤근|비회원 주문관리VO
NonmemberController.java|마윤근|비회원주문반품조회 Controller
NonmemberMapper.java|마윤근|비회원주문반품조회 DAO
NonmemberOrderVo.java|마윤근|비회원주문조회 VO
NonmemberPayAndOrderVo.java|마윤근|비회원주문현황 + 결제정보 VO (SQL JOIN)
NonmemberPayAndReturnVo.java|마윤근|비회원반품등 현황 + 결제정보 VO (SQL JOIN)
NonmemberReturnVo.java|마윤근|비회원결제정보VO(관리자용)
NonmemberService.java|마윤근|비회원 주문반품조회 Service
\- src\main\java\dev\localhost\koitt14\nonmemberPayment|마윤근|(비회원 결제)
NonmemberPaymentController.java|마윤근|비회원결제 Controller
NonmemberPaymentMapper.java|마윤근|비회원결제 DAO
NonmemberPaymentService.java|마윤근|비회원결제 Service
NonmemberPaymentVo.java|마윤근|비회원결제정보 VO
\- src\main\java\dev\localhost\koitt14\product|마윤근|(제품관련)
ProductController.java|마윤근|제품관련 Controller
ProductMapper.java|마윤근|제품관련 DAO
ProductService.java|마윤근|제품관련 Service(nav,메인표시관련 포함)
ProductVo.java|마윤근|제품정보 VO
WishListVo.java|마윤근|찜한상품 표시정보 VO
\- src\main\java\dev\localhost\koitt14\productInquiry|마윤근|(제품문의)
ProductInquiryController.java|마윤근|제품문의 Controller
ProductInquiryMapper.java|마윤근|제품문의 DAO
ProductInquiryService.java|마윤근|제품문의 Service
ProductInquiryVo.java|마윤근|제품문의정보 VO
\- src\main\java\dev\localhost\koitt14\review|마윤근|(제품리뷰)
ReviewController.java|마윤근|제품리뷰 Controller
ReviewMapper.java|마윤근|제품리뷰 DAO
ReviewService.java|마윤근|제품리뷰 Service
ReviewVo.java|마윤근|제품리뷰정보 VO
\- src\main\java\dev\localhost\koitt14\wishlist|김우혁|(회원 찜한상품)
WishlistController.java|김우혁|회원 찜한상품 Controller
\- src\main\resources\mappers|김우혁,마윤근,이재욱|(MyBatis Mapper XML)
NonmemberMapper.xml|마윤근|비회원주문조회 Mapper
NonmemberPaymentMapper.xml|마윤근|비회원결제 Mapper
ProductInquiryMapper.xml|마윤근|상품문의 Mapper
ProductMapper.xml|마윤근|상품조회 Mapper
ReviewMapper.xml|마윤근|상품리뷰 Mapper
\- src\main\resources\static\css\custom|김우혁,마윤근|(커스터마이징용 CSS)
productDetail.css|마윤근|상품상세 페이지 CSS
\- src\main\resources\static\img\temp|-|(템플릿)
\- src\main\resources\static\js\custom|김우혁,마윤근,이재욱|(커스터마이징용 자바스크립트)
main.js|마윤근|메인 페이지 JS
nonmember.js|마윤근|비회원 장바구니 JS
nonmemberOrderAdmin.js|마윤근|비회원주문관리 JS
nonmemberPayment.js|마윤근|비회원결제 JS
product.js|마윤근|제품상세 JS
productInquiry.js|마윤근|제품문의 JS
review.js|마윤근|리뷰리스트 JS
\- src\main\resources\static\js\temp|-|(템플릿)
\- src\main\webapp\files|김우혁,마윤근,이재욱|(업로드용 폴더)
\- src\main\webapp\WEB-INF\lib|(외부 라이브러리)
\- src\main\webapp\WEB-INF\views\admin|김우혁,마윤근,이재욱|(관리자 페이지 View)
banner.jsp|마윤근|관리자 배너관리
banner_modify.jsp|마윤근|관리자 배너수정
order_nonmemberDelivery.jsp|마윤근|비회원 상품발송등록
order_nonmemberDetail.jsp|마윤근|비회원 주문상세관리
order_nonmemberExDeliView.jsp|마윤근|비회원 교환발송등록
order_nonmemberList.jsp|마윤근|비회원 주문관리
order_nonmemberReasonView.jsp|마윤근|비회원 반품등 사유열람
order_nonmemberRejectView.jsp|마윤근|비회원 반품등 거절사유작성
order_sidemenu.jsp|김우혁,마윤근|주문관리 사이드 메뉴
product.jsp|마윤근|상품관리 리스트
product_imgpop.jsp|마윤근|상품이미지뷰
product_inquiry.jsp|마윤근|상품문의관리 리스트
product_inquiry_reply.jsp|마윤근|상품문의 답변작성
product_insert.jsp|마윤근|상품등록
product_modify.jsp|마윤근|상품정보수정
product_review.jsp|마윤근|리뷰관리 리스트
product_review_imgpop.jsp|마윤근|리뷰 이미지뷰
product_sidemenu.jsp|마윤근|상품관리 사이드 메뉴
admin_nav.jsp|김우혁,마윤근,이재욱|관리자 페이지 상단메뉴
header.jsp|김우혁,마윤근|일반 페이지 Header
nav.jsp|마윤근|일반 페이지 상단 메뉴
\- src\main\webapp\WEB-INF\views\main|(사이트 메인, 소개 View)
main.jsp|마윤근|사이트 메인
\- src\main\webapp\WEB-INF\views\nonmember|마윤근|(비회원 카트 및 주문반품조회)
cartList.jsp|마윤근|장바구니 리스트
deliveryView.jsp|마윤근|주문 및 배송정보 상세조회
ordercheck.jsp|마윤근,이재욱|주문정보조회 리스트
refundView.jsp|마윤근|반품현황 상세조회
sidemenu.jsp|마윤근|비회원주문조회 사이드메뉴
takebackReason.jsp|마윤근|반품등 사유열람,수정
takebackStateList.jsp|마윤근|반품등 현황 리스트
takebackWriteView.jsp|마윤근|반품등 사유작성
\- src\main\webapp\WEB-INF\views\nonmemberPayment|마윤근|(비회원 결제 View)
confirmation.jsp|마윤근|결제 후 확인
payment.jsp|마윤근|결제
\- src\main\webapp\WEB-INF\views\product|마윤근|(상품)
detail.jsp|마윤근|상품 상세페이지 상단
detailContent.jsp|마윤근|상품상세정보
list.jsp|마윤근|상품리스트
productNotice.jsp|마윤근|주문전 확인사항
relationProduct.jsp|마윤근|관련상품
search.jsp|마윤근|상품검색
\- src\main\webapp\WEB-INF\views\productInquiry|마윤근|(상품문의)
inquiryList.jsp|마윤근|상품문의 리스트
inquiryModifyView.jsp|마윤근|상품문의 수정
inquiryWriteView.jsp|마윤근|상품문의 작성
\- src\main\webapp\WEB-INF\views\review|마윤근|(상품리뷰)
reviewImageView.jsp|마윤근|리뷰 이미지뷰
reviewList.jsp|마윤근|리뷰 리스트
reviewModifyView.jsp|마윤근|리뷰 수정
reviewWriteView.jsp|마윤근|리뷰 작성
