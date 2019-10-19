<template>
	<div>
		<add-calendar :show="showCalendarWork" :object="calendarWorkObject" v-on:endEdit="showCalendarWork = !showCalendarWork" />
		<div class="row mb-3">
			<div class="col">
               	<router-link
               		class="btn btn-icon btn-3 btn-success"
               		type="button"
               		:to="`objects/new`"
               	>
		            <span class="btn-inner--icon"><i class="fas fa-plus"></i></span>
		            <span class="btn-inner--text">Добавить объект</span>
               	</router-link>
			</div>
    		<div class="col">
				<select
					class="form-control"
					id="modeVariants"
					name="modeVariants"
					v-model="mode"
				>
				  	<option disabled value="-1">Неисправности</option>
			  		<option
			  			:value="modeVariant.mode"
			  			v-for="modeVariant in modeVariants"
			  			:key="modeVariant.mode"
			  		>
			  			{{ modeVariant.name }}
			  		</option>
				</select>
    		</div>
	        <div class="col text-right">
	        	<div class="row">
	        		<div class="col">
						<input
							id="adressFilter"
							name="adressFilter"
							type="text"
							class="form-control"
							v-model.trim="adressFilter"
							placeholder="Сортировка по адресу"
						>
						<input
							type="text"
							class="form-control"
							v-model.trim="nameFilter"
							placeholder="Сортировка по названию"
						>
					</div>
	        		<div class="col">
						<select class="form-control" id="coupling" name="coupling" v-model="raionFilter">
						  	<option value="-1">Все районы</option>
					  		<option :value="raion.id" v-for="raion in raions" :key="raion.id">{{ raion.name }}</option>
						</select>
	        		</div>
	        	</div>
	        </div>
		</div>
	    <div class="row">
			<Map :objects="objects" :center="center" />
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
	                        	href="#"
	                        	class="btn"
	                        	data-placement="top"
	                        	title="Добавить в работу"
	                        	data-toggle="tooltip"
	                        	@click.prevent="showCalendarWorkHandler(object)"
	                        >
	                        	<i class="fas fa-cog text-primary"></i>
	                       	</a>
	                        <!--a
	                        	:href="`./admin/objects/detail/${object.id}`"
	                        	class="btn"
	                        	data-toggle="tooltip"
	                        	data-placement="top"
	                        	title="Карточка объекта"
	                        >
	                        	<i class="fas fa-search text-primary"></i>
	                       	</a-->
	                       	<router-link
	                       		class="btn"
	                        	data-toggle="tooltip"
	                        	data-placement="top"
	                        	title="Редактирование объекта"
	                       		:to="`objects/${object.id}/main`"
	                       	>
	                       		<i class="fas fa-edit text-warning"></i>
	                       	</router-link>
	                        <a
	                        	href="#"
	                        	class="btn delete-btn"
	                        	data-toggle="tooltip"
	                        	data-placement="top"
	                        	title="Удалить"
	                        	@click.prevent="delObj(object)"
	                        >
	                        	<i class="fas fa-trash-alt text-danger"></i>
	                        </a>
							<select
								class="form-control"
								@change="changeDistrict($event, object)"
							>
							  	<option disabled value="-1" :selected="!object.district">Участок не выбран</option>
						  		<option
						  			v-for="district in districts"
						  			:value="district.id"
						  			:key="district.id"
									:selected="object.district ? object.district.district.id == district.id : false"
						  		>
						  			{{ district.name }}
						  		</option>
							</select>
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
import Map from '../leaflet/allMap';
import AddCalendar from './calendarWork/index';

export default {
	props:['mode'],
	components:{Map, AddCalendar},
	data() {
		return {
			modeVariants: [
				{
					mode: 'devices',
					name: 'Оборудование',
				},
				{
					mode: 'sensors',
					name: 'Извещатели',
				},
				{
					mode: 'sp5',
					name: 'Соответствие СП5',
				},
				{
					mode: 'unreglamented',
					name: 'Регламентные работы',
				},
				{
					mode: 'all',
					name: 'Все',
				},
			],
			raionFilter: -1,
			adressFilter: '',
			nameFilter: '',
			center: {lat: 55.198016, lng: 61.359764},
			showCalendarWork: false,
			calendarWorkObject: {},
		}
	},
	methods:{
		changeDistrict(event, object){
			const val = event.target.value;
			this.$store.dispatch('SET_OBJECT_DISTRICT', {
				districtId: val,
				objectId: object.id,
			});
		},
		delObj(object){
		    if(confirm('Вы уверены, что хотите удалить объект?')){
				this.$store.commit('DELETE_OBJECT',object.id);
		    }
		},
		showCalendarWorkHandler(object){
			this.showCalendarWork = !this.showCalendarWork;
			this.calendarWorkObject = object;

		}
	},
	computed:{
		objects() {
			let objects = this.$store.getters.LIMITED_OBJECTS_BY_TYPE(this.mode);
			if(this.raionFilter > -1){
				objects = objects.filter( object => object.raion_id == this.raionFilter);
				const raion = this.$store.getters.RAION_BY_ID(this.raionFilter);
				this.center = {
					lat:raion.lat,
					lng:raion.lng
				}
			}
			if(this.adressFilter.trim() !== ''){
				const adressFilterTrimmed = this.adressFilter.trim().toLowerCase();
				objects = objects.filter( object => object.address.toLowerCase().includes(adressFilterTrimmed));
			}
			if(this.nameFilter.trim() !== ''){
				const nameFilterTrimmed = this.nameFilter.trim().toLowerCase();
				objects = objects.filter( object => object.name.toLowerCase().includes(nameFilterTrimmed));
			}
			return objects;
		},
		raions() {return this.$store.getters.RAIONS},
		districts() {return this.$store.getters.DISTRICTS},
	}
}
</script>

<style scoped>

</style>
