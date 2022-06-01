module.exports = {
  purge: ['./app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    "./app/javascript/app.vue",
    "./app/javascript/packs.vue",
    "./app/javascript/**/*.vue",
    './app/javascript/**/*.js'],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {},
  },
  variants: {
    extend: {},
  },
  plugins: [require('daisyui')],
}
