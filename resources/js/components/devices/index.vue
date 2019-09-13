<template>
	<section>
		<div class="row">
			<h3>{{devices.name}}</h3>
		</div>
		<div class="row">
           	<router-link
           	 	type="button"
			 	class="btn btn-icon btn-3 btn-success"
           		:to="{
           			name: device_type == 'sensors' ? 'sensorEdit' : 'deviceEdit',
           			path: `/devices/${device_type}/edit/`,
           			params:{
           				device_type: device_type,
               		}
           		}"
           	>
	            <span class="btn-inner--icon"><i class="fas fa-plus"></i></span>
	            <span class="btn-inner--text">Добавить</span>
           </router-link>
	    </div>
	    <div class="row">
	        <div class="table-responsive">
	            <table class="table align-items-center">
	            <thead class="thead-light">
	                <tr>
	                  <th scope="col" class="border-0">#</th>
	                  <th scope="col" class="border-0">Наименование</th>
	                  <th scope="col" class="border-0">Количество шлейфов</th>
	                  <th scope="col" class="border-0">Инструкция</th>
	                  <th scope="col" class="border-0"></th>
	                </tr>
	            </thead>
	            <tbody>
	                <tr
	                	v-for="(device, index) in devices.devices"
	                	:key="device.id"
	                >
	                    <th scope="row">
	                        {{ index + 1 }}
	                    </th>
	                    <td>{{ device.name }}</td>
	                    <td>{{ device.wires_count }}</td>
	                    <td><a :href="device.instrutionPath" target="_blank">{{ device.instruction }}</a></td>
	                    <td>
	                       	<router-link
	                       		data-toggle="tooltip"
                    			data-placement="top"
                    			title="Редактировать"
                			 	class="btn edit-btn"
	                       		:to="{
	                       			name: device_type == 'sensors' ? 'sensorEdit' : 'deviceEdit',
	                       			path: `/devices/${device_type}/edit/${device.id}`,
	                       			params:{
	                       				device_type: device_type,
										deviceId:device.id
		                       		}
	                       		}"
	                       	>
	                       		<i class="fas fa-edit text-warning"></i>
	                       	</router-link>
	                       	<a
	                       		data-toggle="tooltip"
                    			data-placement="top"
                    			title="Удалить"
                			 	class="btn delete-btn"
                    			@click.prevent="deleteDevice(device)"
                    		>
                    			<i class="fas fa-trash-alt text-danger"></i>
	                       	</a>
	                    </td>
	                </tr>
	            </tbody>
	        </table>

	        </div>
	    </div>
	</section>
</template>

<script>
export default{
	props: {
		device_type: String,
	},
	methods:{
		deleteDevice(device){
		    if(confirm(`Вы уверены, что хотите удалить ${device.name}?`)){
		    	this.$store.dispatch('DELETE_DEVICE',{
		    			type: this.device_type,
		    			id: device.id
		    		})
		    			   .then( success => this.$awn.success(`${device.name} удален`) )
		    			   .catch( error => this.$awn.alert(`Во время удаления ${device.name} произошла ошибка`) )
		    }
		},
	},
	computed:{
		devices(){
			return this.$store.getters.AVAILABLE_DEVICES[this.device_type] ? this.$store.getters.AVAILABLE_DEVICES[this.device_type] : [];
		},
	},
}
</script>

<style scoped>
	
</style>