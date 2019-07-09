<template>
	<div>
		<antenna-device v-show="atennaEdit" :device="deviceData" />
		<add-device :creating="addDeviceShow" v-on:end-adding="addDeviceShow = !addDeviceShow" />
		<ul class="list-unstyled" v-for="(type, typeIdx) in treeData" :key="typeIdx">
			<h3 class="underline">{{type.name}}</h3>
			<li v-for="(device, index) in type.items" :key="device.id">
				<h4>
					<span @click="toggle(typeIdx, index)" class="pointer" v-if="['App\\device_aps','App\\device_system_voice_alert'].indexOf(typeIdx) >-1 ">
						<span v-if="device.isShow">-</span>
						<span v-else>+</span>
						{{ device.name }}
					</span>
					<span v-else>
						{{ device.name }}
					</span>
					<span class="badge badge-pill badge-info" v-if="typeIdx == 'App\\device_aps'">
						{{ device.wires.length }} / {{ device.wires_count }}
					</span>
					<i class="ml-4 fas fa-edit text-warning pointer" @click="editDevice(typeIdx, device)"></i>
					<i class="ml-2 fas fa-times text-danger pointer" @click="deleteDevice(typeIdx, device)"></i>
					<i class="ml-2 fas fa-map-marker text-danger pointer" @click="setMarker(typeIdx, device)"></i>
				</h4>
				<wire-tree v-show="device.isShow" :wires="device.wires" :wires_count="device.wires_count" :typeIdx="typeIdx" :ObjectDeviceId="device.id" />
			</li>
		</ul>
		<hr class="mt-2">
		<button type="button" class="btn btn-success mt-4" @click="addDeviceShow = true">Добавить оборудование</button>
	</div>
</template>

<script>
	import addDevice from '../add-device';
	import wireTree from './wireTree';
	//import alarmDevices from './alarmDevices';
	import antennaDevice from '../editForms/antenna';

	export default
	{
		components: {
			addDevice,
			wireTree,
			antennaDevice,
		},
		props: {
		},
		data: function () {
			return {
				tData: {},
				addDeviceShow: false,
				atennaEdit: false,

				FormMethodAllowed: ['new','edit'],
				ObjectDeviceId: null,
				typeIdx: null,

				deviceFormShow: false,
				deviceFormMethod: 'edit',
				deviceData:{},
			}
		},
		methods: {
			toggle(typeIdx, idx){
				this.$store.commit('TOGGLE_DEVICE_SHOW', {typeIdx, idx});
				//this.treeData[typeIdx].items[idx].isShow = !this.treeData[typeIdx].items[idx].isShow;
			},
			editDevice(typeIdx, device){
				this.deviceFormShow = true;
				this.deviceFormMethod = 'edit';
				this.deviceData = device;
				console.log(typeIdx);
				if(typeIdx == 'App\\device_antenna')
					this.atennaEdit = true;
			},
			deleteDevice(typeIdx, device){
				if(confirm(`Вы действительно хотите удалить ${device.name}`)){
				  this.$store.commit('DELETE_DEVICE', {typeIdx:typeIdx, deviceId:device.id});
				}
			},
			setMarker(typeIdx, device){
				this.$store.commit('TOGGLE_MAP');
				this.$store.commit('SET_MAP_ACTIVE_DEVICE',{typeIdx:typeIdx, deviceId:device.id});
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