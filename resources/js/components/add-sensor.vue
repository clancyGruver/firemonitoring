<template>
	<section>
			<div class="card card-stats">
				<div class="card-body">

          <div class="alert alert-danger" v-show="errors.length > 0">
              <ul>
                  <li v-for="(error, index) in errors" :key="index">{{ error }}</li>
              </ul>
          </div>

          <div class="row">
            <div class="col">
              <div class="row">
                <form class="form-inline">
                  <div class="form-group">
                    <div class="input-group mb-4">
                      <div class="input-group-prepend">
                        <span class="input-group-text"><i class="fas fa-search"></i></span>
                      </div>
                      <input class="form-control" placeholder="Поиск" type="text" v-model="searchString">
                    </div>
                  </div>
                  <div class="form-group">
                    <div class="input-group mb-4">
                      <div class="input-group-prepend">
                        <span class="input-group-text"><i class="fas fa-cogs"></i></span>
                      </div>
                      <input class="form-control" placeholder="Количество извещателей" type="number" v-model.number="sensorData.count">
                    </div>
                  </div>
                </form>
              </div>
              <div class="row">
                <div v-if="sensorData.sensor_id">
                  <strong>{{getSensorById(sensorData.sensor_id).name}}</strong>
                  <hr>
                </div>
              </div>
              <div class="row">
                <ul class="list-unstyled">
                  <li v-for="sensor in availSensors" :key="sensor.id">
                    <span class="mb-0" @click="addSensor(sensor)">
                      <span>{{sensor.name}}</span>
                    </span>
                  </li>
                </ul>
              </div>
            </div>
            <div class="col">
              <form>
                <div class="form-group col"  v-show="!sensorData.count || sensorData.count < 2">
                  <label for="name">Наименование</label>
                  <input id="name" name="name" type="text" class="form-control" placeholder="Наименование" v-model.trim="sensorData.name">
                </div>
                <div class="form-group col">
                  <label for="floor">Этаж</label>
                  <input id="floor" name="floor" type="number" class="form-control" placeholder="Этаж" v-model.number="sensorData.floor">
                </div>
                <div class="form-group col" v-show="!sensorData.count || sensorData.count < 2">
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
          <div class="card-footer bg-transparent border-success mt-4">
            <font-loader :text="'Идет сохранение'"  v-if="saving" />
            <div class="btn-group" role="group" v-else>
              <button type="button" class="btn btn-success mt-4" @click="handleCommit">Сохранить</button>
              <button type="button" class="btn btn-warning mt-4" @click="cancel">Отмена</button>
            </div>
          </div>
				</div>
			</div>
	</section>
</template>

<script>
  import fontLoader from './fontLoader';

	export default{
    components:{fontLoader},
		props: {},
		data: function () {
			return {
        searchString: '',
        errors: [],
        sensor: {},
        saving: false,
        sensorData:{},
			}
		},
		methods: {
      cancel () {
        this.$router.go(-1);
      },
      handleCommit(){
        if(!this.validate()) return false;
        const actionMethod = this.$route.params.sensorId ? 'UPDATE_SENSOR_TO_WIRE' : 'ADD_SENSOR_TO_WIRE';
        const resultString = this.$route.params.sensorId ? 'Извещатель добавлен' : 'Извещатель изменен';
        const data = {
          sensor: this.getSensorById(this.sensorData.sensor_id),
          deviceId: this.$route.params.deviceId,
          ObjectId: this.$route.params.id,
          wireId: this.$route.params.wireId,
          sensorData: this.sensorData,
        };
        const self = this;
        return this.$store.dispatch(actionMethod, data)
                          .then(response => {
                            this.$awn.success(resultString);
                            self.cancel();
                          })
                          .catch(error => {
                            console.log(error);
                            this.$awn.alert('При сохранении произошли ошибки')
                          });
        this.cancel();
      },
      getSensorById(id){
        const filtered = this.$store.getters.ALL_SENSORS;
        const sid = this.sensorData.sensor_id;
        const currentSensorIdx = filtered.findIndex(s => s.id == sid )
        return filtered[currentSensorIdx];
      },
			addSensor(sensor){this.sensorData.sensor_id = sensor.id;},
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

        if(this.sensorData.count && this.sensorData.count < 2)
          if(this.sensorData.name === ''){
            this.errors.push('Не введено наименование');
            checked = false;
          }

        if(this.sensorData.count && this.sensorData.count < 2)
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

        if(!this.sensorData.sensor_id){
          this.errors.push('Не выбран извещатель');
          checked = false;
        }

        return checked;
      },
      getSensorData(){
        const sensorId = this.$route.params.sensorId ? this.$route.params.sensorId : false;
        const deviceId = this.$route.params.deviceId;
        const wireId = this.$route.params.wireId;
        const wire = this.$store.getters.OBJECT_DEVICE_WIRE_BY_ID(deviceId,wireId);
        const currentSensor = wire.sensors.find( sensor => sensor && (sensor.id == sensorId) );
        const emptySensor = {
          deviceId: deviceId,
          wire_id: wireId,
          name: wire.sensors.length + 1,
          cabinet_name: '',
          comment:'',
          sensor_id: sensorId,
        }
        this.sensorData = sensorId ? currentSensor : emptySensor;
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
      },
		},
    mounted(){
      this.getSensorData();
    },
	}
</script>

<style scoped>
	span{
		cursor: pointer;
	}
</style>