<template>
	<transition name="modal">
		<div class="modal-dialog modal- modal-dialog-centered modal-xl modal-mask" role="document" v-show="edit" @click.self="cancel">
			<div class="modal-content card-body modal-wrapper">
				<div class="modal-body p-0 modal-container">
                	<div class="card bg-secondary shadow border-0">
						<div class="card-header bg-transparent pb-5 modal-header">
	                        <div class="text-muted text-center mt-2 mb-3">
                        		<small v-if="mode == 'new'">Добавить извещатель</small>
                        		<small v-else>Корректировка сенсора</small>
                        	</div>
							<div class="text-muted text-center mt-2 mb-3"  v-if="errors.length">
								<p>
									<b>Пожалуйста исправьте указанные ошибки:</b>
									<ul>
										<li class="alert alert-danger" role="alert" v-for="(error, index) in errors" :key="index">{{ error }}</li>
									</ul>
								</p>
							</div>
	                    </div>
		                <div class="card-body px-lg-5 py-lg-5 modal-body">
							<form @keyup.enter="save">
						        <div class="form-group col">
						        	<label for="name">Наименование</label>
						            <input id="name" name="name" type="text" class="form-control" placeholder="Наименование" v-model="sensorData.name">
						        </div>
						        <div class="text-center text-muted mb-4">
						            <small>Классификация ПИ</small>
						        </div>
						        <div class="form-group col custom-control">
						            <label class="" for="is_automate">По способу приведения в действие</label>
									<select class="form-control" id="is_automate" name="is_automate" v-model="sensorData.is_automate">
									  <option disabled value="" >Выберите один из вариантов</option>
									  <option value="true">Автоматический</option>
									  <option value="false">Ручой</option>
									</select>
						        </div>
						        <div class="form-group col custom-control">
						            <label class="" for="power_supply">По способу электропитания</label>
									<select class="form-control" id="power_supply" name="power_supply" v-model="sensorData.power_supply">
									  <option disabled value="" >Выберите один из вариантов</option>
									  <option value="wire">Питаемый по шлейфу</option>
									  <option value="separate wire">Питаемый по отдельному проводу</option>
									  <option value="stand-alone">Автономный</option>
									</select>
						        </div>
						        <div class="form-group col custom-control custom-checkbox">
						            <label class="" for="is_address">По возможности установки адреса</label>
									<select class="form-control" id="is_address" name="is_address" v-model="sensorData.is_address">
									  <option disabled value="" >Выберите один из вариантов</option>
									  <option value="true">Адресный</option>
									  <option value="false">Безадресный</option>
									</select>
						        </div>

								<div v-show="sensorData.power_supply == 'stand-alone'">
							        <div class="text-center text-muted mb-4">
							            <small>Общая классификация автономных ПИ</small>
							        </div>
							        <div class="form-group col custom-control custom-checkbox">
							            <label class="" for="standalon_function">По функциональным возможностям </label>
										<select class="form-control" id="standalon_function" name="standalon_function" v-model="sensorData.standalon_function">
										  <option disabled value="" >Выберите один из вариантов</option>
										  <option value="smoke">Автономный дымовой пожарный извещатель</option>
										  <option value="fire">Автономный комбинированный пожарный извещатель</option>
										</select>
							        </div>
							        <div class="form-group col custom-control custom-checkbox"  v-show="sensorData.standalon_function == 'smoke'">
							            <label class="" for="standalon_smoke_is_radioisotop">По принципу обнаружения пожара </label>
										<select class="form-control" id="standalon_smoke_is_radioisotop" name="standalon_smoke_is_radioisotop" v-model="sensorData.standalon_smoke_is_radioisotop">
										  <option disabled value="" >Выберите один из вариантов</option>
										  <option value="true">Автономный пожарный извещатель радиоизотопный</option>
										  <option value="false">Автономный пожарный извещатель оптико-электронный</option>
										</select>
							        </div>
								</div>

								<div v-show="sensorData.is_automate == 'true'">
							        <div class="text-center text-muted mb-4">
							            <small>Общая классификация автоматических ПИ</small>
							        </div>
							        <div class="form-group col custom-control custom-checkbox">
							            <label class="" for="automate_attribute">По виду контролируемого признака пожара</label>
										<select class="form-control" id="automate_attribute" name="automate_attribute" v-model="sensorData.automate_attribute">
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
										<select class="form-control" id="automate_reaction" name="automate_reaction" v-model="sensorData.automate_reaction">
										  <option disabled value="" >Выберите один из вариантов</option>
										  <option value="maximal">Максимальный</option>
										  <option value="differincial">Дифференциальный</option>
										  <option value="max-diff">Максимально-дифференциальный</option>
										</select>
							        </div>
								</div>


							    <div class="">
							        <div class="form-group col btn-group">
										<button type="button" @click="cancel" class="cancel">Отмена</button>
										<button type="button" @click="save" class="save">Сохранить</button>
									</div>
								</div>
							</form>
		                </div>
		            </div>
                </div>
			</div>
		</div>
	</transition>
</template>

<script>
	export default{
		props: {
			mode: {
				type: String,
				required: true,
				validator: function (value) {
					return value == 'new' || value == 'edit';
				}
			},
			edit: {
				type: Boolean,
				default: false
			},
			sensorData: {
				type: Object,
				default: () => {}
			}
		},
		data: function () {
			return {
				errors: [],
			}
		},
		methods: {
			save(){
				if(!this.check())
					return false;
				const method = this.mode == 'new' ? 'ADD_SENSOR' : 'UPDATE_SENSOR';
				this.$store.commit(method, this.sensorData);
				this.$emit('end-adding')
			},
			cancel () {
				this.$emit('end-adding')
			},
			check(){
				let res = true;
				this.errors = [];
				if (!this.sensorData.name) {
					this.errors.push('Требуется указать наименование.');
					res = false;
				}
				if (!this.sensorData.is_automate) {
					this.errors.push('Требуется указать способ приведения в действие.');
					res = false;
				}
				if (!this.sensorData.power_supply) {
					this.errors.push('Требуется указать способ электропитания.');
					res = false;
				}
				if (!this.sensorData.is_address) {
					this.errors.push('Требуется указать возможность установки адреса.');
					res = false;
				}
				return res;
			},
		},
		computed:{
		},
	}
</script>

<style scoped>
</style>