/// <reference types="howler"/>
/// <reference types="jquery"/>

'use strict';

const sounds = {
  buckle: new Howl({ src: ['./assets/buckle.ogg'] }),
  chime: new Howl({ src: ['./assets/chime.ogg'] }),
  unbluckle: new Howl({ src: ['./assets/unbuckle.ogg'] }),
};
const buckle = [sounds.unbluckle, sounds.buckle];

$(() => {
  const top = $('#seatbelt').css('top');
  window.addEventListener('message', event => {
    const payload = event.data;

    switch (payload.t) {
      case 0: {
        const data = payload.d;
        let playing;
        // If another sound is already playing, play the new sound from the reverse of the elapsed time
        if ((playing = buckle.find(sound => sound.playing()))) {
          const seek = buckle[data].duration() - playing.seek();
          playing.stop();
          buckle[data].play();
          if (seek > 0) buckle[data].seek(seek);
        } else {
          buckle[data].play();
        }
        break;
      }

      case 1: {
        const ui = $('#ui');
        ui.stop(true, true);
        if (payload.d === 1) {
          ui.css('display', 'flex');
          $('#seatbelt').animate(
            {
              top,
              opacity: '1.0',
            },
            700,
          );
  
          if (!sounds.chime.playing()) {
            sounds.chime.play();
          }
          sounds.chime.loop(true);
        } else {
          $('#seatbelt').animate(
            {
              top: '100vw',
              opacity: '0.0',
            },
            700,
            () => ui.css('display', 'none'),
          );
          sounds.chime.loop(false);
        }
        break;
      }
    }
  });
});
