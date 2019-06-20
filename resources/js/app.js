require('./bootstrap');

window.Vue = require('vue');

Vue.component('devices', require('./components/devices.vue').default);
Vue.component('sensors', require('./components/sensors/sensors.vue').default);

import { store } from './store';
import isLoggedMixin from './mixins/auth.js';


const app = new Vue({
    el: '#app',
    store,
    mixins:[isLoggedMixin],
    data: {
        user: false
    },
    created(){
        this.checkIfLogged()
            .then(response => {
                    this.user = response ? response : false;
                    this.$store.commit('SET_USER', this.user);
                })
            .catch(error => console.log(error));
    }
});
