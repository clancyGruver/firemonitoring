import Vue from 'vue';
import VueRouter from 'vue-router';

Vue.use(VueRouter)

import Devices from './components/devices';
import Sensors from './components/sensors/sensors';
import MonitoringObjects from './components/monitoringObjects/index';
import ObjectEdit from './components/monitoringObjects/edit';
import LimitationsIndex from './components/limitations/index';
import limitationsEdit from './components/limitations/edit';

export const router = new VueRouter({
	mode: 'history',
	base: '/admin',
	routes: [
		{
			path: '/objects',
			name: 'objects',
			component: MonitoringObjects
		},
		{
			path: '/objects/:id',
			name: 'objectEdit',
			component: ObjectEdit
		},
		{
			path: '/limitations',
			name: 'limitationsIndex',
			component: LimitationsIndex
		},
		{
			path: '/limitations/:id',
			name: 'limitationsEdit',
			component: limitationsEdit
		}
	],
});