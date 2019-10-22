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
						v-model="antennaParams.setup_place"
					>
		        </div>
		        <div class="form-group col custom-control">
		            <label class="" for="mast_isset">Наличие мачты</label>
					<select class="form-control" id="mast_isset" name="mast_isset" v-model="antennaParams.mast_isset">
					  <option disabled value="" >Выберите один из вариантов</option>
					  <option value="1">Есть</option>
					  <option value="0">Нет</option>
					</select>
		        </div>

				<div v-show="antennaParams.mast_isset == 1">
					<div class="form-group col">
						<label for="mast_height">Высота мачты</label>
						<input
							id="mast_height"
							name="mast_height"
							type="number"
							class="form-control"
							v-model="antennaParams.mast_height"
						>
					</div>
				</div>

		        <div class="form-group col custom-control">
		            <label class="" for="cable_type">Тип кабеля</label>
					<autocomplete
						:search="search"
				    	@submit="handleCableType"
				    >
				    </autocomplete>
		        </div>
			</form>
        </div>
    </div>
</template>

<script>
import Autocomplete from '@trevoreyre/autocomplete-vue'
import '@trevoreyre/autocomplete-vue/dist/style.css'

export default{
	components:{Autocomplete},
	props: {
		antennaParams: {
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
			console.log(this.antennaParams);
			this.$store.dispatch('UPDATE_OBJECT_DEVICE_PARAMS', {type:'antenna', data: this.antennaParams});
		},
		handleCableType(cableType){
			this.$store.dispatch('CHECK_CABLE_TYPE', cableType);
			this.antennaParams.cable_type = cableType;
		},
		check(){
			let res = true;
			this.errors = [];
			if (!this.antennaParams.setup_place) {
				this.errors.push('Требуется указать место установки.');
				res = false;
			}
			if (!this.antennaParams.mast_isset) {
				this.errors.push('Требуется указать наличие мачты.');
				res = false;
			}
			return res;
		},
		search(input) {
			const result = this.cableTypes.filter( cableType => {
				return cableType.toLowerCase()
								.includes(input.toLowerCase())
			})
			result.unshift(input);
			return result;
		},
	},
	computed: {
		cableTypes(){ return this.$store.getters.CABLE_TYPES.map( cableType => cableType.name); },
	}
}
</script>