<template>
	<section>
		<div class="card card-stats">
			<div class="card-body">
				<div class="table-responsive">
					<table class="table align-items-center">
						<tbody>
							<tr>
								<th scope="col">Наименование</th>
								<td>{{ sensor.name }}</td>
							</tr>
							<tr>
								<th scope="col">Инструкция</th>
								<td><a :href="sensor.instrutionPath" target="_blank">{{ sensor.instruction }}</a></td>
							</tr>

							<tr>
								<th scope="col" colspan="2" class="text-center">Классификация ПИ</th>
							</tr>
							<tr>
								<th scope="col">По способу приведения в действие</th>
								<td v-if="sensor.is_automate">Автоматический</td>
								<td v-else>Ручной</td>
							</tr>
							<tr>
								<th scope="col">По способу электропитания</th>
								<td v-if="sensor.power_supply == 'wire'">Питаемый по шлейфу</td>
								<td v-else-if="sensor.power_supply == 'separate wire'">Питаемый по отдельному проводу</td>
								<td v-else="sensor.power_supply == 'stand-alone'">Автономный</td>
							</tr>
							<tr>
								<th scope="col">По возможности установки адреса</th>
								<td v-if="sensor.is_address">Адресный</td>
								<td v-else>Безадресный</td>
							</tr>

							<tr v-show="sensor.power_supply == 'stand-alone'">
								<th scope="col" colspan="2" class="text-center">Общая классификация автономных ПИ</th>
							</tr>
							<tr  v-show="sensor.power_supply == 'stand-alone'">
								<th scope="col">По способу электропитания</th>
								<td v-if="sensor.standalon_function == 'smoke'">Автономный дымовой пожарный извещатель</td>
								<td v-else>Автономный комбинированный пожарный извещатель</td>
							</tr>
							<tr  v-show="sensor.power_supply == 'stand-alone' && sensor.standalon_function == 'smoke'">
								<th scope="col">По принципу обнаружения пожара</th>
								<td v-if="sensor.standalon_smoke_is_radioisotop">Автономный пожарный извещатель радиоизотопный</td>
								<td v-else>Автономный пожарный извещатель оптико-электронный</td>
							</tr>

							<tr v-show="sensor.is_automate">
								<th scope="col" colspan="2" class="text-center">Общая классификация автоматических ПИ</th>
							</tr>
							<tr  v-show="sensor.is_automate">
								<th scope="col">По виду контролируемого признака пожара</th>
								<td v-if="sensor.automate_attribute == 'heat'">Тепловой</td>
								<td v-else-if="sensor.automate_attribute == 'smoke'">Дымовой</td>
								<td v-else-if="sensor.automate_attribute == 'fire'">Пламени</td>
								<td v-else-if="sensor.automate_attribute == 'gas'">Газовый</td>
								<td v-else>Комбинированный</td>
							</tr>
							<tr  v-show="sensor.is_automate">
								<th scope="col">По характеру реакции на контролируемый признак</th>
								<td v-if="sensor.automate_attribute == 'maximal'">Максимальный</td>
								<td v-else-if="sensor.automate_attribute == 'differincial'">Дифференциальный</td>
								<td v-else>Максимально-дифференциальный</td>
							</tr>
						</tbody>
					</table>
				</div>

			</div>
		</div>
	</section>
</template>

<script>
	export default{
		props: ['deviceId'],
		mounted() {},
		data() {
			return {
			}
		},
		methods: {
		},
		computed:{
			sensor() {return this.deviceId ? this.$store.getters.SENSOR(this.deviceId) : {};},
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