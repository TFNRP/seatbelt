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

  const enableIcon = () => {
    const ui = $('#ui');
    ui.stop(true, true);
    ui.css('display', 'flex');
    $('#seatbelt').animate(
      {
        top,
        opacity: '1.0',
      },
      700,
    );
  };

  const disableIcon = () => {
    const ui = $('#ui');
    ui.stop(true, true);
    $('#seatbelt').animate(
      {
        top: '100vw',
        opacity: '0.0',
      },
      700,
      () => ui.css('display', 'none'),
    );
  };

  sounds.chime.on('play', enableIcon);
  sounds.chime.on('stop', disableIcon);
  sounds.chime.on('end', () => {
    if (!sounds.chime.loop()) disableIcon();
  });

  window.addEventListener('message', event => {
    const payload = event.data;

    switch (payload.t) {
      case 0: {
        const data = payload.d;
        let playing;
        // If another sound is already playing, play the new sound from the reverse of the elapsed time
        if ((playing = buckle.find(sound => sound.playing()))) {
          const seek = buckle[data].duration() - playing.seek() - 0.423764;
          playing.stop();
          buckle[data].play();
          if (seek > 0) buckle[data].seek(seek);
        } else {
          buckle[data].play();
        }
        break;
      }

      case 1: {
        switch (payload.d) {
          case 1:
            sounds.chime.loop(true);
            if (!sounds.chime.playing()) {
              sounds.chime.play();
            }
            break;

          case 3:
            sounds.chime.stop();
            sounds.unbluckle.stop();
          // Fallthrough

          case 0:
            sounds.chime.loop(false);
            break;
        }
        break;
      }
    }
  });
});
