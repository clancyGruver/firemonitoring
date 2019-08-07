import Vue from 'vue';
import VueRouter from 'vue-router';

Vue.use(VueRouter)

import Devices from './components/devices';
import Sensors from './components/sensors/sensors';
import MonitoringObjects from './components/monitoringObjects/index';
import MonitoringObjectEdit from './components/monitoringObjects/edit/monitoringObject';
import MonitoringObjectMedia from './components/monitoringObjects/edit/mediaFiles';
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
			component: MonitoringObjects,
			meta: {
				title: 'Объекты мониторинга'
			},
		},
		{
			path: '/objects/:id/',
			component: ObjectEdit,
			meta: {
				title: 'Редактирование объекта мониторинга'
			},
			children: [
				{
					path: '',
					beforeEnter: (to, from, next) => {
						next({ name: 'MonitoringObjectEdit' })
					},
				},
				{
				  path: 'devices',
				  name: 'objectEditDevices',
				  component: Devices
				},
				{
					path: 'main',
					name: 'MonitoringObjectEdit',
					component: MonitoringObjectEdit
				},
				{
					path: 'media',
					name: 'objectEditMedia',
					component: MonitoringObjectMedia
				}
			  ]
		},
		{
			path: '/limitations',
			name: 'limitationsIndex',
			component: LimitationsIndex,
			meta: {
				title: 'Недостатки оборудования'
			},
			children:[
				{
					path: '/limitations/:type/:id',
					name: 'limitationsEdit',
					component: limitationsEdit,
					meta: {
						title: 'Недостатки оборудования'
					},
				},
			]
		},
	],
});