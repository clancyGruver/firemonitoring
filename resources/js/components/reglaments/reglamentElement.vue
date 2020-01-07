<template>
	<div class="row mb-2">
		<input type="text" class="form-control mt-1 mr-sm-2 col-9" v-model.trim="element.text">
		<button type="button" class="btn btn-outline-danger col-2" @click="delElement">Удалить</button>
	</div>
</template>

<script>
export default{
	props:['element'],
	methods:{
		delElement(){
			if(confirm(`Вы действительно хотите удалить ${this.element.text}`)){
				this.element.deleted = true;
				this.$store.dispatch('DELETE_REGLAMENT_ELEMENT',{
					elementId: this.element.id,
					type: this.$route.params.type,
					reglamentId: this.$route.params.reglamentId,
					device_id: this.$route.params.deviceId,
				});
			}
		}
	},
}
</script>