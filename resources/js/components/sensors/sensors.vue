<template>
	<div>
		<sensor-form :mode="mode" :sensorData="sensorData" :edit="edit" v-on:end-adding="edit = !edit" />
		<div class="row">
			<a class="btn btn-icon btn-3 btn-success" type="button" @click="addSensor">
	            <span class="btn-inner--icon"><i class="fas fa-plus"></i></span>            
	            <span class="btn-inner--text">Добавить Сенсор</span>            
	        </a>
		</div>
		<div class="row">
	        <div class="table-responsive">
	            <table class="table align-items-center">
	            <thead class="thead-light">
	                <tr>
	                  <th scope="col" class="border-0">#</th>
	                  <th scope="col" class="border-0">Наименование</th>
	                  <th scope="col" class="border-0"></th>
	                  <th scope="col" class="border-0"></th>
	                  <th scope="col" class="border-0"></th>
	                </tr>
	            </thead>
	            <tbody>
	                <tr v-for="(sensor, index) in sensorsData" :key="sensor.id">
	                    <th scope="row">
	                        {{ index + 1 }}
	                    </th>
	                    <td>{{ sensor.name }}</td>
	                    <td>
	                        <a class="btn" data-toggle="tooltip" data-placement="top" title="Редактировать" @click="editSensor(index)"><i class="fas fa-edit text-warning"></i></a>
	                    </td>
	                    <td>
	                        <a class="btn delete-btn" data-toggle="tooltip" data-placement="top" title="Удалить" @click="deleteSensor(sensor.id)"><i class="fas fa-trash-alt text-danger"></i></a>
	                    </td>
	                </tr>
	            </tbody>
	        </table>

	        </div>
	    </div>
    </div>
</template>

<script>
import sensorForm from './form';

export default {
	props:[	],

	data() {
		return {
			mode: 'new',
			edit: false,
			sensorData: {},
		}
	},

	components:{sensorForm},

	mounted: function(){
		this.$store.commit('FILL_SENSORS');
	},

	methods:{
		addSensor(){
			this.mode = 'new';
			this.edit = true;
			this.sensorData = {};
		},
		editSensor(idx){
			this.mode = 'edit';
			this.edit = true;
			this.sensorData = this.sensorsData[idx];
		},
		deleteSensor(sid){
			this.$store.commit('DELETE_SENSOR',{id:sid});
		}
	},

	computed: {
		sensorsData: function () {return this.$store.getters.ALL_SENSORS},			
	}
}
</script>

<style scoped>
	
</style>