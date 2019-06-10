<template>	
	<transition name="modal">
		<div class="modal-mask mb-4 " v-show="creating" @click.self="cancel">
			<div class="modal-container card card-stats">
				<div class="modal-content card-body">
					<h5 class="card-title">Добавить сенсор</h5> 
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
              <ul class="list-unstyled">
                <li v-for="sensor in availSensors">
                  <span class="h2 font-weight-bold mb-0" @click="addSensor(sensor)">{{sensor.name}}</span>
                </li>
              </ul>  
            </div>
            <div class="col">  
              <form>
                <div class="form-group col">
                  <label for="name">Наименование</label>
                  <input id="name" name="name" type="text" class="form-control" placeholder="Наименование" v-model="sensorData.name">
                </div>
                <div class="form-group col">
                  <label for="floor">Этаж</label>
                  <input id="floor" name="floor" type="text" class="form-control" placeholder="Этаж" v-model="sensorData.floor">
                </div>
                <div class="form-group col">
                  <label for="cabinetName">Нименование помещения</label>
                  <input id="cabinetName" name="cabinetName" type="text" class="form-control" placeholder="Нименование помещения" v-model="sensorData.cabinetName">
                </div>                
                <div class="form-group col custom-control custom-checkbox">
                  <input class="custom-control-input" id="SP5Valid" name="SP5Valid" type="checkbox"v-model="sensorData.SP5Valid">
                  <label class="custom-control-label" for="SP5Valid">Соостетсвует СП5</label>
                </div>                
                <div class="form-group col custom-control custom-checkbox">
                  <input class="custom-control-input" id="isGood" name="isGood" type="checkbox"v-model="sensorData.isGood">
                  <label class="custom-control-label" for="isGood">В рабочем состоянии</label>
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
      sensorData:{
        type: Object,
        default: function() { return {
            name: '',
            deviceId: -1,
            wireId: -1,
            floor: '',
            cabinet_name: '',
            SP5_valid: '',
            is_good: '',
          }
        }
      },
			creating: {
				type: Boolean,
				default: false
			}
		},		
		data: function () {
			return {
        searchString: '',
			}
		},
		methods: {		
      cancel () {
        this.$emit('end-adding')
      },
			addSensor(sensor){
				this.$store.commit('ADD_SENSOR_TO_WIRE', {
          sensor:   sensor, 
          deviceId: this.deviceId,
          wireId:   this.wireId
        });
				this.cancel();
			},
		},
		computed:{
			availSensors: function () {
        let filtered = this.$store.getters.ALL_SENSORS;
        const SS = this.searchString;
        if(SS)
          filtered = this.$store.getters.ALL_SENSORS.filter(s => s.name.includes(SS) )
        return filtered;
      },
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