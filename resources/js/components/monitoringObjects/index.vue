<template>
	<div>
		<div class="row mb-3">
			<div class="col">
				<a class="btn btn-icon btn-3 btn-success" type="button" href="./objects/add">
		            <span class="btn-inner--icon"><i class="fas fa-plus"></i></span>
		            <span class="btn-inner--text">Добавить объект</span>
		        </a>
			</div>
	        <div class="col text-right">
	        	<div class="row">
	        		<div class="col">
						<input
							id="adressFilter"
							name="adressFilter"
							type="text"
							class="form-control"
							v-model="adressFilter"
							placeholder="Сортировка по адресу"
						>
					</div>
	        		<div class="col">
						<select class="form-control" id="coupling" name="coupling" v-model="raionFilter">
						  	<option disabled value="-1">Все районы</option>
					  		<option :value="raion.id" v-for="raion in raions" :key="raion.id">{{ raion.name }}</option>
						</select>
	        		</div>
	        	</div>
	        </div>
		</div>
	    <div class="row">
	        <div class="table-responsive">
	            <table class="table align-items-center">
	            <thead class="thead-light">
	                <tr>
	                  <th scope="col" class="border-0">#</th>
	                  <th scope="col" class="border-0">Наименование</th>
	                  <th scope="col" class="border-0">Район</th>
	                  <th scope="col" class="border-0">Адрес</th>
	                  <th scope="col" class="border-0">Директор</th>
	                  <th scope="col" class="border-0">Контактное лицо</th>
	                  <th scope="col" class="border-0"></th>
	                </tr>
	            </thead>
	            <tbody>
	                <tr v-for="(object,index) in objects" :key="object.id">
	                    <th scope="row">
	                        {{index}}
	                    </th>
	                    <td>{{object.name}}</td>
	                    <td>{{object.raion.name}}</td>
	                    <td>{{object.address}}</td>
	                    <td>{{object.director_name}}, {{object.director_phone}}</td>
	                    <td>{{object.contact_name}}, {{object.contact_phone}}</td>
	                    <td>
	                        <a
	                        	:href="`./admin/objects/detail/${object.id}`"
	                        	class="btn"
	                        	data-toggle="tooltip"
	                        	data-placement="top"
	                        	title="Карточка объекта"
	                        >
	                        	<i class="fas fa-search text-primary"></i>
	                       	</a>
	                       	<router-link :to="`objects/${object.id}/main`">
	                       		<i class="fas fa-edit text-warning"></i>
	                       	</router-link>
	                        <a
	                        	href="#"
	                        	class="btn delete-btn"
	                        	data-toggle="tooltip"
	                        	data-placement="top"
	                        	title="Удалить"
	                        	@click="delObj(object)"
	                        >
	                        	<i class="fas fa-trash-alt text-danger"></i>
	                        </a>
	                    </td>
	                </tr>
	            </tbody>
	        </table>

	        </div>
	    </div>
	</div>
</template>

<script>
//import deviceComponent from './device-component.vue';

export default {
	props:[],
	data() {
		return {
			raionFilter: -1,
			adressFilter: '',
		}
	},
	components:{
	},
	mounted: function(){
	},

	methods:{
		delObj: function(object){
		    if(confirm('Вы уверены, что хотите удалить объект?')){
				this.$store.commit('DELETE_OBJECT',{object});
		    }
		},
		createTree: function (devices) {
		}
	},

	mounted: function(){
	},

	computed:{
		objects() {
			let objects = this.$store.getters.OBJECTS;
			if(this.raionFilter > -1){
				objects = objects.filter( object => object.raion_id == this.raionFilter);
			}
			if(this.adressFilter.trim() !== ''){
				const adressFilterTrimmed = this.adressFilter.trim().toLowerCase();
				objects = objects.filter( object => object.address.toLowerCase().includes(adressFilterTrimmed));
			}
			return objects;
		},
		raions() {return this.$store.getters.RAIONS},
	}
}
</script>

<style scoped>

</style>
