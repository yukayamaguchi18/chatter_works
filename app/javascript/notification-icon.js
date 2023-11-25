import $ from 'jquery';

  $(document).on('turbolinks:load', function() {
    $('#notifications-link').click(function() {
      // 通知を確認済みに更新するアクションを呼び出す
      $.ajax({
        url: '/notifications/update_checked',
        type: 'POST',
        headers: {
          'X-CSRF-Token' : $('meta[name="csrf-token"]').attr('content') //CSRFトークン付与
        },
        success: function() {
          $('.n-circle').removeClass('bg-green');
          $('#notifications-link').html('<i class="far fa-bell fa-lg" style="font-size: 1.5em;"></i>');

          // 通知モーダルを表示する処理
          $.ajax({
            url: '/notifications',
            type: 'GET',
            headers: {
              'X-CSRF-Token' : $('meta[name="csrf-token"]').attr('content') //CSRFトークン付与
            },
            success: function(response) {
              $('#notifications-modal .common-modal-content').html(response);
              $('#notifications-modal').addClass('fade-in').show();
            }
          });
        }
      });
    });

  // モーダル内のクリックイベントを停止
  $('#notifications-modal .modal-content').on('click', function(event) {
    event.stopPropagation(); // イベントの伝播を停止
  });

  // モーダル外（背景）をクリックしたときにモーダルを閉じる
  $('#notifications-modal').on('click', function() {
    $(this).addClass('fade-out');
    setTimeout(() => {
      $(this).hide().removeClass('fade-out');
    }, 300);
  });
});
