<template>
	<div>
		<add-wire
			:creating="addWireShow"
			v-on:end-adding="addWireShow = !addWireShow"
			:odid="ObjectDeviceId"
			:newWire="wireData"
			:mode="wireMode"
		/>
		<add-device :creating="addDeviceShow" v-on:end-adding="addDeviceShow = !addDeviceShow" />
		<addSensor
			:creating="sensorFormShow"
			:method="sensorFormMethod"
			v-on:end-adding="sensorEndAdding"
			:sensorData="sensorData"
		/>
		<sensorCard
			:edit ="sensorCardShow"
			v-on:end-adding="sensorCardShow = !sensorCardShow"
			:sensorData="sensorInfoData"
		/>
		<div v-for="type, typeIdx in treeData" :key="typeIdx">
			<h3 class="underline">{{type.name}}</h3>
			<h4 v-for="(device, index) in type.items" :key="device.id">
				<span @click="toggle(typeIdx, index)" class="pointer">
					{{ device.name }} {{ device.isShow }}
				</span>
			</h4>
		</div>

		<ul class="list-unstyled" v-for="type, typeIdx in treeData">
			<h3 class="underline">{{type.name}}</h3>
			<li v-for="(device, index) in type.items" :key="device.id">
				<h4>
					<span @click="toggle(typeIdx, index)" class="pointer">
						<span v-if="device.isShow">-</span>
						<span v-else>+</span>
						{{ device.name }} {{ device.isShow }}
					</span>
					<span class="badge badge-pill badge-info">
						{{ device.wires.length }} / {{ device.wires_count }}
					</span>
					<i class="ml-4 fas fa-edit text-warning pointer" @click="editDevice(device)"></i>
					<i class="ml-2 fas fa-times text-danger pointer" @click="deleteDevice(device)"></i>
				</h4>
				<ul v-show="device.isShow"  class="list-unstyled">
					<li v-for="wire, wireIndex in device.wires">
						<h3 class="pl-4 pointer">
							<span @click="toggleWire(typeIdx, index, wireIndex)">
								<span v-if="wire.isShow">-</span>
								<span v-else>+</span>
								{{ wire.description }}
							</span>
							<span class="badge badge-pill badge-success" v-if="wire.type == 'safe'">ПБ</span>
							<span class="badge badge-pill badge-danger" v-else-if="wire.type == 'unsafe'">ПО</span>
							<span class="badge badge-pill badge-default" v-else-if="wire.type == 'radio'">Радио</span>
							<span class="badge badge-pill badge-info">{{ wire.sensors.length }}</span>
							<i class="ml-4 fas fa-edit text-warning pointer" @click="editWire(wire)"></i>
							<i class="ml-2 fas fa-times text-danger pointer" @click="deleteWire(wire)"></i>
						</h3>
						<ul v-show="wire.isShow"  class="list-unstyled">
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
											<tr v-for="(sensor, sensorIdx) in wire.sensors" :key="sensor.id" :sensorInfoData="$store.getters.SENSOR(sensor.sensor_id)">
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
													<i class="fas fa-edit text-warning pointer" @click="editSensor(device.id, sensor)"></i>
												</td>
											</tr>
										</tbody>
									</table>
								</div>
							</li>
							<li>
								<button type="button" class="ml-4 btn btn-success" @click="addSensor(device.id, wire.id, wire.sensors.length )">Добавить сенсор</button>
							</li>
						</ul>
					</li>
					<li v-if="device.wires.length < device.wires_count" class="mt-2">
						<button type="button" class="btn btn-success" @click="addWire(device.id)">Добавить шлейф</button>
					</li>
				</ul>
			</li>
		</ul>
		<hr class="mt-2">
		<button type="button" class="btn btn-success mt-4" @click="addDeviceShow = true">Добавить оборудование</button>
	</div>
</template>

<script>
	import addDevice from '../add-device';
	import addWire from '../add-wire';
	import addSensor from '../add-sensor';
	import sensorCard from '../sensors/card';

	export default
	{
		components: {
			addDevice,
			addWire,
			addSensor,
			sensorCard,
		},
		props: {
		},
		data: function () {
			return {
				isShow: true,
				addDeviceShow: false,
				addWireShow: false,
				wireMode: 'new',
				wireData:{
					is_good: true,
					type: 'unsafe',
				},

				sensorFormShow: false,
				sensorFormMethod: 'new',
				FormMethodAllowed: ['new','edit'],
				ObjectDeviceId: null,
				sensorCardShow: false,
				sensorData:{
					name: null,
					deviceId: null,
					wire_id: null,
					sensor_id: null,
				},

				sensorInfoData:{},

				deviceFormShow: false,
				deviceFormMethod: 'edit',
				deviceData:{

				},
			}
		},
		methods: {
			getSensorInfoData(id){this.sensorInfoData = this.$store.getters.SENSOR(id)},
			addWire(odid){
				this.ObjectDeviceId= odid ? odid : null;
				this.addWireShow = !this.addWireShow;
				this.wireMode = 'new';
				this.wireData = wire;
			},
			editWire(wire){
				this.addWireShow = true;
				this.wireMode = 'edit';
				this.wireData = wire;
			},
			deleteWire(wire){
				if(confirm(`Вы действительно хотите удалить ${wire.description}`)){
				  this.$store.commit('DELETE_WIRE', wire.id);
				}
			},
			toggle(typeIdx, idx){
				this.$store.commit('TOGGLE_DEVICE_SHOW', {typeIdx, idx});
				//this.treeData[typeIdx].items[idx].isShow = !this.treeData[typeIdx].items[idx].isShow;
			},
			toggleWire(typeIdx, idx,wireIdx){
				this.treeData[typeIdx].items[idx].wires[wireIdx].isShow = !this.treeData[typeIdx].items[idx].wires[wireIdx].isShow;
			},
			addSensor(did, wid, sensorsCount){
				if(this.sensorFormMethod == this.FormMethodAllowed[1])
					this.sensorData = {
						deviceId: did,
						wire_id: wid,
						name: ++sensorsCount,
					}
				else{
					Vue.set(this.sensorData, 'deviceId', did);
					Vue.set(this.sensorData, 'wire_id', wid);
					Vue.set(this.sensorData, 'name', ++sensorsCount);
				}
				this.sensorFormShow = true;
				this.sensorFormMethod = this.FormMethodAllowed[0];
			},
			showSensorInfo(sensor){
				console.log('showSensorInfo', sensor);
			},
			editSensor(did, sensor){
				this.sensorFormShow = true;
				this.sensorFormMethod = this.FormMethodAllowed[1];
				this.sensorData = sensor;
				Vue.set(this.sensorData, 'deviceId', did);
			},
			editDevice(device){
				this.deviceFormShow = true;
				this.deviceFormMethod = this.deviceFormMethodAllowed[1];
				this.deviceData = device;
			},
			deleteDevice(device){
				if(confirm(`Вы действительно хотите удалить ${device.name}`)){
				  this.$store.commit('DELETE_DEVICE', device.id);
				}
			},
			sensorEndAdding: function (params) {
				Vue.set(this.sensorData, 'cabinet_name', params.cabinet_name);
				Vue.set(this.sensorData, 'floor', params.floor);
				Vue.set(this.sensorData, 'is_good', params.is_good);
				Vue.set(this.sensorData, 'SP5_valid', params.SP5_valid);
				this.sensorFormShow = !this.sensorFormShow;
			},
		},
		computed: {
			treeData() {return this.$store.getters.DEVICES},
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