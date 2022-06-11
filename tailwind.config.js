module.exports = {
  purge: ['./app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    "./app/javascript/app.vue",
    "./app/javascript/packs.vue",
    "./app/javascript/**/*.vue",
    './app/javascript/**/*.js'],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      colors: {
        'twitter': '#1DA1F2',
      }
    },
  },
  variants: {
    extend: {},
  },
  plugins: [require('daisyui')],
}
