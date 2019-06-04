require('./bootstrap');

window.Vue = require('vue');

Vue.component('devices', require('./components/devices.vue').default);

import { store } from './store';

const app = new Vue({
    el: '#devices',
    store
});
