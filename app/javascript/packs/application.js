// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
[label ~/rails-bootstrap/app/javascript/packs/application.js]
import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"

import "bootstrap"
import "../stylesheets/application"
import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

// document.addEventListener('DOMContentLoaded', () => {
//   const buttons = document.querySelectorAll('.verifyButton');

//   buttons.forEach(button => {
//     button.addEventListener('click', () => {
//       const userId = button.getAttribute('data-user-id');

//       fetch(`/api/v1/users/${userId}/verify_user`, {
//         method: 'PATCH',
//         headers: {
//           'Content-Type': 'application/json',
//           'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
//         },
//         body: JSON.stringify({ verified: true })
//       })
//       .then(response => response.json())
//       .then(data => {
//         if (data.success) {
//           alert('User verified successfully!');
//         }
//       })
//       .catch(error => {
//         console.error('Error:', error);
//       });
//     });
//   });
// });
