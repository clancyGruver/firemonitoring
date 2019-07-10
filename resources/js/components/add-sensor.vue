<template>
	<transition name="modal">
		<div class="modal-mask mb-4 " v-show="creating" @click.self="cancel">
			<div class="modal-container card card-stats">
				<div class="modal-content card-body">
					<h5 class="card-title">Добавить сенсор</h5>

          <div class="alert alert-danger" v-show="errors.length > 0">
              <ul>
                  <li v-for="(error, index) in errors" :key="index">{{ error }}</li>
              </ul>
          </div>

          <div class="row">
            <div class="col">
              <div class="form-group">
                <div class="input-group mb-4">
                  <div class="input-group-prepend">
                    <span class="input-group-text"><i class="fas fa-search"></i></span>
                  </div>
                  <input class="form-control" placeholder="Поиск" type="text" v-model="searchString">
                </div>
              </div>
              <div v-if="sensorData.sensor_id">
                <strong>{{getSensorById(sensorData.sensor_id).name}}</strong>
                <hr>
              </div>
              <ul class="list-unstyled">
                <li v-for="sensor in availSensors" :key="sensor.id">
                  <span class="mb-0" @click="addSensor(sensor)">
                    <span>{{sensor.name}}</span>
                  </span>
                </li>
              </ul>
            </div>
            <div class="col">
              <form>
                <div class="form-group col">
                  <label for="name">Наименование</label>
                  <input id="name" name="name" type="text" class="form-control" placeholder="Наименование" v-model.trim="sensorData.name">
                </div>
                <div class="form-group col">
                  <label for="floor">Этаж</label>
                  <input id="floor" name="floor" type="number" class="form-control" placeholder="Этаж" v-model.number="sensorData.floor">
                </div>
                <div class="form-group col">
                  <label for="cabinet_name">Нименование помещения</label>
                  <input id="cabinet_name" name="cabinet_name" type="text" class="form-control" placeholder="Наименование помещения" v-model.trim="sensorData.cabinet_name">
                </div>
                <div class="form-group col custom-control custom-checkbox">
                  <input class="custom-control-input" id="SP5_valid" name="SP5_valid" type="checkbox" v-model="sensorData.SP5_valid">
                  <label class="custom-control-label" for="SP5_valid">Соостетсвует СП5</label>
                  <a href="/uploads/documents/sp5.pdf" target="_blank" class="badge badge-info">СП5</a>
                </div>
                <div class="form-group col custom-control custom-checkbox">
                  <input class="custom-control-input" id="isGood" name="isGood" type="checkbox" v-model="sensorData.is_good">
                  <label class="custom-control-label" for="isGood">В рабочем состоянии</label>
                </div>
                <textarea class="form-control" id="comment" rows="3" name="comment" placeholder="Комментарий" v-model="sensorData.comment"></textarea>
              </form>
            </div>
          </div>
          <div class="card-footer bg-transparent border-success">
            <button type="button" class="btn btn-success mt-4" @click="handleCommit">Сохранить</button>
            <button type="button" class="btn btn-warning mt-4" @click="cancel">Отмена</button>
          </div>
				</div>
			</div>
		</div>
	</transition>
</template>

<script>
	export default{
		props: {
      typeIdx:{
        type: String,
        default: '',
      },
      ObjectDeviceId:{
        type: Number,
        default: -1,
      },
      wireId:{
        type: Number,
        default: -1,
      },
      sensorData:{
        type: Object,
        default: function() { return {
            name: '',
            id: null,
            deviceId: -1,
            wire_id: -1,
            floor: '',
            cabinet_name: '',
            SP5_valid: '',
            is_good: '',
            comment: '',
            sensor_id: -1,
          }
        }
      },
			creating: {
				type: Boolean,
				default: false
			},
      method:{
        type: String,
        default: 'new',
        validator: function (value) {
          return ['new','edit'].indexOf(value) > -1
        },
      }
		},
		data: function () {
			return {
        searchString: '',
        errors: [],
        sensor: {},
			}
		},
		methods: {
      cancel () {
        this.$emit('end-adding',this.sensorData)
      },
      handleCommit(){
        if(!this.validate()) return false;
        const data = {
          sensor: this.getSensorById(this.sensorData.sensor_id),
          typeIdx: this.typeIdx,
          ObjectDeviceId: this.ObjectDeviceId,
          wireId: this.wireId,
          sensorData: this.sensorData,
        };
        if(this.method == 'new')
          this.$store.commit('ADD_SENSOR_TO_WIRE', data);
        else
          this.$store.commit('UPDATE_SENSOR_TO_WIRE', data);
        this.cancel();
      },
      getSensorById(id){
        const filtered = this.$store.getters.ALL_SENSORS;
        const sid = this.sensorData.sensor_id;
        const currentSensorIdx = filtered.findIndex(s => s.id == sid )
        return filtered[currentSensorIdx];
      },
			addSensor(sensor){
        this.sensorData.sensor_id = sensor.id;
			},
      validate(){
        this.errors = [];
        let checked = true;

        if(!Number.isInteger(this.sensorData.floor)){
          this.errors.push('Этаж должен быть числом');
          checked = false;
        }
        else if(this.sensorData.floor === ''){
          this.errors.push('Этаж не заплнен');
          checked = false;
        }

        if(this.sensorData.name === ''){
          this.errors.push('Не введено наименование');
          checked = false;
        }

        if(this.sensorData.cabinet_name === '' || !('cabinet_name' in this.sensorData)){
          this.errors.push('Не введено наименование помещения');
          checked = false;
        }

        if(this.sensorData.deviceId < 0){
          this.errors.push('Устройство не определено');
          checked = false;
        }

        if(this.sensorData.wire_id < 0){
          this.errors.push('Шлейф не определен');
          checked = false;
        }

        return checked;
      }
		},
		computed:{
			availSensors: function () {
        let filtered = this.$store.getters.ALL_SENSORS;
        const SS = this.searchString;
        if(SS)
          filtered = this.$store.getters.ALL_SENSORS.filter(s => s.name.toLowerCase().includes(SS.toLowerCase()) )
        return filtered;
      },
      currentSensor(){
        const filtered = this.$store.getters.ALL_SENSORS;
        const sid = this.sensorData.sensor_id;
        const currentSensorIdx = filtered.findIndex(s => s.id == sid )
        return filtered[currentSensorIdx];
      }
		},
	}
</script>

<style scoped>
	span{
		cursor: pointer;
	}
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
  box-shadow:0 0;
}
.modal-enter, .modal-leave-active {
  opacity: 0;
}

.modal-enter .modal-container, .modal-leave-active .modal-container {
  transform: scale(1.1);
}
</style>