// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.scss"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import deps with the dep name or local files with a relative path, for example:
//
//     import {Socket} from "phoenix"
//     import socket from "./socket"

// Some parts of code below were taken from Professor Nat Tuck's scratch repository

import "phoenix_html"
import 'bootstrap';
import flatpickr from 'flatpickr';

flatpickr('.datetime', { enableTime: true, dateFormat: "Y-m-d H:i" })