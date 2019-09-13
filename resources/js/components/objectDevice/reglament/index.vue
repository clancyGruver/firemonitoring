<template>
	<section>
		<h2>Регламентные работы {{ device.name }}</h2>
		<div class="row">
			<div class="col">
				<div class="card">
					<div class="card-body">
						<div class="table-responsive">
						    <div>
							    <table class="table align-items-center">
							    	<thead class="thead-light">
							            <tr>
							                <th scope="col">
							                    Регламент
							                </th>
							                <th scope="col">
							                    Дата полседнего проведения
							                </th>
							                <th scope="col">
							                    Плнируемая дата проведения
							                </th>
							            </tr>
							        </thead>
        							<tbody class="list">
										<tr v-for="reglament in allReglaments" :key="reglament.id">
											<th scope="row" class="name">
												<a class="pointer card-title" @click.prevent="curReglament = reglament">
													<span class="badge badge-info reglament_badge">
														{{ reglament.name }}
													</span>
												</a>
											</th>
											<td>
												{{ reglament.reglament_work.done_at ? reglament.reglament_work.done_at : "Не проводились" }}
											</td>
											<td :class="dateCompare(reglament.reglament_work.planned_reglament_at)">
												{{ reglament.reglament_work.planned_reglament_at }}
											</td>
										</tr>
        							</tbody>
							    </table>
						    </div>
						</div>
					</div>
				</div>
			</div>
			<div class="col">
				<div class="card">
					<div class="card-body">
						<ul class="list-unstyled" v-if="curReglament">
							<li v-for="(element,idx) in curReglament.elements" :key="element.id">
								<div class="custom-control custom-checkbox mb-3">
									<input
										class="custom-control-input"
										type="checkbox"
										:id="element.id"
										:value="element"
										v-model="checkedElements"
									>
									<label class="custom-control-label" :for="element.id">{{element.text}}</label>
								</div>
							</li>
							<button type="button" class="btn btn-success mt-4" @click.prevent="save">Сохранить</button>
							<button type="button" class="btn btn-warning mt-4" @click.prevent="$router.go(-1)">Назад</button>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</section>
</template>

<script>

export default {
	props:{},

	data() {
		return {
			curReglament: null,
			allReglaments: {},
			checkedElements: [],
			device: {},
		}
	},

	components:{},

	beforeCreate: function(){
		const self = this;
		axios.post(`/api/reglament/getByODID/${this.$route.params.objectDeviceId}`)
		.then( response => {
			this.allReglaments = response.data.reglaments;
			this.device = response.data.device;
		})
	},

	methods:{
		dateCompare(checkDate){
			let [day,month,year] = checkDate.split('-');
			month -= 1;
			const checkDateObj = new Date(year, month, day);
			const curDate = new Date();
			curDate.setHours(0,0,0,0);
			let nextWeekDate = new Date();
			nextWeekDate.setDate(nextWeekDate.getDate() + 7);
			if(checkDateObj > nextWeekDate)
				return '';
			if(checkDateObj <= nextWeekDate && checkDateObj >= curDate)
				return 'text-primary';
			else
				return 'text-danger';
		},
		getReglaments(){
			const self = this;
			axios.post(`/api/reglament/getByODID/${this.$route.params.objectDeviceId}`)
			.then( response => {
				this.allReglaments = response.data.reglaments;
				this.device = response.data.device;
			})
		},
		save(){
			if(this.checkedElements.length != this.curReglament.elements.length){
				this.$awn.alert('Не все работы по регламенту проведены');
				return false;
			}
			this.$store.dispatch('TOGGLE_DEVICE_REGLAMENT',{
				typeIdx: this.$route.params.typeIdx,
				deviceId: this.device.id,
				reglamentId: this.curReglament.id,
				reglamentWorkId: this.curReglament.reglament_work.id,
				odid: this.$route.params.objectDeviceId,
			})
            .then( success => {
            	this.$awn.success('Проведенная работа сохранена');
            	//update work dates
            	this.getReglaments();
            	this.$router.push({
					name: 'objectDeviceLimitaion',
					params:{
						objectDeviceId: this.$route.params.objectDeviceId,
						typeIdx: this.$route.params.typeIdx,
					}
            	});
            })
            .catch( error => this.$awn.alert('При обновлении данных возникла ошибка'));
		}
	},

	watch:{
		curReglament(){ this.checkedElements = []},
	},

	computed: {
	}
}
</script>

<style scoped>
.reglament_badge{
	font-size: 100%;
	font-weight: bold;
	color: #333;
}
</style>
