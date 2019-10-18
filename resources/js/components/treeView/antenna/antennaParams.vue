<template>
	<div class="card">
		<div class="card-header">
            <div class="text-muted text-center">
        		<small>Свойства антенны</small>
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
        <div class="card-body modal-body">
			<form>
		        <div class="form-group col">
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
		        <div class="form-group col custom-control">
		            <label class="" for="mast_isset">Наличие мачты</label>
					<select class="form-control" id="mast_isset" name="mast_isset" v-model="deviceData.mast_isset">
					  <option disabled value="" >Выберите один из вариантов</option>
					  <option value="1">Есть</option>
					  <option value="0">Нет</option>
					</select>
		        </div>

				<div v-show="deviceData.mast_isset == 1">
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
					  <option value="RK 50">RK 50</option>
					  <option value="RG 213">RG 213</option>
					</select>
		        </div>
			</form>
        </div>
    </div>
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
				this.$store.dispatch('UPDATE_OBJECT_DEVICE_PARAMS', {type:'antenna', data: this.deviceData});
			},
			check(){
				let res = true;
				this.errors = [];
				if (!this.deviceData.setup_place) {
					this.errors.push('Требуется указать место установки.');
					res = false;
				}
				if (!this.deviceData.mast_isset) {
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