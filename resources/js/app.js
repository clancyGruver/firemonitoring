require('./bootstrap');

import Vue from 'vue';

import { store } from './store';
import { router } from './router';
import isLoggedMixin from './mixins/auth.js';

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
