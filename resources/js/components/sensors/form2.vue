<template>
	<section>
		<div class="card-body">
        	<div class="card bg-secondary shadow border-0">
				<div class="card-header bg-transparent">
                    <h3 class="text-muted text-center">
                		<small v-if="deviceId">Добавить извещатель</small>
                		<small v-else>Корректировка сенсора</small>
                	</h3>
                </div>
                <div class="card-body px-lg-5">
					<form>
				        <div class="form-group col">
				        	<label for="name">Наименование</label>
				            <input id="name" name="name" type="text" class="form-control" placeholder="Наименование" v-model="device.name">
				        </div>
				        <file-upload
				        	v-on:changed="setNewFile"
				        	:label="`Инструкция`"
				        />
				        <div class="text-center text-muted mb-4">
				            <small>Классификация ПИ</small>
				        </div>
				        <div class="form-group col custom-control">
				            <label class="" for="is_automate">По способу приведения в действие</label>
							<select class="form-control" id="is_automate" name="is_automate" v-model="device.is_automate">
							  <option disabled value="" >Выберите один из вариантов</option>
							  <option value="1">Автоматический</option>
							  <option value="0">Ручой</option>
							</select>
				        </div>
				        <div class="form-group col custom-control">
				            <label class="" for="power_supply">По способу электропитания</label>
							<select class="form-control" id="power_supply" name="power_supply" v-model="device.power_supply">
							  <option disabled value="" >Выберите один из вариантов</option>
							  <option value="wire">Питаемый по шлейфу</option>
							  <option value="separate wire">Питаемый по отдельному проводу</option>
							  <option value="stand-alone">Автономный</option>
							</select>
				        </div>
				        <div class="form-group col custom-control custom-checkbox">
				            <label class="" for="is_address">По возможности установки адреса</label>
							<select class="form-control" id="is_address" name="is_address" v-model="device.is_address">
							  <option disabled value="" >Выберите один из вариантов</option>
							  <option value="1">Адресный</option>
							  <option value="0">Безадресный</option>
							</select>
				        </div>

						<div v-show="device.power_supply == 'stand-alone'">
					        <div class="text-center text-muted mb-4">
					            <small>Общая классификация автономных ПИ</small>
					        </div>
					        <div class="form-group col custom-control custom-checkbox">
					            <label class="" for="standalon_function">По функциональным возможностям </label>
								<select class="form-control" id="standalon_function" name="standalon_function" v-model="device.standalon_function">
								  <option disabled value="" >Выберите один из вариантов</option>
								  <option value="smoke">Автономный дымовой пожарный извещатель</option>
								  <option value="fire">Автономный комбинированный пожарный извещатель</option>
								</select>
					        </div>
					        <div class="form-group col custom-control custom-checkbox"  v-show="device.standalon_function == 'smoke'">
					            <label class="" for="standalon_smoke_is_radioisotop">По принципу обнаружения пожара </label>
								<select class="form-control" id="standalon_smoke_is_radioisotop" name="standalon_smoke_is_radioisotop" v-model="device.standalon_smoke_is_radioisotop">
								  <option disabled value="" >Выберите один из вариантов</option>
								  <option value="1">Автономный пожарный извещатель радиоизотопный</option>
								  <option value="0">Автономный пожарный извещатель оптико-электронный</option>
								</select>
					        </div>
						</div>

						<div v-show="device.is_automate == '1'">
					        <div class="text-center text-muted mb-4">
					            <small>Общая классификация автоматических ПИ</small>
					        </div>
					        <div class="form-group col custom-control custom-checkbox">
					            <label class="" for="automate_attribute">По виду контролируемого признака пожара</label>
								<select class="form-control" id="automate_attribute" name="automate_attribute" v-model="device.automate_attribute">
								  <option disabled value="" >Выберите один из вариантов</option>
								  <option value="heat">Тепловой</option>
								  <option value="smoke">Дымовой</option>
								  <option value="fire">Пламени</option>
								  <option value="gas">Газовый</option>
								  <option value="combine">Комбинированный</option>
								</select>
					        </div>
					        <div class="form-group col custom-control custom-checkbox">
					            <label class="" for="automate_reaction">По характеру реакции на контролируемый признак </label>
								<select class="form-control" id="automate_reaction" name="automate_reaction" v-model="device.automate_reaction">
								  <option disabled value="" >Выберите один из вариантов</option>
								  <option value="maximal">Максимальный</option>
								  <option value="differincial">Дифференциальный</option>
								  <option value="max-diff">Максимально-дифференциальный</option>
								</select>
					        </div>
						</div>


					    <div class="">
					        <div class="form-group col btn-group">
								<button type="button" class="btn btn-success" @click.prevent="saveDevicehandler" :disabled="saving">
									<div class="fa" v-if="saving">
									  <i class="fas fa-spinner fa-spin"></i>
									  Сохранение
									</div>
									<div v-else>
										<span v-if="deviceId">Обновить</span>
										<span v-else>Сохранить</span>
									</div>
								</button>
								<button type="button" class="btn btn-error" @click.prevent="$router.go(-1)">
									Отмена
								</button>
							</div>
						</div>
					</form>
                </div>
            </div>
		</div>
	</section>
