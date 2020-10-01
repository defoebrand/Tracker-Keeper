// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

// location.reload();

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// $(document).ready(function() {
// $('#clickHereNext').click(function(event) {
//   $('.number_to_be_changed').html('<%# @click = @click1 %>');
//   // alert('Hooray!');
//   event.preventDefault(); // Prevent link from following its href
// });
// });

// $(document).ready(function() {
//   $('#select_days').change(function() {
//     $('#text_to_be_changed').html($(this).val());
//   });
// });

// $(document).ready(function(){
//     $('#select_days').change(function() {
//         $('#text_to_be_changed').html($(this).val());
//     });
// });
// $(document).ready(function(){
//     $('#clickHereNext').change(function() {
//         $('#number_to_be_changed').html($(this).val());
//     });
// });
// $('#clickHereNext').click(function (event) {
//   $('#number_to_be_changed').html('<%# @click = @click1 %>');
//   // alert('Hooray!');
//   event.preventDefault(); // Prevent link from following its href
// });

// $(document).ready(function() {
//   $('.burger-menu').click(function() {
//     $('.burger-links').toggleClass('visible');
//     alert('yay!');
//   });
// });
//
// $(document).ready(function() {
//   $('.parent').click(function() {
//     $('.sub-nav').toggleClass('visible');
//   });
// });


// var ready;
// ready = function() {
//   $('#nav').localScroll({
//     duration: 800
//   });
// };
//
// $(document).ready(ready);
// $(document).on('page:load', ready);


// var ready;
// ready = function() {

document.addEventListener("turbolinks:load", function() {

  $(document).ready(function() {
    $('.burger-menu').click(function(event) {
      $('.hidden').toggleClass('visible');
      // alert('Hooray!');
      // event.preventDefault(); // Prevent link from following its href
    });
    $('.account-menu').click(function(event) {
      $('.ac-hidden').toggleClass('ac-visible');
      // alert('Hooray!');
      // event.preventDefault(); // Prevent link from following its href
    }); //hover - focus - change - click?

  });
  // $(document).ready(function() {


  // });
});

// document.addEventListener("turbolinks:load", function() {
//   $(document).ready(function() {
//     $('.account-menu').click(function(event) {
//       $('.hidden').toggleClass('visible');
//       // alert('Hooray!');
//       // event.preventDefault(); // Prevent link from following its href
//     });
//   });
// });




// };

// $(document).ready(ready);
// $(document).on('page:load', ready);



// $('#my-link').click(function(event) {
//   alert('Hooray!');
//   event.preventDefault(); // Prevent link from following its href
// });