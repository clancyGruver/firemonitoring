<template>
	<div>
		<add-wire :creating="addWireShow" v-on:end-adding="addWire" :odid="ObjectDeviceId" />
		<add-device :creating="addDeviceShow" v-on:end-adding="addDeviceShow = !addDeviceShow" />
		<addSensor 
			:creating="addSensorShow" 
			v-on:end-adding="addSensorShow = !addSensorShow" 
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
						</h3>
						<ul v-show="wire.isShow"  class="list-unstyled">
							<li v-for="(sensor, sensorIdx) in wire.sensors">
								<h3 class="pl-5" @cilck="showSensorInfo(sensor)">
									{{ sensor.name }}
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
	export default
	{
		components: {
			addDevice,
			addWire,
			addSensor
		},
		props: {
		},
		data: function () {
			return {				
				isShow: true,
				addDeviceShow: false,
				addWireShow: false,
				addSensorShow: false,
				ObjectDeviceId: null,				
				sensorData:{
					name: null,
					deviceId: null,
					wireId: null,
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
				this.sensorData = {
					deviceId: did,
					wireId:   wid,
					name:     ++sensorsCount
				}
				this.addSensorShow = true;
			},
			showSensorInfo(sensor){
				console.log(sensor);
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