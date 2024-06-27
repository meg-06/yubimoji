  var swiper;  // swiperをグローバルスコープで定義

  document.addEventListener('DOMContentLoaded', function() {
    swiper = new Swiper('.swiper-container', {
      effect: 'fade',  // フェードエフェクトを適用
      spaceBetween: 10,  // スライド間の余白を10pxに設定
      loop: false,  // スライドのループを無効化
      navigation: {
        nextEl: '.swiper-button-next',
        prevEl: '.swiper-button-prev',
      },
      autoplay: {  // 自動再生を有効化
        delay: 1000,  // 初期のスライド間の遅延時間を設定
      },
      on: {
        init: function () {
          // 初期化時に一枚目のスライドが動画であれば再生する
          var firstSlide = this.slides[0];
          var video = firstSlide.querySelector('video');
          if (video) {
            video.play();
          }
        },
        slideChange: function () {
          var videos = document.querySelectorAll('video');
          videos.forEach(function(video) {
            video.pause();
          });

          // 現在のスライドを取得
          var currentSlide = this.slides[this.activeIndex];

          // 現在のスライド内の動画要素を取得
          var video = currentSlide.querySelector('video');

          // 動画要素が存在する場合、動画を再生
          if (video) {
            video.currentTime = 0;  // 再生位置を最初に戻す
            video.play();
            video.playbackRate = 1;  // 再生速度を1倍に設定
          }
          if (this.activeIndex === this.slides.length - 1) {
            this.autoplay.stop();  // 最後のスライドに到達したら、自動再生を停止
          }
        } // slideChange functionの閉じカッコ
      } // on objectの閉じカッコ
    }); // Swiperの初期化の閉じカッコ

    // スワイパーのスライド速度を変更する関数
    window.changeSwiperSpeed = function(speed) {  // グローバルスコープで関数を定義
      console.log('Changing swiper speed to:', speed);  // デバッグ用ログ
      swiper.autoplay.stop();  // 自動再生を停止
      swiper.params.autoplay.delay = 1000 / speed;  // スライドの遅延を変更

      // スライドを最初に戻す
      swiper.slideTo(swiper.activeIndex, 0, false);  // 現在のスライドに即座に移動

      // 現在のスライド内の動画をリセットして再生を開始
      var currentSlide = swiper.slides[swiper.activeIndex];
      var video = currentSlide.querySelector('video');
      if (video) {
        video.currentTime = 0;  // 再生位置を最初に戻す
        video.play();
        video.playbackRate = 1;  // 再生速度を1倍に設定
      }

      // 自動再生を再スタート
      setTimeout(() => {
        swiper.autoplay.start();
      }, 100);  // 少し遅延させて再スタート
    }
  }); // DOMContentLoaded event listenerの閉じカッコ
