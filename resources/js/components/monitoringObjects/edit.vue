<template>
	<div class="container-fluid mt-3">
		<h1><!--i class="fas fa-angle-left" v-on:click="$router.push('/objects')"></i-->{{ object.name }}</h1>
		<ul class="nav nav-pills mb-4">
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
			<li class="nav-item">
				<router-link :active-class="'active'" class="nav-link" :to="{ name: 'objectEditMap' }">
					Карта
				</router-link>
			</li>
			<li class="nav-item">
				<router-link :active-class="'active'" class="nav-link" :to="{ name: 'objectReports' }">
					Отчеты
				</router-link>
			</li>
			<!--li class="nav-item">
				<router-link
					class="nav-link"
					:active-class="'active'"
					:to="{
						name: 'objectEditBti',
						params:{
							containerName: 'bigBtiMap',
					}}">
					Планы БТИ
				</router-link>
			</li-->
		</ul>
        <transition>
			<router-view></router-view>
		</transition>
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
	},

	computed: {
		object() {return this.$store.getters.CURRENT_OBJECT},
	}
}
</script>

<style scoped>

</style>
