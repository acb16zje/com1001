/* Written by Group 31 - Zer Jun Eng, 2017 */
/* Javascript for the login / register function and menu system */

// Variable Declaration
var isOpen = false;
var TABLET_WIDTH = 700;
var DESKTOP_WIDTH = 1000;
var width = $(window).width();

/* Login Overlay */
// Check if the login overlay is opened or closed
function checkOverlay() {
  if (isOpen) {
    isOpen = false;
    closeLogin();
  } else {
    isOpen = true;
    openLogin();
  }
}

// Open the login overlay when the user clicks on the avatar image
function openLogin() {
  document.getElementById("login_overlay").style.visibility = "visible";
  document.getElementById("login_overlay").style.opacity = "1";
}

// Close the login overlay when the user clicks on the avatar image
function closeLogin() {
  document.getElementById("login_overlay").style.visibility = "hidden";
  document.getElementById("login_overlay").style.opacity = "0";
}

// Close the login overlay when the user clicks outside the overlay
window.addEventListener('mouseup', function (mouseClick) {
  var overlay = document.getElementById("login_overlay");
  var avatar = document.getElementById("avatar");

  var avatarTablet = document.getElementById("login_tablet");
  var avatarImgTablet = document.getElementById("tablet_avatar");

  if (window.outerWidth < TABLET_WIDTH) {
    if (mouseClick.target != overlay && mouseClick.target != avatar && isOpen) {
      isOpen = false;
      document.getElementById("login_overlay").style.visibility = "hidden";
      document.getElementById("login_overlay").style.opacity = "0";
    }
  } else if (window.outerWidth >= TABLET_WIDTH && window.outerWidth
      < DESKTOP_WIDTH) {
    if (mouseClick.target != overlay && mouseClick.target != avatarTablet
        && mouseClick.target != avatarImgTablet && isOpen) {
      isOpen = false;
      document.getElementById("login_overlay").style.visibility = "hidden";
      document.getElementById("login_overlay").style.opacity = "0";
    }
  }
});

/* Menu */
// Run the fix menu function
fixMenu();
$(window).on('resize', function () {
  if ($(this).width() != width) {
    width = $(this).width();
    fixMenu();
  }
});

function fixMenu() {
  if ($(window).width() < TABLET_WIDTH) {
    $(function () {
      // Save the initial position of the menu
      var initialMenu = $('#mobile_menu').offset().top;

      $(window).scroll(function () {
        if ($(window).scrollTop() > initialMenu) {
          $('#menu_smoother').css({
            display: 'block'
          });

          $('#mobile_menu').css({
            position: 'fixed',
            top: '0px'
          });
        } else {
          $('#menu_smoother').css({
            display: 'none'
          });

          $('#mobile_menu').css({
            position: 'static',
            top: '0px'
          });
        }
      });
    });
  } else if ($(window).width() >= TABLET_WIDTH && $(window).width()
      < DESKTOP_WIDTH) {
    $(function () {
      // Save the initial position of the menu
      var tabletInitialMenu = $('#tablet_menu').offset().top;

      $(window).scroll(function () {
        if ($(window).scrollTop() > tabletInitialMenu) {
          $('#menu_smoother').css({
            display: 'block'
          });

          $('#tablet_menu').css({
            position: 'fixed',
            top: '0px'
          });
        } else {
          $('#menu_smoother').css({
            display: 'none'
          });

          $('#tablet_menu').css({
            position: 'static',
            top: '0px'
          });
        }
      });
    });
  } else if ($(window).width() >= DESKTOP_WIDTH) {
    $(function () {
      // Save the initial position of the menu
      var desktopInitialMenu = $('#desktop_menu').offset().top;

      $(window).scroll(function () {
        if ($(window).scrollTop() > desktopInitialMenu) {
          $('#menu_smoother').css({
            display: 'block'
          });

          $('#desktop_menu').css({
            position: 'fixed',
            top: '0px'
          });
        } else {
          $('#menu_smoother').css({
            display: 'none'
          });

          $('#desktop_menu').css({
            position: 'static',
            top: '0px'
          });
        }
      });
    });
  }
}
