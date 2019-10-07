<template>
	<div>
		<h2>Недостатки {{ device.name }}</h2>
		<ul class="list-unstyled">
			<li v-for="limit in allLimits" :key="limit.id">
				<div class="custom-control custom-checkbox mb-3">
					<input class="custom-control-input" :id="`limit${limit.id}`" type="checkbox" v-model="limit.checked">
					<label class="custom-control-label" :for="`limit${limit.id}`">{{limit.text}}</label>
				</div>
			</li>
			<h4>Дополнительные недостатки</h4>
			<li>
				<textarea class="form-control" rows="3" v-model="additionalLimit">
				</textarea>
				<div class="custom-control custom-control-alternative custom-checkbox mb-3">
				<input class="custom-control-input" id="customCheck6" type="checkbox" v-model="isCritical">
				<label class="custom-control-label" for="customCheck6">Критично</label>
				</div>
			</li>
		</ul>
		<button type="button" class="btn btn-success mt-4" @click.prevent="saveLimit">Сохранить</button>
		<button type="button" class="btn btn-warning mt-4" @click.prevent="$router.go(-1)">Назад</button>
	</div>
</template>

<script>

export default {
	props:{},

	data() {
		return {
			allLimits: {},
			currentLimits: {},
			device: {},
			additionalLimit: '',
			isCritical: false,
		}
	},

	components:{},

	beforeCreate: function(){
		const self = this;
		axios.post(`/api/limitations/get/${this.$route.params.objectDeviceId}`)
		.then( response => {
			self.allLimits = response.data.allLimits;
			self.currentLimits = response.data.currentLimits;
			const AL = self.currentLimits.find( obj => obj.additional_limitation && obj.additional_limitation.trim() != '' );
			self.additionalLimit = AL ? AL.additional_limitation : '';
			self.isCritical = AL ? AL.additional_limitation_critical : false;
			const cl = self.currentLimits.map( obj => obj.DL_id)
			self.allLimits.forEach(
				(val, index) => {
					if (cl.includes(val.id))
 						self.allLimits[index].checked = true;
 					else
 						self.allLimits[index].checked = false;
				}
			)
			self.device = response.data.device;
		})
	},

	methods:{
		saveLimit(){
			this.$store.dispatch('TOGGLE_DEVICE_ISGOOD',{
				typeIdx: this.$route.params.typeIdx,
				deviceId: this.device.id,
				allLimits: this.allLimits,
				additionalLimit: this.additionalLimit,
				isCritical: this.isCritical,
				odid: this.$route.params.objectDeviceId,
			})
            .then( success => {
            	this.$awn.success('Недостатки сохранены');
            	this.$router.go(-1);
            })
            .catch( error => this.$awn.alert('При обновлении данных возникла ошибка'));
		}
	},

	computed: {
	}
}
</script>

<style scoped>

</style>
