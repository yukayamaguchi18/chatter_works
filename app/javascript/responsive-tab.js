const CHANGE_WIDTH = 768; // 変更を検知する横幅
const ADD_CLASS = "tab-content" // 追加するクラス

$(window).on('load resize', function(){
  var i_width = $(window).outerWidth(true);
  if(i_width < CHANGE_WIDTH){ //windowが768以下
    if($('#tab-content').hasClass(ADD_CLASS)){
    } else { //tab-contentクラスがない時
      $('#tab-content').addClass(ADD_CLASS);
    }
  } else { //windowが768以上
    if(!$('#tab-content').hasClass(ADD_CLASS)){
    } else { //tab-contentクラスがある時
      $('#tab-content').removeClass(ADD_CLASS);
    }
  }
});