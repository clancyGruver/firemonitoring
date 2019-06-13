<template>	
	<transition name="modal">
		<div class="modal-mask mb-4 " v-show="creating" @click.self="cancel">
			<div class="modal-container card card-stats">
				<div class="modal-content card-body">
					<h5 class="card-title">Добавить шлейф</h5> 
					<div class="row"  v-if="errors.length">
					  <p>
					    <b>Пожалуйста исправьте указанные ошибки:</b>
					    <ul>
					    	<li class="alert alert-danger" role="alert" v-for="error in errors">{{ error }}</li>
					    </ul>
					  </p>
				  </div>

                    <div class="row">
						<form @keyup.enter="save">
							<div class="">
			                    <div class="form-group col">
			                    <label for="description">Наименование шлейфа</label>
			                        <input id="description" name="description" type="text" class="form-control" placeholder="Наименование шлейфа" v-model="newWire.description">
			                    </div>
			                </div>
			                <div class="">
			                    <div class="form-group col custom-control custom-checkbox">
			                        <input class="custom-control-input" id="is_good" name="is_good" type="checkbox"v-model="newWire.is_good">
			                        <label class="custom-control-label" for="is_good">Исправен</label>
			                    </div>
			                </div>

				            <div class="">      
				                <div class="form-group col">
				                    <label for="type">Тип шлейфа</label>
				                    <select id="type" name="type" class="form-control" v-model="newWire.type">
				                        <option value="unsafe" selected>Пожароопасный</option>
				                        <option value="safe">Пожаробезопасный</option>
				                        <option value="radio">Радиоканал</option>
				                    </select>
				                </div>
				            </div>

							<div class="">
			                    <div class="form-group col">
			                    <label for="sertificate">Сертификат</label>
			                        <input id="sertificate" name="sertificate" type="text" class="form-control" placeholder="Сертификат" v-model="newWire.sertificate">
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
	</transition>
</template>

<script>
	export default{
		props: {
			mode:{
				type: String,
		        default: 'new',
		        validator: function (value) {
		          return ['new','edit'].indexOf(value) > -1
		        },
			},
			odid:{
				type: Number,
				default: null
			},
			creating: {
				type: Boolean,
				default: false
			},
			newWire: {
				type: Object,
				default: function () {
					return {
						description:'',
						is_fire_safety: '',
						sertificate: '',
						is_good: true,
						type: 'unsafe',
					}
				}	
				
			},
		},		
		data: function () {
			return {
				errors: [],
			}
		},
		methods: {		
			cancel () {
				this.$emit('end-adding')
				this.newWire = {
					is_good: true,
				};
			},
			save () {
				this.errors = [];
				if (!this.newWire.description) {
					this.errors.push('Требуется указать наименование шлейфа.');
					return false;
				}				
				console.log(this.newWire);
				if(this.mode == 'new'){
					this.$store.commit('ADD_WIRE', {odid:this.odid, wire:this.newWire});	
				}
				else{
					this.$store.commit('EDIT_WIRE', this.newWire);		
				}
				
				this.cancel();
			},
		},
		computed:{
			availDevs: function () {return this.$store.getters.AVAILABLE_DEVICES},
		},
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