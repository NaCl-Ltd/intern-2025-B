// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "custom/menu"
import "custom/image_upload"

document.addEventListener("turbo:load", function() {
  const flashMessages = document.querySelectorAll(".alert");

  flashMessages.forEach(function(flashMessage) {
    setTimeout(function() {
      flashMessage.style.transition = "opacity 0.5s ease-out";
      flashMessage.style.opacity = 0;
      setTimeout(() => flashMessage.remove(), 500);
    }, 3000);
  });
});
