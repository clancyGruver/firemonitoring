<template>
	<modal name="sva-params" transition="pop-out" height="auto">
		<div class="mb-4">
			<div class="card-body">
				<div class="p-0">
          <div class="card bg-secondary shadow border-0">
						<div class="card-header bg-transparent">
              <div class="text-muted text-center">
                <small>Свойства системы передачи извещений</small>
              </div>
            </div>
            <div class="card-body">
							<form @keyup.enter="save">
                <div class="form-group col custom-control custom-checkbox">
									<input
										id="accumulator-isset"
										name="accumulator-isset"
										type="checkbox"
										class="custom-control-input"
										v-model="deviceData.accumulator_isset"
									>
									<label for="accumulator-isset" class="custom-control-label">
										Наличие АКБ
									</label>
                </div>

								<div v-show="deviceData.accumulator_isset == 1">
									<div class="form-group custom-control custom-checkbox">
										<input
											id="accumulator_count"
											name="accumulator_count"
											type="checkbox"
											class="custom-control-input"
											v-model.number="deviceData.accumulator_count"
										>
										<label for="accumulator_count" class="custom-control-label">
											Количество блоков питания
										</label>
									</div>
									<div class="form-group col">
										<label for="battery_capacity">Емкость, Ач</label>
										<input
											id="battery_capacity"
											name="battery_capacity"
											type="number"
											class="form-control"
											v-model.number="deviceData.battery_capacity"
										>
									</div>
									<div class="form-group col">
										<label for="output_voltage">Выходное напряжение, В</label>
										<input
											id="output_voltage"
											name="output_voltage"
											type="number"
											class="form-control"
											v-model.number="deviceData.output_voltage"
										>
									</div>
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
  	name: "svaParams",
		props: {
			deviceData: {
				type: Object,
				default: () => {}
			}
		},
		data: function () {
		},
		methods: {
			save(){
				if(!this.check())
					return false;
				this.$store.dispatch('UPDATE_OBJECT_DEVICE_PARAMS', {type:'voice_alerts', data: this.deviceData});
				this.cancel();
			},
			cancel () {
      	this.$modal.hide("sva-params");
			},
			check(){
				let res = true;
				this.errors = [];
				return res;
			},
		},
		computed:{
		},
	}
</script>

<style scoped>
</style>