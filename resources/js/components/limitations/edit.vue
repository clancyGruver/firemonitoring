<template>
	<div>
		<h3>{{ device.name }}</h3>
		<limit-edit
			v-for="limit in device.limitations"
			:key="limit.id"
			:tbl_name="tbl_name"
			:device_id="device.id"
			:id="limit.id"
			:text="limit.text"
			:is_critical="limit.isCritical"
		></limit-edit>
		<button type="button" class="btn btn-success mb-2" @click.prevent="addLimit">
			<i class="fas fa-plus"></i> Добавить
		</button>
	</div>
</template>

<script>
	import LimitEdit from './limitEdit';
	export default{
		components: {LimitEdit},
		data() {
			return {

			}
		},
		computed:{
			device() {
				const type = this.$route.params.type;
				const id = this.$route.params.id;
				return this.$store.getters.AVAILABLE_DEVICE(type, id);
			},
			tbl_name() {
				const type = this.$route.params.type;
				return this.$store.getters.AVAILABLE_DEVICE_MODEL(type);
			}
		},
		methods:{
			addLimit(){
				console.log('clicked');
				if(!this.device.limitations)
					this.$set(this.device, 'limitations', []);
				let minL = Math.min(...this.device.limitations.map( limit => limit.id) );
				minL = minL > 0 ? -1 : minL - 1;
				minL = minL ? minL : -1;
				this.device.limitations.push({
					tbl_name: this.tbl_name,
					device_id:this.device.id,
					id: minL,
					text:''
				})
			}
		},
		mounted(){
		}

	}
</script>

<style scoped>

</style>