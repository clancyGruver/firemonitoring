<template>
	<modal name="add-antenna" transition="pop-out">
		<div class="card">
			<div class="card-body">
				<h5 class="card-title">Добавить антенну</h5>
				<div class="row">
					<div class="col">
                        <ul class="list-unstyled">
                            <li v-for="device in availAntennas.devices">
                                <span class="h2 font-weight-bold mb-0" @click="addDevice(device)">{{device.name}}</span>
                            </li>
                        </ul>
					</div>
					<div class="col">
						<antenna-params :deviceData.sync="antennaParams"> </antenna-params>
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
	components: {antennaParams},
	data: function () {
		return {
			antennaParams:{},
			errors: [],
			device: null,
			tbl_name: 'App\\device_antenna',
		}
	},
	methods: {
		check(){
			let res = true;
			this.errors = [];
			if (!this.antennaParams.setup_place) {
				this.errors.push('Требуется указать место установки.');
				res = false;
			}
			if (!this.antennaParams.mast_isset) {
				this.errors.push('Требуется указать наличие мачты.');
				res = false;
			}
			if(!this.device){
		        this.errors.push('Не выбрана антенна.');
				res = false;
	      	}
			return res;
		},
	  	add(device){
  			if(!check()) return false;

	    	this.cancel();
	  		/*this.$store.dispatch('NEW_DISTRICT',{name: this.name})
	  					.then(() => this.cancel())
	  					.catch(error => {
	  						this.$aws.alert('При добавлении участка произошли ошибки');
	  						console.log(error);
	  					});*/
	  	},
	  	cancel(){
	  		this.name = "";
	  		this.$modal.hide('add-antenna');
	  	},
	},
	computed:{
		availAntennas(){ return this.$store.getters.AVAILABLE_DEVICES[this.tbl_name] }
	},
}
</script>