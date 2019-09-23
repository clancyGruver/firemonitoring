<template>
	<form class="form-inline">
		<input type="text" class="form-control mb-2 mr-sm-2" id="inlineFormInputName2" v-model.trim="innerText">
		<label class="custom-toggle">
		  <input type="checkbox" v-model="isCritical">
		  <span class="custom-toggle-slider rounded-circle"></span>
		  Критично
		</label>
		<button type="button" class="btn btn-outline-primary mb-2" @click.prevent="saveLimit">
			<i class="ni ni-check-bold text-success"></i>
		</button>
		<button type="button" class="btn btn-outline-primary mb-2" @click.prevent="delLimit">
			<i class="ni ni-fat-remove text-danger"></i>
		</button>
	</form>
</template>

<script>
	export default{
		props:{
			tbl_name: String,
			id: Number,
			device_id: Number,
			text: String,
			is_critical: Number,
		},
		data() {
			return {
        		innerText: this.text,
        		isCritical: Boolean(this.is_critical) || false,
			}
		},
		methods:{
			saveLimit(){
				console.log('save');
				if(this.innerText.trim() == ''){
					this.$awn.alert('Нельзя сохранить пустой недостаток')
					return false;
				}
				const limit = {
					tbl_name: this.tbl_name,
					id: this.id,
					device_id: this.device_id,
					text: this.innerText,
					type: this.$route.params.type,
					isCritical: this.isCritical,
				};
				if(this.id > 0)
					this.$store.dispatch('UPDATE_LIMITATION', limit)
		                .then( success => this.$awn.success('Недостаток обновлен'))
		                .catch( error => this.$awn.alert('При обновлении данных возникла ошибка'));
				else
					this.$store.dispatch('INSERT_LIMITATION', limit)
		                .then( success => this.$awn.success('Недостаток добавлен'))
		                .catch( error => this.$awn.alert('При обновлении данных возникла ошибка'));
			},
			delLimit(){
				const answer = confirm(`Вы действительно хотите удалить недостаток: '${this.innerText}'`);
				if( answer)
					this.$store.dispatch('DELETE_LIMITATION', {id: this.id, type: this.$route.params.type, device_id: this.device_id})
		                .then( success => this.$awn.success('Недостаток удален'))
		                .catch( error => this.$awn.alert('При обновлении данных возникла ошибка'));
			},
		},
		computed:{
		},
		mounted(){
		}

	}
</script>

<style scoped>

</style>