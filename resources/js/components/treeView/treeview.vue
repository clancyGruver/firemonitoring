<template>
	<div>
		<button
			type="button"
			class="btn btn-outline-success mt-4"
			@click="addDeviceShow = !addDeviceShow"
		>
			Добавить оборудование
		</button>
		<add-device
			:creating="addDeviceShow"
			v-on:end-adding="addDeviceShow = !addDeviceShow"
		/>
		<add-antenna
			:deviceData="deviceData"
		/>
		<alarm-devices
			v-show="addAlarmShow"
			:deviceData="deviceData"
			v-on:end-adding="addAlarmShow = false"
		/>
		<rspi-params
			v-show="rspiParamsShow"
			v-on:end-adding="rspiParamsShow = false"
			:deviceData="deviceData"
		/>
		<hr class="mt-2">
		
		<ul class="list-unstyled" v-for="(type, typeIdx) in tree" :key="typeIdx">
			<h3 class="underline">{{type.name}}</h3>
			<li v-for="device in type.items" :key="device.id">
				<h4>
					<router-link class="ml-2 fas pointer"
							:class="{
								'fa-times-circle text-danger': !device.is_good,
								'fa-check-circle text-success': device.is_good,
							}"
							:to="{
								name: 'objectDeviceLimitaion',
								params:{
									objectDeviceId: device.id,
									typeIdx,
								}
							}"
							tag="i">
					</router-link>
					<router-link class="ml-2 fas pointer"
							:class="{
								'fa-times-circle text-danger': !isReglamented(device.id),
								'fa-check-circle text-success': isReglamented(device.id),
							}"
							:to="{
								name: 'objectDeviceReglaments',
								params:{
									objectDeviceId: device.id,
									typeIdx,
								}
							}"
							tag="i">
					</router-link>
					<span @click="toggle(device)" class="pointer" v-if="['App\\device_rspi','App\\device_aps','App\\device_system_voice_alert'].indexOf(typeIdx) >-1 ">
						<span v-if="device.isShow">-</span>
						<span v-else>+</span>
						{{ device.name }}
					</span>
					<span v-else>
						{{ device.name }}
					</span>
					<span>
						<date-picker
							v-model="device.setup_year"
							lang="ru"
							type="year"
							format="YYYY"
							@input="dateChanged(device)"
						/>
					</span>
					<span class="badge badge-pill badge-info" v-if="typeIdx == 'App\\device_aps'">
						{{ device.wires.length }} / {{ device.wires_count }}
					</span>
					<i class="ml-4 fas fa-edit text-warning pointer" @click="editDevice(typeIdx, device)"></i>
					<i class="ml-2 fas fa-times text-danger pointer" @click="deleteDevice(device)"></i>
					<i v-if="btiIsset" class="ml-2 fas fa-map-marker text-danger pointer" @click="setMarker(typeIdx, device)"></i>
				</h4>
				<div v-show="device.isShow && ['App\\device_rspi','App\\device_system_voice_alert'].includes(typeIdx)"  >
					<alert-system-devices :items="device.alarms" :typeIdx="typeIdx" />
					<button type="button" class="btn btn-outline-success mt-4" @click="addChildrenNodeHandler(typeIdx, device)">
						Добавить {{typeIdx == 'App\\device_system_voice_alert' ? 'оповещатель' : 'антенну'}}
					</button>
				</div>
				<wire-tree v-show="device.isShow && typeIdx == 'App\\device_aps'" :wires="device.wires" :wires_count="device.wires_count" :typeIdx="typeIdx" :ObjectDeviceId="device.id" />
			</li>
		</ul>
	</div>
</template>

<script>
import DatePicker from 'vue2-datepicker'
import addDevice from '../add-device';
import wireTree from './wireTree';
import alarmDevices from '../alarmDevices';
import alertSystemDevices from './alertSystemDevices';
import addAntenna from './antenna/add-antenna';
import rspiParams from '../editForms/rspiParams';

	export default
	{
		components: {
			addDevice,
			wireTree,
			alarmDevices,
			alertSystemDevices,
			DatePicker,
			rspiParams,
			addAntenna,
		},
		data: function () {
			return {
				addAlarmShow:false,
				addDeviceShow: false,

				FormMethodAllowed: ['new','edit'],
				ObjectDeviceId: null,
				typeIdx: null,

				deviceFormShow: false,
				deviceFormMethod: 'edit',
				deviceData:{},

				rspiParamsShow: false,
			}
		},
		methods: {
			addChildrenNodeHandler(typeIdx, device){
				if(typeIdx === 'App\\device_system_voice_alert'){
					this.addAlarmShow = true;
				}
				else if(typeIdx === 'App\\device_rspi'){
					this.$modal.show('add-antenna')
				}
				this.deviceData = device
			},
			dateChanged(device){
				this.$store.dispatch('SET_DEVICE_SETUP_YEAR', {
					setup_year: device.setup_year.getFullYear(),
					object_device_id: device.id,
				});
			},
			isReglamented(deviceId){ return !this.notReglamented.includes(deviceId) },
			toggle(device){ this.$store.dispatch('TOGGLE_DEVICE_SHOW', device.id) },
			editDevice(typeIdx, device){
				this.deviceFormShow = true;
				this.deviceFormMethod = 'edit';
				if(!('device_id' in device.params))
					device.params.device_id = device.id;
				device.params.tbl_name = typeIdx;
				this.deviceData = device.params;
				if(typeIdx == 'App\\device_antenna')
					this.atennaEdit = true;
				else if(typeIdx == 'App\\device_rspi')
					this.rspiParamsShow = true;
			},
			deleteDevice(device){
				if(confirm(`Вы действительно хотите удалить ${device.name}`)){
				  this.$store.dispatch('DELETE_OBJECT_DEVICE', device.id);
				}
			},
			setMarker(typeIdx, device){
				this.$store.commit('TOGGLE_MAP');
				this.$store.commit('SET_MAP_ACTIVE_DEVICE',{typeIdx:typeIdx, deviceId:device.id});
			}
		},
		computed: {
			btiIsset(){return this.$store.getters.CURRENT_OBJECT.btifiles.length > 0},
			notReglamented(){return this.$store.getters.UNREGLAMENTED_DEVICES},
			tree(){return this.$store.getters.DEVICE_TREE},
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