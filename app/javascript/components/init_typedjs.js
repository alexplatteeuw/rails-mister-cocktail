import Typed from 'typed.js';

const options = {
  strings: ['Get a fresh cocktail...', 'From our selection...'],
  attr: 'placeholder',
  typeSpeed: 80,
  loop: true
};

const typed = new Typed('.element', options);

export { typed };
