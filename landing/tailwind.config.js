/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ['./index.html'],
  theme: {
    extend: {
      colors: {
        bg:     '#F9F9F7',
        green1: '#1B3B26',
        green2: '#3D6346',
        brown:  '#704F37',
        gold:   '#F2C94C',
        ink:    '#1A1A1A',
      },
      fontFamily: {
        sans:  ['Inter', 'ui-sans-serif', 'system-ui', 'sans-serif'],
        serif: ['"Cormorant Garamond"', 'Georgia', 'serif'],
      },
    },
  },
  plugins: [],
};
