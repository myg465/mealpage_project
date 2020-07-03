$(document).ready(function() {
			
	var mySwiper = new Swiper('#mainRoll',{
		pagination: '#mainThum',
		paginationClickable: true,
		slidesPerView: 1,
		loop: true,
		autoplay:5000
	});

	var mySwiper2 = new Swiper('#bestseller',{
		paginationClickable: true,
		slidesPerView: 3,
		loop: true,
		autoplay:3000
	});

	var mySwiper3 = new Swiper('#mainSale',{
		paginationClickable: true,
		slidesPerView: 5,
		loop: true,
		autoplay:3000
	});
	
	$(window).bind('resize', function() {
		rollwidth();	
	});

	function rollwidth(){
		var winWidth = $(window).width();
		if(winWidth < 768){
			mySwiper2.params.slidesPerView = 1;
			mySwiper3.params.slidesPerView = 2;
		}else{
			mySwiper2.params.slidesPerView = 3;
			mySwiper3.params.slidesPerView = 5;
		}
	}
	$('.arrowLeft').bind('click', function(e){
		e.preventDefault()
		mySwiper2.swipePrev()
	});
	$('.arrowRight').bind('click', function(e){
		e.preventDefault()
		mySwiper2.swipeNext()
	});

	$('.saleLeft').bind('click', function(e){
		e.preventDefault()
		mySwiper3.swipePrev()
	});
	$('.saleRight').bind('click', function(e){
		e.preventDefault()
		mySwiper3.swipeNext()
	});

	rollwidth();


	var myWish = new Swiper('#wishList',{
		paginationClickable: true,
		slidesPerView: 3,
		loop: true,
		autoplay:3000
	});


});

$(function(){
	
	$(window).scroll(function(){
		var tg = $("div#quick");
		var xg = $("div#mainContents");
		var limit = xg.height()- 165;
		var tmp = $(window).scrollTop();

		if (tmp > limit) {
			tg.css({"position" : "absolute","right" : "-150px","bottom" : "208px","top" : "auto"});
		}
		else {
			if (tmp < 150 ){
				tg.css({"position" : "fixed","top" : "600px" , "margin-left" : "940px","right" : "auto"});
			}else{
				tg.css({"position" : "fixed","top" : "400px" , "margin-left" : "940px","right" : "auto"});
			}
		}
	});

});