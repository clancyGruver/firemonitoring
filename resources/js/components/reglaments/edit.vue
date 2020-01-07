<template>
	<div>
		<h3>{{ device.name }}</h3>
		<ul class="list-unstyled">
			<li
				v-for="reglament in device.reglaments"
				:key="reglament.id"
			>
				<span v-if="reglament.deleting" class="fa-3x">
  					<i class="fas fa-spinner fa-pulse"></i>
				</span>
				<router-link :to="{
					name: 'reglamentsDistinct',
					params: {
						type:$route.params.type,
						id: $route.params.deviceId,
						reglamentId: reglament.id,
					},
				}">
					{{ reglament.name }}
				</router-link>
				<button type="button" class="btn btn-outline-danger col-2" @click="delElement(reglament)">Удалить</button>
			</li>
		</ul>
		<router-link
			:tag="'button'"
			:class="'btn btn-success mb-2'"
			:type="'button'"
			:to="{
			name: 'reglamentsDistinct',
			params: {
				type:$route.params.type,
				id: $route.params.deviceId,
				reglamentId: 'new',
			},
		}">
			<i class="fas fa-plus"></i> Добавить
		</router-link>
	</div>
</template>

<script>
	import reglamentDistinct from './reglamentDistinct';
	export default{
		components: {reglamentDistinct},
		data() {
			return {

			}
		},
		computed:{
			device() {
				const type = this.$route.params.type;
				const id = this.$route.params.deviceId;
				return this.$store.getters.AVAILABLE_DEVICE(type, id);
			},
		},
		methods:{
			delElement(element){
				if(confirm(`Вы действительно хотите удалить регламент "${element.name}"`)){
					element.deleting = true;
					this.$store.dispatch('DELETE_REGLAMENT', {
						type: this.$route.params.type,
						device_id: this.$route.params.deviceId,
						reglamentId: element.id,
					})
				}
			},
			addReglament(){
				let minL = Math.min(...this.device.reglaments.map( reglament => reglament.id) );
				minL = minL > 0 ? -1 : minL - 1;
				this.device.reglaments.push({
					tbl_name: this.tbl_name,
					device_id:this.device.id,
					id: minL
				})
			}
		},
		mounted(){
		}

	}
</script>

<style scoped>

</style>