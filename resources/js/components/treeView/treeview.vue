<template>
	<div>
		<add-wire :creating="addWireShow" v-on:end-adding="addWire" :odid="ObjectDeviceId" />
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
			:sensorData="sensorData"
		/>

		<ul class="list-unstyled">		
			<li v-for="(device, index) in treeData" :key="device.id">
				<h4 @click="toggle(index)" class="pointer">
					<span v-if="device.isShow">-</span> 
					<span v-else>+</span> 
					{{ device.name }}
				</h4>
				<ul v-show="device.isShow"  class="list-unstyled">
					<li v-for="wire, wireIndex in device.wires">
						<h3 class="pl-4 pointer" @click="toggleWire(index, wireIndex)">
							<span v-if="wire.isShow">-</span> 
							<span v-else>+</span> 
							{{ wire.description }}
							<span class="badge badge-pill badge-info">{{ wire.sensors.length }}</span>
						</h3>
						<ul v-show="wire.isShow"  class="list-unstyled">
							<li v-for="(sensor, sensorIdx) in wire.sensors" key="sensor.id">
								<h3 class="pl-5">
									{{ sensor.name }}
									<i class="fas fa-search text-info pointer" @click="
									sensorData = sensor; sensorCardShow = true"></i>
									<i class="fas fa-edit text-warning pointer"@click="editSensor(device.id, sensor)"></i>
								</h3>								
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
			<hr class="mt-2">
			<li>
				<button type="button" class="btn btn-success mt-4" @click="addDeviceShow = true">Добавить оборудование</button>
			</li>
		</ul>
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
				sensorFormShow: false,
				sensorFormMethod: 'new',
				sensorFormMethodAllowed: ['new','edit'],
				ObjectDeviceId: null,				
				sensorCardShow: false,
				sensorData:{
					name: null,
					deviceId: null,
					wire_id: null,
					sensor_id: null,
				},
			}
		},
		methods: {
			addWire(odid){ 
				this.ObjectDeviceId= odid ? odid : null; 
				this.addWireShow = !this.addWireShow 
			},
			toggle(idx){
				this.treeData[idx].isShow = !this.treeData[idx].isShow;
			},
			toggleWire(idx,wireIdx){
				this.treeData[idx].wires[wireIdx].isShow = !this.treeData[idx].wires[wireIdx].isShow;	
			},
			addSensor(did, wid, sensorsCount){
				if(this.sensorFormMethod == this.sensorFormMethodAllowed[1])
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
				this.sensorFormMethod = this.sensorFormMethodAllowed[0];
			},
			showSensorInfo(sensor){
				console.log('showSensorInfo', sensor);
			},
			editSensor(did, sensor){				
				this.sensorFormShow = true;
				this.sensorFormMethod = this.sensorFormMethodAllowed[1];
				this.sensorData = sensor;
				Vue.set(this.sensorData, 'deviceId', did);
			},
			sensorEndAdding: function (params) {
				Vue.set(this.sensorData, 'cabinetName', params.cabinetName);
				Vue.set(this.sensorData, 'floor', params.floor);
				Vue.set(this.sensorData, 'isGood', params.isGood);
				Vue.set(this.sensorData, 'SP5Valid', params.SP5Valid);
				this.sensorFormShow = !this.sensorFormShow;
			},
		},
		computed: {
			treeData: function () {return this.$store.getters.DEVICES},			
		}
	}
</script>

<style scoped>
	.pointer{
		cursor:pointer;
	}
</style>