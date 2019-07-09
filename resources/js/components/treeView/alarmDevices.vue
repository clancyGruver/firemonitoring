<template>
	<ul class="list-unstyled">
		<addSensor
			:creating="sensorFormShow"
			:method="sensorFormMethod"
			v-on:end-adding="alarmEndAdding"
			:alarmData="alarmData"
			:typeIdx="typeIdx"
			:ObjectDeviceId="ObjectDeviceId"
		/>
		<sensorCard
			:edit ="alarmCardShow"
			v-on:end-adding="alarmCardShow = !alarmCardShow"
			:sensorData="alarmInfoData"
		/>
		<li>
			<div class="table-responsive">
				<table class="table align-items-center table-dark">
					<thead class="thead-dark">
						<tr>
							<th scope="col">Модель</th>
							<th scope="col">Наименование</th>
							<th scope="col">Этаж</th>
							<th scope="col">Кабинет</th>
							<th scope="col">Соответствие СП5</th>
							<th scope="col">Исправность</th>
							<th scope="col">Комментарий</th>
							<th scope="col"></th>
						</tr>
					</thead>
					<tbody>
						<tr v-for="sensor in sensors" :key="sensor.id" :sensorInfoData="$store.getters.SENSOR(sensor.sensor_id)">
							<td>
								{{ sensorInfoData.name }}
								<span
									class="badge badge-info"
									@click="sensorCardShow = !sensorCardShow;"
								>
									<i class="fas fa-question"></i>
								</span>
							</td>
							<td>{{ sensor.name }}</td>
							<td>{{ sensor.floor }}</td>
							<td>{{ sensor.cabinet_name }}</td>
							<td>
								<i class="fas fa-check text-success" v-if="sensor.SP5_valid"></i>
								<i class="fas fa-times text-danger" v-else></i>
							</td>
							<td>
								<i class="fas fa-check text-success" v-if="sensor.is_good"></i>
								<i class="fas fa-times text-danger" v-else></i>
							</td>
							<td>
								{{ sensor.comment }}
							</td>
							<td>
								<i class="fas fa-edit text-warning pointer" @click="editSensor(sensor)"></i>
								<i class="ml-2 fas fa-times text-danger pointer" @click="deleteSensor(sensor)"></i>
								<i class="ml-2 fas fa-map-marker text-danger pointer" @click="setMarker(sensor)"></i>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</li>
		<li>
			<button type="button" class="ml-4 btn btn-success" @click="addSensor(wireId, sensors.length )">Добавить извещатель</button>
		</li>
	</ul>
</template>

<script>
	import addSensor from '../add-sensor';
	import sensorCard from '../sensors/card';

	export default
	{
		components: {
			addSensor,
			sensorCard,
		},
		props: ['typeIdx', 'ObjectDeviceId', 'wireId', 'sensors'],
		data: function () {
			return {
				sensorFormShow: false,
				sensorFormMethod: 'new',
				FormMethodAllowed: ['new','edit'],
				sensorCardShow: false,
				sensorData:{
					name: null,
					deviceId: null,
					wire_id: null,
					sensor_id: null,
					comment: null,
				},

				sensorInfoData:{},
			}
		},
		methods: {
			getSensorInfoData(id){this.sensorInfoData = this.$store.getters.SENSOR(id)},
			addSensor(wid, sensorsCount){
				if(this.sensorFormMethod == this.FormMethodAllowed[1])
					this.sensorData = {
						deviceId: this.ObjectDeviceId,
						wire_id: wid,
						name: ++sensorsCount,
						cabinet_name: '',
						comment:'',
					}
				else{
					Vue.set(this.sensorData, 'deviceId', this.ObjectDeviceId);
					Vue.set(this.sensorData, 'wire_id', wid);
					Vue.set(this.sensorData, 'name', ++sensorsCount);
					Vue.set(this.sensorData, 'cabinet_name', '');
					Vue.set(this.sensorData, 'comment', '');
				}
				this.sensorFormShow = true;
				this.sensorFormMethod = this.FormMethodAllowed[0];
			},
			showSensorInfo(sensor){
				console.log('showSensorInfo', sensor);
			},
			editSensor(sensor){
				this.sensorFormShow = true;
				this.sensorFormMethod = this.FormMethodAllowed[1];
				this.sensorData = sensor;
				Vue.set(this.sensorData, 'deviceId', this.ObjectDeviceId);
			},
			sensorEndAdding: function (params) {
				Vue.set(this.sensorData, 'cabinet_name', params.cabinet_name);
				Vue.set(this.sensorData, 'floor', params.floor);
				Vue.set(this.sensorData, 'is_good', params.is_good);
				Vue.set(this.sensorData, 'SP5_valid', params.SP5_valid);
				Vue.set(this.sensorData, 'sensor_id', params.sensor_id);
				this.sensorFormShow = !this.sensorFormShow;
			},
			setMarker(sensor){
				const typeIdx = this.typeIdx,
					  deviceId = this.ObjectDeviceId,
					  wid = this. wireId;
				this.$store.commit('TOGGLE_MAP');
				this.$store.commit('SET_MAP_ACTIVE_SENSOR',{typeIdx,deviceId,wid,sensor});
			},
			deleteSensor(sensor){
				if(confirm(`Вы действительно хотите удалить ${sensor.name}`)){
				  this.$store.commit('DELETE_SENSOR_ON_WIRE', {
				  	typeIdx: this.typeIdx,
				  	wireId: this.wireId,
				  	ObjectDeviceId: this.ObjectDeviceId,
				  	sensorId:sensor.id
				  });
				}
			},
		},
		computed: {
		}
	}
</script>

<style scoped>
	.underline{
		text-decoration: underline;
	}
	.pointer{
		cursor:pointer;
	}
</style>