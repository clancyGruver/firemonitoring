<template>
	<section>
		<div class="row">
			<p>{{sensor.fullName}}</p>
		</div>
		<div class="row">
			<div class="col">
				<reglament :reglament="reglamentData" :reglamentWorkId="reglament.id" />
			</div>
			<div class="col">
				<bti-map :containerName="'sensorReglament'" :sensor="sensor" v-if="sensor.bti_files_id"/>
				<p v-else>
					<i class="fas fa-exclamation-triangle text-danger">Планы БТИ отсутствуют</i>
				</p>
			</div>
		</div>
	</section>
</template>
<script>
import BtiMap from '../../leaflet/bti_sensor';
import Reglament from './reglament';

export default{
	props:['reglament'],
	components:{BtiMap,Reglament},
	computed:{
		reglamentData(){
			return this.$store.getters.REGLAMENT('sensors', this.sensor.sensor_id, this.reglament.reglament_id);
		},
		sensor(){
			const odid = this.$route.params.objectDeviceId;
			const wid = this.$route.params.wireId;
			const sid = this.reglament.device_id;
			return this.$store.getters.SENSOR_ON_WIRE_BY_ID(odid,wid,sid);
		}
	},
}
</script>