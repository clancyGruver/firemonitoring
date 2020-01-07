<template>
	<modal name="rspi-params" transition="pop-out" height="auto">
		<div class="mb-4">
			<div class="card-body">
				<div class="p-0">
                	<div class="card bg-secondary shadow border-0">
						<div class="card-header bg-transparent">
	                        <div class="text-muted text-center">
                        		<small>Свойства системы передачи извещений</small>
                        	</div>
							<div class="text-muted text-center mt-2"  v-if="errors.length">
								<p>
									<b>Пожалуйста исправьте указанные ошибки:</b>
									<ul>
										<li class="alert alert-danger" role="alert" v-for="(error, index) in errors" :key="index">{{ error }}</li>
									</ul>
								</p>
							</div>
	                    </div>
		                <div class="card-body">
							<form @keyup.enter="save">
						        <div class="form-group col custom-control">
						        	<label for="setup_place">Место установки</label>
						            <input
										id="setup_place"
										name="setup_place"
										type="text"
										class="form-control"
										placeholder="Место установки"
										v-model="deviceData.setup_place"
									>
						        </div>
						        <div class="form-group col custom-control custom-checkbox">
									<input
										id="battery"
										name="battery"
										type="checkbox"
										class="custom-control-input"
										v-model="deviceData.battery"
									>
									<label for="battery" class="custom-control-label">
										Наличие АКБ
									</label>
						        </div>

								<div v-show="deviceData.battery == 1">
									<div class="form-group custom-control custom-checkbox">
										<input
											id="power_supply"
											name="power_supply"
											type="checkbox"
											class="custom-control-input"
											v-model="deviceData.power_supply"
										>
										<label for="power_supply" class="custom-control-label">
											Наличие блоков питания
										</label>
									</div>
									<div class="form-group col">
										<label for="capacity">Емкость</label>
										<input
											id="capacity"
											name="capacity"
											type="number"
											class="form-control"
											v-model.number="deviceData.capacity"
										>
									</div>
								</div>

						        <div class="form-group col custom-control">
						            <label class="" for="coupling">Сопряжение с апс</label>
									<select class="form-control" id="coupling" name="coupling" v-model="deviceData.coupling">
									  <option disabled value="" >Выберите один из вариантов</option>
									  <option value="fire">Пожар</option>
									  <option value="fault">Неисправность</option>
									  <option value="fire/fault">Пожар/неисправность</option>
									</select>
						        </div>


							    <div class="">
							        <div class="form-group col btn-group">
										<button type="button" @click="cancel" class="btn btn-danger">Отмена</button>
										<button type="button" @click="save" class="btn btn-success">Сохранить</button>
									</div>
								</div>
							</form>
		                </div>
		            </div>
                </div>
			</div>
		</div>
	</modal>
</template>

<script>
	export default{
  	name: "rspiParams",
		props: {
			deviceData: {
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
				this.$store.dispatch('UPDATE_OBJECT_DEVICE_PARAMS', {type:'rspi', data: this.deviceData});
				this.cancel();
			},
			cancel () {
      	this.$modal.hide("rspi-params");
			},
			check(){
				let res = true;
				this.errors = [];
				if (!this.deviceData.setup_place) {
					this.errors.push('Требуется указать место установки.');
					res = false;
				}
				if (!this.deviceData.coupling) {
					this.errors.push('Требуется указать сопряжение с АПС.');
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