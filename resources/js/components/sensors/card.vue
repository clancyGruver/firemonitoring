<template>
	<transition name="modal">
		<div class="modal-mask mb-4 " v-show="edit" @click.self="cancel">
			<div class="modal-container card card-stats">
				<div class="modal-content card-body">
    				<h5 class="card-title">{{ sensorData.name }}</h5>
    				<p class="card-text">
    					<div class="row">
    						<div class="col-6">Cенсор</div>
    						<div class="col-6">{{ sensor.name }}</div>
    					</div>
    					<div class="row">
    						<div class="col-6">Этаж</div>
    						<div class="col-6">{{ sensorData.floor }}</div>
    					</div>
    					<div class="row">
							<div class="custom-control custom-control-alternative custom-checkbox mb-3">
							  <input class="custom-control-input" id="customCheck8" type="checkbox" :checked="sensorData.SP5_valid" disabled>
							  <label class="custom-control-label" for="customCheck8">Соостетсвие СП5</label>
							</div>
							<a href="/uploads/documents/sp5.pdf" target="_blank" class="badge badge-info">СП5</a>
    					</div>
    					<div class="row">
							<div class="custom-control custom-control-alternative custom-checkbox mb-3">
							  <input class="custom-control-input" id="customCheck8" type="checkbox" :checked="sensorData.is_good" disabled>
							  <label class="custom-control-label" for="customCheck8">В рабочем состоянии</label>
							</div>
    					</div>
    				</p>
				</div>
			</div>
		</div>
	</transition>
	
</template>

<script>
	export default{

		props: {
			edit: {
				type: Boolean,
				default: false
			},
			sensorData: {
				type: Object,
				default: () => {}
			}
		},
		mounted:function() {
		},
		data: function () {
			return {
			}
		},
		methods: {
			cancel () {
				this.$emit('end-adding')
			},
		},
		computed:{
			sensor: function() {
				return this.sensorData.sensor_id ? this.$store.getters.SENSOR(this.sensorData.sensor_id) : ''
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