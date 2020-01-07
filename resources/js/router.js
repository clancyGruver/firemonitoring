import Vue from 'vue';
import VueRouter from 'vue-router';

Vue.use(VueRouter)

import Devices from './components/devices';
import Sensors from './components/sensors/sensors';
import MonitoringObjects from './components/monitoringObjects/index';
import MonitoringObjectEdit from './components/monitoringObjects/edit/monitoringObject';
import MonitoringObjectMedia from './components/monitoringObjects/edit/mediaFiles';
import ObjectEdit from './components/monitoringObjects/edit';
import ObjectNew from './components/monitoringObjects/new';
import LimitationsIndex from './components/limitations/index';
import limitationsEdit from './components/limitations/edit';
import statisticsIndex from './components/headerStatistics/index';
import ObjectDeviceLimitaion from './components/objectDevice/edit';
import reglamentsIndex from './components/reglaments/index';
import reglamentsEdit from './components/reglaments/edit';
import reglamentsDistinct from './components/reglaments/reglamentDistinct';
import ObjectDeviceReglament from './components/objectDevice/reglament/index';
import usersIndex from './components/users/index';
import userEdit from './components/users/edit';
import raionIndex from './components/raions/index';
import devicesIndex from './components/devices/index';
import devicesEdit from './components/devices/edit';
import sensorEdit from './components/sensors/form2';
import sensorCard from './components/sensors/card';
import objectEditBti from './components/leaflet/bti';
import Map from './components/leaflet/map';
import addSenor from './components/add-sensor';
import sensorReglaments from './components/monitoringObjects/reglament/index';
import sensorReglament from './components/monitoringObjects/reglament/distinct';
import districts from './components/districts/index';
import districtEdit from './components/districts/edit';
import planReglamentIndex from './components/plans/reglament/index';
import objectReports from './components/reports/object/index';

export const router = new VueRouter({
	mode: 'history',
	base: '/admin',
	routes: [
		{
			path: '/',
			name: 'index',
			component: statisticsIndex,
			meta: {
				title: ''
			},
		},
		{
			path: '/objects',
			name: 'objects',
			component: MonitoringObjects,
			props: true,
			meta: {
				title: 'Объекты мониторинга'
			},
		},
		{
			path: '/districts',
			name: 'districts',
			component: districts,
			props: true,
			meta: {
				title: 'Рабочие участки'
			},
			children:[
				{
					path: '/districts/edit/:districtId',
					name: 'districtEdit',
					component: districtEdit,
					meta: {
						title: 'Рабочий участок'
					},
				},
				/*{
					path: '/reglaments/:type/:deviceId/:reglamentId',
					name: 'reglamentsDistinct',
					component: reglamentsDistinct,
					meta: {
						title: 'Регламентные работы'
					},
				},*/
			]
		},
		{
			path: '/objects/new/',
			component: ObjectNew,
			meta: {
				title: 'Создание объекта мониторинга'
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
					path: 'reports',
					name: 'objectReports',
					component: objectReports,
				},
				{
				  path: 'devices',
				  name: 'objectEditDevices',
				  component: Devices
				},
				{
				  path: 'map',
				  name: 'objectEditMap',
				  component: Map
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
				},
				{
					path: 'limitation/:objectDeviceId',
					name: 'objectDeviceLimitaion',
					component: ObjectDeviceLimitaion
				},
				{
					path: 'reglament/:objectDeviceId',
					name: 'objectDeviceReglaments',
					component: ObjectDeviceReglament
				},
				{
					path: 'sensorReglament/:objectDeviceId/:wireId',
					name: 'sensorReglaments',
					props: true,
					component: sensorReglaments,
					children:[
						{
							path: ':sensorId',
							name: 'sensorReglament',
							component: sensorReglament
						},
					]
				},
				{
					path: 'bti/:containerName',
					name: 'objectEditBti',
					component: objectEditBti,
					props: true
				},
				{
					path: 'sensors/card/:deviceId',
					name:'sensorCard',
					component: sensorCard,
					props: true,
					meta: {
						title: 'Информация по сенсору'
					},
				},
				{
					path: 'device/:deviceId/wire/:wireId/sensors/:sensorId?',
					name:'addSensor',
					component: addSenor,
					props: true,
					meta: {
						title: 'Изменение сенсора'
					},
				},
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
		{
			path: '/reglaments',
			name: 'reglamentsIndex',
			component: reglamentsIndex,
			meta: {
				title: 'Регламентные работы'
			},
			children:[
				{
					path: '/reglaments/:type/:deviceId',
					name: 'reglamentsEdit',
					component: reglamentsEdit,
					meta: {
						title: 'Регламентные работы'
					},
				},
				{
					path: '/reglaments/:type/:deviceId/:reglamentId',
					name: 'reglamentsDistinct',
					component: reglamentsDistinct,
					meta: {
						title: 'Регламентные работы'
					},
				},
			]
		},
		{
			path: '/plans',
			name: 'planReglamentIndex',
			component: planReglamentIndex,
			meta: {
				title: 'Планы проведения регламентных работ'
			},
			/*children:[
				{
					path: '/plans/',
					name: 'planReglamentIndex',
					component: planReglamentIndex,
					meta: {
						title: 'Планы проведения регламентных работ'
					},
				},
			]*/
		},
		{
			path: '/users',
			name: 'usersIndex',
			component: usersIndex,
			meta: {
				title: 'Управление пользователями'
			},
		},
		{
			path: '/users/edit',
			name: 'userEdit',
			component: userEdit,
			props: true,
			meta: {
				title: 'Редактирование пользователя'
			},
		},
		{
			path: '/raions',
			name: 'raionIndex',
			component: raionIndex,
			props: true,
			meta: {
				title: 'Редактирование отображения районов'
			},
		},
		{
			path: '/devices',
			name: 'devicesIndex',
			component: devicesIndex,
			props: true,
			meta: {
				title: 'Администрирование оборудования'
			},
		},
		{
			path: '/devices/:device_type',
			name: 'devicesIndex',
			component: devicesIndex,
			props: true,
			meta: {
				title: 'Администрирование оборудования'
			},
		},
		{
			path: '/devices/sensors/edit/:deviceId?',
			name:'sensorEdit',
			component: sensorEdit,
			props: true,
			meta: {
				title: 'Редактирование оборудования'
			},
		},
		{
			path: '/devices/:device_type/edit/:deviceId?',
			name:'deviceEdit',
			component: devicesEdit,
			props: true,
			meta: {
				title: 'Редактирование оборудования'
			},
		},
	],
});