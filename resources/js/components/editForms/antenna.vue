<template>
	<transition name="modal">
		<div class="modal-mask mb-4" role="document" @click.self="cancel">
			<div class="modal-content card-body modal-wrapper">
				<div class="modal-body p-0 modal-container">
                	<div class="card bg-secondary shadow border-0">
						<div class="card-header bg-transparent modal-header">
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
							<form @keyup.enter="save">
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
									<autocomplete
										:search="search"
										:default-value="getCableTypeName"
								    	@submit="handleCableType"
								    >
								    </autocomplete>
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
import Autocomplete from '@trevoreyre/autocomplete-vue';
import '@trevoreyre/autocomplete-vue/dist/style.css';

export default{
components:{Autocomplete},
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
		handleCableType(cableType){
			this.$store.dispatch('CHECK_CABLE_TYPE', cableType)
						.then( resp => this.deviceData.cable_type = resp);
		},
		search(input) {
			const result = this.cableTypes.filter( cableType => {
				return cableType.toLowerCase()
								.includes(input.toLowerCase())
			})
			result.unshift(input);
			return result;
		},
		save(){
			if(!this.check())
				return false;
			this.$store.dispatch('UPDATE_OBJECT_DEVICE_PARAMS', {type:'antenna', data: this.deviceData});
			this.cancel();
		},
		cancel () {
			this.$emit('end-adding');
		},
		check(){
			let res = true;
			this.errors = [];
			if (!this.deviceData.setup_place) {
				this.errors.push('Требуется указать место установки.');
				res = false;
			}
			if (![0,1].includes(this.deviceData.mast_isset)) {
				this.errors.push('Требуется указать наличие мачты.');
				res = false;
			}
			return res;
		},
	},
	computed: {
		cableTypes(){ return this.$store.getters.CABLE_TYPES.map( cableType => cableType.name); },
		getCableTypeName() {
			const cableId = this.deviceData.cable_type;
			const cableType = this.$store.getters.CABLE_TYPES.find( ct => ct.id == cableId);
			console.log(cableId, cableType, this.$store.getters.CABLE_TYPES);
			return cableType ? cableType.name : '';
		},
	}
}
</script>

<style scoped>
.modal-mask {
  background-color: rgba(0, 0, 0, 0.7);
  cursor: pointer;
  display: flex;
  justify-content: center;
  align-items: center;
  position: fixed;
  z-index: 9998;
  top: 0;
  left: 0;
  height: 100%;
  width: 100%;
  transition: opacity 0.3s ease;
}
.modal-mask .modal-container {
  background-color: white;
  border-radius: 2px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.33);
  cursor: default;
  font-family: Helvetica, Arial, sans-serif;
  margin: 40px auto 0;
  padding: 20px 30px;
  transition: all 0.3s ease;
}
.modal-content {
  background-color: rgba(0,0,0,0);
}
.modal-mask .modal-container .modal-content {
  border-radius: 10px;
  color: black;
  margin: 1em;
  padding: 1em;
  width: 800px;
}
.modal-mask .modal-container .modal-content h1 {
  margin: 0;
}
.modal-mask .modal-container .modal-content form {
  display: flex;
  flex-wrap: wrap;
  justify-content: flex-end;
  width: 100%;
}
.modal-mask .modal-container .modal-content form input {
  border: 1px solid rgba(0, 0, 0, 0.5);
  border-radius: 5px;
  font-size: 16px;
  font-weight: bold;
  margin: 1em 0;
  padding: 0.2em 0.5em;
  height: 30px;
  width: 100%;
}
.modal-mask .modal-container .modal-content form button {
  background: none;
  border-radius: 5px;
  cursor: pointer;
  font-size: 16px;
  font-weight: bold;
  height: 30px;
  transition: all 0.3s ease-in-out;
}
.modal-mask .modal-container .modal-content form button.save {
  border: 3px solid #3498db;
  color: #3498db;
  margin-left: 1em;
}
.modal-mask .modal-container .modal-content form button.save:hover {
  background-color: #3498db;
}
.modal-mask .modal-container .modal-content form button.cancel {
  border: 3px solid #f39c12;
  color: #f39c12;
}
.modal-mask .modal-container .modal-content form button.cancel:hover {
  background-color: #f39c12;
}
.modal-mask .modal-container .modal-content form button:hover {
  color: white;
}

.modal-enter, .modal-leave-active {
  opacity: 0;
}

.modal-enter .modal-container, .modal-leave-active .modal-container {
  transform: scale(1.1);
}
</style>