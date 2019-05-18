require('./bootstrap');
import Vue from 'vue';
import ShardsVue from 'shards-vue';

// Core
import App from './components/layer/admin.vue';
import router from './adminrouter';
import { Icon }  from 'leaflet';

// Layouts
import Default from './components/layer/Default.vue';

// Styles
import 'bootstrap/dist/css/bootstrap.css';
import '../scss/shards-dashboards.scss';
import '../scss/date-range.scss';
import 'leaflet/dist/leaflet.css';

delete Icon.Default.prototype._getIconUrl;

Icon.Default.mergeOptions({
    iconRetinaUrl: require('leaflet/dist/images/marker-icon-2x.png'),
    iconUrl: require('leaflet/dist/images/marker-icon.png'),
    shadowUrl: require('leaflet/dist/images/marker-shadow.png')
  });
  
//Vue.use(VueRouter)
ShardsVue.install(Vue);

Vue.component('default-layout', Default);

Vue.config.productionTip = false;
Vue.prototype.$eventHub = new Vue();

new Vue({
  router,
  render: h => h(App),
}).$mount('#app');

