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
				<AdditionalLimit
					v-for="limit in additionalLimits"
					:key="limit.id"
					:id="limit.id"
					:text="limit.additional_limitation"
					:critical="limit.additional_limitation_critical"
					:deleteLimit="deleteLimit"
					v-on:updateLimit="updateLimit"
				></AdditionalLimit>
				<button class="btn btn-icon btn-2 btn-success" type="button" @click="addElement">
					<span class="btn-inner--icon"><i class="fas fa-plus"></i> Добавить недостаток</span>
				</button>
			</li>
		</ul>
		<button type="button" class="btn btn-success mt-4" @click.prevent="saveLimit">Сохранить</button>
		<button type="button" class="btn btn-warning mt-4" @click.prevent="$router.go(-1)">Назад</button>
	</div>
</template>

<script>
import AdditionalLimit from './additionalLimit';

export default {
	props:{},
	data() {
		return {
			allLimits: {},
			currentLimits: {},
			device: {},
			additionalLimits: '',
		}
	},

	components:{AdditionalLimit},

	beforeCreate: function(){
		const self = this;
		axios.post(`/api/limitations/get/${this.$route.params.objectDeviceId}`)
		.then( response => {
			self.allLimits = response.data.allLimits;
			self.currentLimits = response.data.currentLimits;
			self.additionalLimits = self.currentLimits.filter( obj => obj.additional_limitation && obj.additional_limitation.trim() != '' );
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
		deleteLimit(){
			console.log('deleted');
      /*this.$store.dispatch('DELETE_ADDITIONAL_LIMIT',this.id)
            .then( success => {
            	this.$awn.success('Недостаток устранен');
						});*/
		},
		updateLimit(obj){
			const idx = this.additionalLimits.findIndex(limit => limit.id == obj.id);
			this.additionalLimits[idx] = obj;
		},
		addElement(){
			this.additionalLimits.push({
				id:`tempid:${(+new Date).toString(16)}`,
				additional_limitation: "",
				additional_limitation_critical: false,
			});
		},
		saveLimit(){
			this.$store.dispatch('TOGGLE_DEVICE_ISGOOD',{
				typeIdx: this.$route.params.typeIdx,
				deviceId: this.device.id,
				allLimits: this.allLimits,
				additionalLimits: this.additionalLimits,
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
