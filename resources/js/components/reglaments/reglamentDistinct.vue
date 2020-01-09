<template>
	<section>
		<frequency :reglament="currentReglament" />
		<hr class="mt-2 mb-3">
		<reglament-element :element="element"  v-for="element in elements" :key="element.id" v-on:deleted="delElement(element)" />

		<div class="row mt-2">
			<button class="btn btn-icon btn-2 btn-primary" type="button" @click="saveReglament">
				<span class="btn-inner--icon"><i class="fas fa-check"></i> Сохранить</span>
			</button>
			<button class="btn btn-icon btn-2 btn-success" type="button" @click="addElement">
				<span class="btn-inner--icon"><i class="fas fa-plus"></i> Добавить элемент</span>
			</button>
			<button class="btn btn-icon btn-2 btn-warning" type="button" @click="$router.go(-1)">
				<span class="btn-inner--icon"><i class="fas fa-chevron-left"></i> Назад</span>
			</button>
		</div>
	</section>
</template>

<script>
	import Frequency from './frequency';
	import ReglamentElement from './reglamentElement';
	export default{
		components:{
			Frequency,
			ReglamentElement,
		},
		data() {
			return {
				currentReglament:{},
			}
		},
		methods:{
			saveReglament(){
				const isSetFrequency = this.currentReglament.day
										|| this.currentReglament.week
										|| this.currentReglament.month
										|| this.currentReglament.year;
				if (this.$route.params.reglamentId == 'new' && this.currentReglament.name == ''){
					this.$awn.alert('Название регламента не может быть пустым');
					return false;
				}
				if(!this.currentReglament.name){
					this.$awn.alert('Не указана продолжительность регламента');
					return false;
				}
				if(!isSetFrequency){
					this.$awn.alert('Не указана частота проведения регламента');
					return false;
				}
				if(!this.currentReglament.duration){
					this.$awn.alert('Не указана продолжительнорсть проведения регламента');
					return false;
				}

				this.currentReglament.elements = this.currentReglament.elements.filter( elem => !(elem.id * 1 < 0 && elem.text == '') );

				this.$store.dispatch('SAVE_REGLAMENT', {
					...this.currentReglament,
					type: this.$route.params.type,
					device_id: this.$route.params.deviceId,
				})
					.then( success => {
						this.$awn.success('Регламент сохранен');
						this.$router.push({
							name: 'reglamentsEdit',
							params: {
								deviceId: this.$route.params.deviceId,
								type: this.$route.params.type
							}
						});
					})
					.catch( error => this.$awn.alert('При обновлении данных возникла ошибка'));
			},
			addElement(){
				let minR = 0;
				if(!this.currentReglament.elements.length == 0)
					minR = Math.min(...this.currentReglament.elements.map( limit => limit.id) );
				minR = minR > 0 ? -1 : minR - 1;
				this.currentReglament.elements.push({
					id: minR,
					device_reglament_id: this.$route.params.reglamentId,
					text: '',
				});
			}
		},
		computed:{
			elements(){
				const elements = this.currentReglament.elements;
				return elements.sort((a,b) => (a.id > b.id) ? 1 : ((b.id > a.id) ? -1 : 0));
			},
			tbl_name() {
				const type = this.$route.params.type;
				return this.$store.getters.AVAILABLE_DEVICE_MODEL(type);
			},
		},
		mounted(){
			const type = this.$route.params.type;
			const id = this.$route.params.deviceId;
			if(this.$route.params.reglamentId == 'new')
				this.currentReglament = {
					name:'',
					day:null,
					year:null,
					month:null,
					week:null,
					device_id:1,
					tbl_name:this.$store.getters.AVAILABLE_DEVICE_MODEL(type),
					elements:[],
				}
			else
				this.currentReglament = {...this.$store.getters.AVAILABLE_DEVICE(type, id).reglaments.find(reglament => reglament.id == this.$route.params.reglamentId)};
			if(!this.currentReglament.elements)
				this.currentReglament.elements = [];
		}

	}
</script>

<style scoped>

</style>