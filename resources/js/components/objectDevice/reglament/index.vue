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
										<tr v-for="reglament in allReglaments" :key="reglament.id" @click.prevent="curReglament = reglament">
											<th scope="row" class="name">
												<a class="pointer card-title">
													<span class="badge badge-info reglament_badge">
														{{ reglament.name }}
													</span>
												</a>
											</th>
											<td v-if="reglament.reglament_work">
												<date-picker
													v-if="$store.getters.CURRENT_USER.is_admin"
													v-model="reglament.reglament_work.done_at"
													:lang="'ru'"
													:type="'date'"
													:placeholder="reglament.reglament_work.done_at ? reglament.reglament_work.done_at : 'Не проводились'"
													:input-class="`form-control`"
													:clearable="false"
													:format="`DD-MM-YYYY`"
													:popupStyle="{
														top:0,
														position:'unset',
													}"
													:default-value="new Date()"
													@change="updateDate"
													:first-day-of-week="1"
												/>
												<span v-else>
												{{
													reglament.reglament_work.done_at
														? reglament.reglament_work.done_at
														: 'Не проводились'
												}}
												</span>
											</td>
											<td :class="dateCompare(reglament.reglament_work.planned_reglament_at)"  v-if="reglament.reglament_work">
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
							<li>
								Дата проведения: 
								<date-picker
									v-model="curReglament.reglamentDate"
									:lang="'ru'"
									:type="'date'"
									:placeholder="curReglament.reglamentDate ? curReglament.reglamentDate : 'Не проводились'"
									:input-class="`form-control`"
									:clearable="false"
									:format="`DD-MM-YYYY`"
									:popupStyle="{
										top:0,
										position:'unset',
									}"
									:default-value="new Date()"
									:first-day-of-week="1"
								/>
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
import DatePicker from 'vue2-datepicker'

export default {
	components:{DatePicker},
	props:{},
	data() {
		return {
			curReglament: null,
			allReglaments: {},
			checkedElements: [],
			device: {},
			lang: {
				formatLocale: {
					firstDayOfWeek: 3,
				},
			},
		}
	},
	beforeCreate: function(){
		const self = this;
		axios.post(`/api/reglament/getByODID/${this.$route.params.objectDeviceId}`)
		.then( response => {
			this.allReglaments = response.data.reglaments;
			this.device = response.data.device;
		})
	},

	methods:{
		updateDate(val){
			const reglamentDate = `${val.getDate()}-${val.getMonth()+1}-${val.getFullYear()}`;
			this.$store.dispatch('UPDATE_REGLAMENT_DATE',{
				typeIdx: this.$route.params.typeIdx,
				deviceId: this.device.id,
				reglamentId: this.curReglament.id,
				reglamentWorkId: this.curReglament.reglament_work.id,
				odid: this.$route.params.objectDeviceId,
				reglamentDate
			});
		},
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
			if(this.curReglament.reglamentDate){
				this.curReglament.reglamentDate.setDate(this.curReglament.reglamentDate.getDate() + 1);
			} else {
				const curDate = new Date();
				curDate.setDate(curDate.getDate() + 1);
				this.curReglament.reglamentDate = curDate;
			}
			this.$store.dispatch('TOGGLE_DEVICE_REGLAMENT',{
				typeIdx: this.$route.params.typeIdx,
				deviceId: this.device.id,
				reglamentId: this.curReglament.id,
				reglamentWorkId: this.curReglament.reglament_work.id,
				odid: this.$route.params.objectDeviceId,
				reglamentDate: this.curReglament.reglamentDate,
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
		curReglament(val){
			this.checkedElements = val.elements;
		},
	},

	computed: {
	}
}
</script>

<style>
.reglament_badge{
	font-size: 100%;
	font-weight: bold;
	color: #333;
}
.mx-calendar{
	background-color: white;
	border: 1px solid #73879c;
}
.mx-calendar-content{
	width:100%;
}
</style>
