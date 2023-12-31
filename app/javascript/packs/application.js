// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import JQuery from 'jquery'; //create.js.erb等で.modal functionを読み込むために追加
window.$ = window.JQuery = JQuery; //create.js.erb等で.modal functionを読み込むために追加
import "popper.js";
import "bootstrap";
import "../stylesheets/application";
import "responsive-tab.js"; //homes#top,keyword searchページでのレスポンシブタブ表示用に追加
import "select-box.js" //users#showページでのレスポンシブタブ表示用に追加
import "notification-icon.js" //headerのnotification icon表示切替用に追加

Rails.start()
Turbolinks.start()
ActiveStorage.start()
