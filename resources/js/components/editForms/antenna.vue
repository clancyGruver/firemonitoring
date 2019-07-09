<template>	
	<transition name="modal">
		<div class="modal-dialog modal- modal-dialog-centered modal-xl modal-mask" role="document" @click.self="cancel">
			<div class="modal-content card-body modal-wrapper">
				<div class="modal-body p-0 modal-container">
                	<div class="card bg-secondary shadow border-0">
						<div class="card-header bg-transparent pb-5 modal-header">
	                        <div class="text-muted text-center mt-2 mb-3">
                        		<small>Свойства антенны</small>
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
						        	<label for="setup_place">Место установки</label>
						            <input 
										id="setup_place" 
										name="setup_place" 
										type="text" 
										class="form-control" 
										placeholder="Место установки" 
										v-model="deviceData.name"
									>
						        </div>
						        <div class="form-group col custom-control">
						            <label class="" for="mast_isset">Имеется мачта</label>
									<select class="form-control" id="mast_isset" name="mast_isset" v-model="deviceData.mast_isset">
									  <option disabled value="" >Выберите один из вариантов</option>
									  <option value="true">Есть</option>
									  <option value="false">Нет</option>
									</select>
						        </div>

								<div v-show="deviceData.mast_isset == 'true'">
									<div class="form-group col">
										<label for="mast_height">Высота мачты</label>
										<input 
											id="mast_height" 
											name="mast_height" 
											type="number" 
											class="form-control" 											
											v-model="deviceData.mast_height"
										>
									</div>
								</div>

						        <div class="form-group col custom-control">
						            <label class="" for="cable_type">Тип кабеля</label>
									<select class="form-control" id="cable_type" name="cable_type" v-model="deviceData.cable_type">
									  <option disabled value="" >Выберите один из вариантов</option>
									  <option value="true">RK 50</option>
									  <option value="false">RG 213</option>
									</select>
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
				console.log(this.deviceData);
				this.$store.commit('UPDATE_ANTENNA', this.sensorData);
				this.$emit('end-adding')
			},
			cancel () {
				this.$emit('end-adding')
			},
			check(){
				let res = true;
				this.errors = [];
				if (!this.antennaData.setup_place) {
					this.errors.push('Требуется указать место установки.');
					res = false;
				}
				if (!this.antennaData.mast_isset) {
					this.errors.push('Требуется указать наличие мачты.');
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