<template>
	<modal name="add-antenna" transition="pop-out" height="auto">
		<div class="card">
			<div class="card-body">
				<h5 class="card-title text-center">Добавить антенну</h5>
				<div class="row">
					<div class="col">
						<div v-if="device">
							<h3>{{device.name}}</h3>
							<hr>
						</div>
                        <ul class="list-unstyled">
                            <li v-for="device in availAntennas.devices" :key="device.id" class="pointer">
                                <span class="h2 font-weight-bold mb-0" @click="addDevice(device)">{{device.name}}</span>
                            </li>
                        </ul>
					</div>
					<div class="col">
						<antenna-params :antennaParams.sync="antennaParams"> </antenna-params>
					</div>
				</div>

				<div class="button-set">
					<button type="button" class="btn btn-success" @click.prevent="add">Добавить</button>
					<button type="button" class="btn btn-danger" @click.prevent="cancel">Отмена</button>
				</div>
			</div>
		</div>
	</modal>
</template>
<script>
import antennaParams from './antennaParams';

export default{
  	name: 'addAntenna',
	components: {antennaParams},
	props: {
		deviceData: {
			type: Object,
			default: function(){ return {} }
		}
	},
	data: function () {
		return {
			antennaParams:{},
			device: null,
			tbl_name: 'App\\device_antenna',
		}
	},
	methods: {
		check(){
			let res = true;
			const errors = [];
			if (!this.antennaParams.setup_place) {
				errors.push('Требуется указать место установки.');
				res = false;
			}
			if (!this.antennaParams.mast_isset) {
				errors.push('Требуется указать наличие мачты.');
				res = false;
			}
			if(!this.device){
		        errors.push('Не выбрана антенна.');
				res = false;
	      	}
	      	errors.map( error => this.$awn.alert(error) );
			return res;
		},
		addDevice(device){
			this.device = device;
		},
	  	add(){
  			if(!this.check()) return false;
	        //device.tbl_name = tbl_name
	        const result = {
	          object_id: this.$route.params.id,
	          parent_id: this.deviceData.id,
	          device_id: this.device.id,
	          tbl_name : 'App\\device_antenna',
	          antennaParams: this.antennaParams,
	        }
	        console.log(result);
			this.$store.dispatch('ADD_ANTENNA', result);
	    	this.cancel();
	  		/*this.$store.dispatch('NEW_DISTRICT',{name: this.name})
	  					.then(() => this.cancel())
	  					.catch(error => {
	  						this.$aws.alert('При добавлении участка произошли ошибки');
	  						console.log(error);
	  					});*/
	  	},
	  	cancel(){
	  		this.$modal.hide('add-antenna');
	  	},
	},
	computed:{
		availAntennas(){ return this.$store.getters.AVAILABLE_DEVICES['antennas'] }
	},
}
</script>