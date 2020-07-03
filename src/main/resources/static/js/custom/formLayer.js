$(function () {
  const winWidth = $(window).width()
  let layerCheck = 0

  if (winWidth > 767) {
    layerCheck = 540
  } else {
    layerCheck = 320
  }

  $(".formLayer").fancybox({
    'autoDimensions'    : false,
    'showCloseButton'	: false,
    'width' : layerCheck,
    'padding' : 0,
    'type'			: 'iframe',
    'onComplete' : function () {
      $('#fancybox-frame').load(function () { // wait for frame to load and then gets it's height
      $('#fancybox-content').height($(this).contents().find('body').height())
      })
    }
  })
})
