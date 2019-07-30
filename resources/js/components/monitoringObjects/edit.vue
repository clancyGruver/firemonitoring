<template>
	<div class="container-fluid mt-3">
		<div class="row">
			<Map />
		</div>
		<h1>{{ object.name }}</h1>
		<ul class="nav nav-pills mt-3 mb-3" id="pills-tab" role="tablist">
			<li class="nav-item">
				<a class="nav-link active" id="pills-home-tab" data-toggle="pill" href="#pills-home" role="tab" aria-controls="pills-home" aria-selected="true">Оснвные</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" id="pills-profile-tab" data-toggle="pill" href="#pills-profile" role="tab" aria-controls="pills-profile" aria-selected="false">Оборудование</a>
			</li>
			<!--li class="nav-item">
				<a class="nav-link" id="pills-contact-tab" data-toggle="pill" href="#pills-contact" role="tab" aria-controls="pills-contact" aria-selected="false">Contact</a>
			</li-->
		</ul>
		<div class="tab-content" id="pills-tabContent">
			<div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab">
				<edit-form :object="object" />
			</div>
			<div class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab">
				<div id="app">
					<devices :object="object"></devices>
				</div>
			</div>
			<div class="tab-pane fade" id="pills-contact" role="tabpanel" aria-labelledby="pills-contact-tab">...</div>
		</div>
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