</template>

<script>
	import FileUpload from '../editForms/fileupload';

	export default{
		components:{FileUpload},
		props: {
			deviceId: Number,
		},
		data: function () {
			return {
				device:{
			        name: '',
			        is_automate: null,
			        power_supply: null,
			        is_address: null,
			        standalon_function: null,
			        standalon_smoke_is_radioisotop: null,
			        automate_attribute: null,
			        automate_reaction: null,
			    },
				errors: [],
				saving: false,
				device_type: 'sensors',
			}
		},
		methods: {
			setNewFile(e){ this.device.newFile = e; },
			saveDevicehandler(){
				this.saving = true;
				if(!this.check()){
					this.errors.forEach( error => this.$awn.alert(error) )
					this.saving = false;
					return false;
				}
				const res = this.saveDevice();
				res.then( response => {
					const routerParams = {
						path:`/devices/${this.device_type}`,
						params: {
							device_type: this.device_type,
						}
					};
					this.$router.push(routerParams);
				})
			},
			saveDevice(){
	            let fd = new FormData();
	            for (let val in this.device){
	            	if(this.device[val] !== null)
	            		fd.append(val, this.device[val]);
	            }
	            if(this.device.newFile)
	            	fd.append('newFile', this.device.newFile);
				return this.$store.dispatch('UPDATE_DEVICE',{
					fd,
					device_type: this.device_type,
					deviceId: this.deviceId
				})
					.then( success => {
						const successWord = this.deviceId ? 'обновлен' : 'добавлен'
						this.$awn.success(`${this.device.name} успешно ${successWord}.`)
					})
					.catch( error => {
						this.$awn.alert(`Во время добавления ${this.device.name} произошла ошибка.`)
						console.log(error)
					} )
			},
			check(){
				let res = true;
				this.errors = [];
				if (!this.device.name) {
					this.errors.push('Требуется указать наименование.');
					res = false;
				}
				if (this.device.is_automate === null) {
					this.errors.push('Требуется указать способ приведения в действие.');
					res = false;
				}
				if (this.device.power_supply === null) {
					this.errors.push('Требуется указать способ электропитания.');
					res = false;
				}
				if (this.device.is_address === null) {
					this.errors.push('Требуется указать возможность установки адреса.');
					res = false;
				}
				return res;
			},
		},
		mounted(){
			if(this.deviceId){
				const res = {...this.$store.getters.AVAILABLE_DEVICE(this.device_type, this.deviceId)};
				this.device = res;
				console.log(res);
			}
		},
		computed:{
		},
	}
</script>

<style scoped>
</style>