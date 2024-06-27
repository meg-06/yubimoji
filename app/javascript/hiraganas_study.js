  // handleVideoEnd関数の定義
  function handleVideoEnd(video) {
    var swiper = document.querySelector('.swiper-container').swiper;
    if (swiper.activeIndex === swiper.slides.length - 1) {
      video.pause();  // 最後のスライドでは再生を停止する
      video.currentTime = video.duration;  // ビデオを停止された位置に留める
    } else {
      video.currentTime = 0;  // 再生位置を最初に戻す
      video.play().catch(error => console.log('Video play interrupted:', error));  // 再生を開始
      video.playbackRate = 3;  // 再生速度を1.5倍に設定
    }
  }

  document.addEventListener('DOMContentLoaded', function() {
    var answerContainer = document.getElementById('answer-container');
    var totalSlides = document.querySelectorAll('.swiper-slide').length;
    var currentSlideIndex = 0;

    // ボタンがクリックされたときに答えを表示するイベントリスナーを追加
    document.getElementById('show-answer-button').addEventListener('click', function() {
      document.getElementById('answer-container').style.display = 'block';
    });

    function showAnswer() {
      answerContainer.style.display = 'block';
    }

    function checkSlideCompletion() {
      if (currentSlideIndex >= totalSlides - 1) {
        // showAnswer(); // 自動的に答えを表示する処理をコメントアウトまたは削除
      }
    }

    var swiper = new Swiper('.swiper-container', {
      effect: 'fade',  // フェードエフェクトを適用
      spaceBetween: 10,  // スライド間の余白を10pxに設定
      loop: false,  // スライドのループを無効化
      navigation: {
        nextEl: '.swiper-button-next',
        prevEl: '.swiper-button-prev',
      },
      autoplay: {  // 自動再生を有効化
        delay: 500,  // 初期のスライド間の遅延時間を1.5倍速に対応
      },
      on: {
        init: function () {
          var firstSlide = this.slides[0];
          var video = firstSlide.querySelector('video');
          if (video) {
            video.play().catch(error => console.log('Video play interrupted:', error));
            video.playbackRate = 3
            ;  // 再生速度を1.5倍に設定
          }
        },
        slideChange: function () {
          currentSlideIndex = this.activeIndex;
          var videos = document.querySelectorAll('video');
          videos.forEach(function(video) {
            video.pause();
          });

          var currentSlide = this.slides[this.activeIndex];
          var video = currentSlide.querySelector('video');

          if (video) {
            video.currentTime = 0;
            setTimeout(() => {
              video.play().catch(error => console.log('Video play interrupted:', error));
              video.playbackRate = 3;  // 再生速度を1.5倍に設定
            }, 200);  // 再生タイミングを遅らせる
          }
          checkSlideCompletion();

          if (this.activeIndex === this.slides.length - 1) {
            this.autoplay.stop();
          }
        }
      }
    });
  });

