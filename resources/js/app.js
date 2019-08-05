require('./bootstrap');

import Vue from 'vue';

import { store } from './store';
import { router } from './router';
import isLoggedMixin from './mixins/auth.js';

//Leaflet setup
import L from 'leaflet';
import "leaflet/dist/leaflet.css";
delete L.Icon.Default.prototype._getIconUrl;

L.Icon.Default.mergeOptions({
  iconRetinaUrl: require('leaflet/dist/images/marker-icon-2x.png'),
  iconUrl: require('leaflet/dist/images/marker-icon.png'),
  shadowUrl: require('leaflet/dist/images/marker-shadow.png'),
});

//Awesome Notifications
import VueAWN from "vue-awesome-notifications"
const AWNparams = {
    labels:{
        success: 'Успешно',
        alert: 'Ошибка'
    }
};
require("vue-awesome-notifications/dist/styles/style.css");
Vue.use(VueAWN, AWNparams);

//components
import App from './components/main.vue';

const app = new Vue({
    el: '#app',
    components: { App },
    store,
    router,
    mixins:[isLoggedMixin],
    data: {
        user: false
    },
    created(){
        this.checkIfLogged()
            .then(response => {
                    this.user = response ? response : false;
                    this.$store.commit('SET_USER', this.user);
                    window.axios.defaults.headers.common['X-USER'] = this.user.id;
                })
            .catch(error => console.log(error));
    }
});
