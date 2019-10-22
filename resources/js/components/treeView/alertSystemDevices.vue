<template>
	<div>
		<antenna-device
			v-show="atennaEdit"
			:deviceData="deviceData"
			v-on:end-adding="atennaEdit=false"
		/>
		<ul class="list-unstyled">
			<li  v-for="(item, itemIdx) in items" :key="itemIdx">
				<h4 class="pl-4 ml-4">
					<router-link class="ml-2 fas pointer"
							:class="{
								'fa-times-circle text-danger': !item.is_good,
								'fa-check-circle text-success': item.is_good,
							}"
							:to="{
								name: 'objectDeviceLimitaion',
								params:{
									objectDeviceId: item.id,
								}
							}"
							tag="i">
					</router-link>
					<router-link class="ml-2 fas pointer"
							:class="{
								'fa-times-circle text-danger': !isReglamented(item.id),
								'fa-check-circle text-success': isReglamented(item.id),
							}"
							:to="{
								name: 'objectDeviceReglaments',
								params:{
									objectDeviceId: item.id,
								}
							}"
							tag="i">
					</router-link>
					{{ item.name }}
					<i class="ml-4 fas fa-edit text-warning pointer" @click="editDevice(item)"></i>
					<i class="ml-2 fas fa-times text-danger pointer" @click="deleteDevice(item)"></i>
					<i class="ml-2 fas fa-map-marker text-danger pointer" @click="setMarker(item)"></i>
				</h4>
			</li>
		</ul>
	</div>
</template>

<script>
import antennaDevice from '../editForms/antenna';
export default
{
	components: {antennaDevice},
	props: ['items','typeIdx'],
	data: function () {
		return {
			atennaEdit: false,
			deviceData: {},
		}
	},
	methods: {
		editDevice(item){
			if(this.typeIdx == 'App\\device_rspi'){
				this.atennaEdit = !this.atennaEdit;
				this.deviceData = device.params ? device.params : {};
			}
			return false;
		},
		deleteDevice(device){
			if(confirm(`Вы действительно хотите удалить ${device.name}`)){
				this.$store.dispatch('DELETE_OBJECT_DEVICE', device.id);
			}
		},
		isReglamented(deviceId){ return !this.notReglamented.includes(deviceId) },
		setMarker(device){
			this.$store.commit('TOGGLE_MAP');
			this.$store.commit('SET_MAP_ACTIVE_ALARM',{
				typeIdx: this.typeIdx,
				alertId: device.id,
				deviceId: device.parent_device_id,
			});
		},
	},
	computed:{
		notReglamented(){return this.$store.getters.UNREGLAMENTED_DEVICES},
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