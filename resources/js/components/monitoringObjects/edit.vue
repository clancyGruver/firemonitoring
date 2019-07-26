<template>
	<div class="container-fluid mt-3">
		<Map />
		<h1>{{ object.name }}</h1>
	</div>
</template>

<script>
import Map from '../leaflet/map';

export default {
	props:{},

	data() {
		return {
		}
	},

	components:{Map},

	mounted: function(){
		this.$store.commit('SET_OBJECT_ID', this.$route.params.id);
		this.$store.commit('SET_BTIPLANS');
	},

	methods:{
		createTree: function (devices) {
		}
	},

	computed: {
		object() {return this.$store.getters.OBJECT(this.$route.params.id)},
	}
}
</script>

<style scoped>

</style>
