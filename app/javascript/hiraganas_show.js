document.addEventListener('DOMContentLoaded', function() {
  let currentSpeed = 2;  // 現在の再生速度を保持する変数

  function handleVideoEnd(video) {
    const swiper = document.querySelector('.swiper-container').swiper;
    if (swiper.activeIndex === swiper.slides.length - 1) {
      video.pause();  // 最後のスライドでは再生を停止する
      video.currentTime = video.duration;  // ビデオを停止された位置に留める
    } else {
      swiper.slideNext();  // 次のスライドに移動する
    }
  }

  const speedButtons = document.querySelectorAll('.playback-speed-buttons button');
  speedButtons.forEach(function(button) {
    button.addEventListener('click', function() {
      const speed = parseFloat(this.getAttribute('data-speed'));
      changeSwiperSpeed(speed);
      const swiper = document.querySelector('.swiper-container').swiper;  // ここでswiperを再取得
      const currentSlide = swiper.slides[swiper.activeIndex];
      const hiraganaText = currentSlide.querySelector('.hiragana-text');
      if (hiraganaText) {
        hiraganaText.style.display = 'block';  // ひらがなのテキストを表示
      }
    });
  });

  const swiper = new Swiper('.swiper-container', {
    effect: 'fade',
    spaceBetween: 10,
    loop: false,
    navigation: {
      nextEl: '.swiper-button-next',
      prevEl: '.swiper-button-prev',
    },
    autoplay: {
      delay: 1000,
    },
    centeredSlides: true,
    on: {
      init: function () {
        const firstSlide = this.slides[0];
        const video = firstSlide.querySelector('video');
        if (video) {
          video.playbackRate = currentSpeed;  // 初期の再生速度を設定
          video.play().catch(error => console.log('Video play interrupted:', error));
          video.onended = function() {
            handleVideoEnd(video);  // 動画の再生が終わったときの処理
          };
        }
      },
      slideChange: function () {
        const videos = document.querySelectorAll('video');
        videos.forEach(function(video) {
          video.pause();
        });

        const currentSlide = this.slides[this.activeIndex];
        const video = currentSlide.querySelector('video');
        if (video) {
          video.currentTime = 0;
          video.playbackRate = currentSpeed;  // 再生速度を設定
          setTimeout(() => {
            video.play().catch(error => console.log('Video play interrupted:', error));
          }, 200);  // 再生タイミングを遅らせる
          video.onended = function() {
            handleVideoEnd(video);  // 動画の再生が終わったときの処理
          };
        }
        if (this.activeIndex === this.slides.length - 1) {
          swiper.autoplay.stop();
        }

        // 前のスライドのテキストを非表示にする
        const previousSlide = this.slides[this.previousIndex];
        const previousText = previousSlide.querySelector('.sign-language-text');
        if (previousText) {
          previousText.style.display = 'none';
        }
      }
    }
  });

  async function changeSwiperSpeed(speed) {
    // 0.5, 0.75, 1倍速のときはMP4を2倍速で、1.25、1.5、2倍のときは3倍で再生
    currentSpeed = (speed <= 1) ? 2 : 3;

    const currentSlide = swiper.slides[swiper.activeIndex];
    const video = currentSlide.querySelector('video');
    if (video) {
      video.playbackRate = currentSpeed;  // 再生速度を設定
      video.currentTime = 0;  // 再生位置をリセット
      video.play().catch(error => console.log('Video play interrupted:', error));
      video.onended = function() {
        handleVideoEnd(video);  // 動画の再生が終わったときの処理
      };
    }

    swiper.autoplay.stop();
    swiper.params.autoplay.delay = 1000 / speed;
    swiper.update();

    setTimeout(() => {
      swiper.autoplay.start();
    }, 200);
  }

  window.changeSwiperSpeed = changeSwiperSpeed;
});
