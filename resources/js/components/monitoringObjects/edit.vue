<template>
	<div class="container-fluid mt-3">
		<div class="row">
			<Map />
		</div>
		<h1>{{ object.name }}</h1>
		<ul class="nav nav-pills">
			<li class="nav-item">
				<router-link :active-class="'active'" class="nav-link" :to="{ name: 'MonitoringObjectEdit' }">
					Оснвные
				</router-link>
			</li>
			<li class="nav-item">
				<router-link :active-class="'active'" class="nav-link" :to="{ name: 'objectEditDevices' }">
					Оборудование
				</router-link>
			</li>
			<li class="nav-item">
				<router-link :active-class="'active'" class="nav-link" :to="{ name: 'objectEditMedia' }">
					Файлы
				</router-link>
			</li>
		</ul>
		<router-view></router-view>
	</div>
</template>

<script>
import Map from '../leaflet/map';
import EditForm from './edit/monitoringObject';
import Devices from '../devices';

export default {
	props:{},

	data() {
		return {
		}
	},

	components:{Map,EditForm,Devices},

	mounted: function(){
		this.$store.dispatch('setCurrentObjectAction', this.$route.params.id);
	},

	methods:{
		createTree: function (devices) {
		}
	},

	computed: {
		object() {return this.$store.getters.CURRENT_OBJECT},
	}
}
</script>

<style scoped>

</style>
