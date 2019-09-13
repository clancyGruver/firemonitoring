<template>
	<ul class="list-unstyled">
		<!--addSensor
			:creating="sensorFormShow"
			:method="sensorFormMethod"
			v-on:end-adding="sensorEndAdding"
			:sensorData="sensorData"
			:typeIdx="typeIdx"
			:ObjectDeviceId="ObjectDeviceId"
			:wireId="wireId"
		/-->
		<li>
			<router-link
				type="button"
				class="ml-4 btn btn-outline-success"
				:to="{
					name: 'addSensor',
					params:{
						deviceId: ObjectDeviceId,
						wireId: wireId,
					}
				 }"
			>
				Добавить извещатель
			</router-link>
			<router-link
				type="button"
				class="ml-4 btn btn-outline-warning"
				:to="{
					name: 'sensorReglaments',
					params:{
						objectDeviceId: ObjectDeviceId,
						wireId: wireId,
					}
				 }"
			>
				Регламент сенсоров
				<span class="badge badge-warning">{{$store.getters.UNREGLAMENTED_SENSORS_ON_WIRE(ObjectDeviceId, wireId).length}}</span>
			</router-link>
		</li>
		<li class="mt-2">
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
						<tr v-for="sensor in sensors" :key="sensor.id">
							<td>
								{{ getSensorName(sensor.sensor_id) }}
								<router-link
									class="badge badge-info"
									tag="span"
									:to="{
			                        	name: 'sensorCard',
										params:{deviceId:sensor.sensor_id}
			                      	}"
		                      	>
		                      		<i class="fas fa-question"></i>
		                      	</router-link>
								<!--span
									class=""
									@click="showSensorInfo(sensor.sensor_id)"
								>
									<i class="fas fa-question"></i>
								</span-->
							</td>
							<td>{{ sensor.name }}</td>
							<td>{{ sensor.floor }}</td>
							<td>{{ sensor.cabinet_name }}</td>
							<td>
								<i
									class="fas"
									:class="
										sensor.SP5_valid
										? 'text-success fa-check'
										: 'text-danger fa-times'
									"
								></i>
							</td>
							<td>
								<i
									class="fas"
									:class="
										sensor.is_good
										? 'text-success fa-check'
										: 'text-danger fa-times'
									"
								></i>
							</td>
							<td>
								{{ sensor.comment }}
							</td>
							<td>
								<router-link
									tag="i"
									class="fas fa-edit text-warning pointer"
									:to="{
										name: 'addSensor',
										params:{
											deviceId: ObjectDeviceId,
											wireId: wireId,
											sensorId: sensor.id,
										}
									 }"
								>
								</router-link>
								<i class="ml-2 fas fa-times text-danger pointer" @click="deleteSensor(sensor)"></i>
								<i class="ml-2 fas fa-map-marker text-danger pointer" @click="setMarker(sensor)"></i>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</li>
	</ul>
</template>

<script>
	export default
	{
		components: {},
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
				sensorID:null,
			}
		},
		methods: {
			getSensorName(id) {
				return this.$store.getters.SENSOR_NAME(id);
			},
			showSensorInfo(id){
				this.sensorID = id;
				this.sensorCardShow = !this.sensorCardShow;
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
				  this.$store.dispatch('DELETE_SENSOR_ON_WIRE', {
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