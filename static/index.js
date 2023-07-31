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
    const ui = $('#ui');
    ui.stop(true, true);
    if ('State' in event.data) {
      const state = +event.data.State;
      let playing;
      // If another sound is already playing, play the new sound from the reverse of the elapsed time
      if ((playing = buckle.find(sound => sound.playing()))) {
        const seek = buckle[state].duration() - playing.seek();
        playing.stop();
        buckle[state].play();
        if (seek > 0) buckle[state].seek(seek);
      } else {
        buckle[state].play();
      }
    }

    if ('Enabled' in event.data) {
      sounds.chime.loop(event.data.Enabled);
      if (event.data.Enabled) {
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
      } else {
        $('#seatbelt').animate(
          {
            top: '100vw',
            opacity: '0.0',
          },
          700,
          () => ui.css('display', 'none'),
        );
      }
    }
  });
});
