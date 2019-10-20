<template>
	<transition name="dropdown" tag="section" class="dropdown">
		<div class="mb-4 mt-4" v-show="creating" @click.self="cancel">
			<div class="nav-wrapper">
				<ul class="nav nav-pills nav-justified flex-column flex-md-row">
					<li class="nav-item" v-for="(devClass,index) in availDevs" v-if="!['sensors','antennas'].includes(index)" :key="index">
						<a class="nav-link mb-sm-3 mb-md-0" :class="index == selectedCategory ? 'active' : ''" @click.prevent="selectedCategory = index">{{devClass.name}}</a>
					</li>
				</ul>
			</div>

			<div class="card shadow">
				<div class="card-body">
					<div class="tab-content">
						<div class="tab-pane fade show active">
						<p class="description">
							<div class="form-inline form-group">
								<div class="input-group mb-4 col">
									<div class="input-group-prepend">
										<span class="input-group-text" ><i class="ni ni-zoom-split-in"></i></span>
									</div>
									<input
										type="text"
										class="form-control"
										v-model.trim="filterString"
										placeholder="поиск оборудования"
									>
								</div>
								<div class="input-group mb-4 col">
									<div class="input-group-prepend">
										<span class="input-group-text" data-toggle="tooltip" data-placement="top" title="Год монтажа">
											<i class="ni ni-calendar-grid-58"></i>
										</span>
									</div>
									<input
										type="number"
										class="form-control"
										v-model.number="setupYear"
										placeholder="год монтажа"
									>
								</div>
							</div>
						</p>
						<p class="description">
                            <ul class="list-unstyled">
                                <li v-for="(device,index) in deviceCategory.devices" :key="index">
                                    <span class="h2 font-weight-bold mb-0" @click="addDevice(device,deviceCategory.tbl_name)">{{device.name}}</span>
                                </li>
                            </ul>
						</p>
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
			creating: {
				type: Boolean,
				default: false
			}
		},
		data: function () {
			return {
				selectedCategory: null,
				filterString:'',
				deviceCategory:{},
				setupYear: '',
			}
		},
		methods: {
			check(){
				let res = true;
				const alerts = [];
				const setupYear = parseInt(this.setupYear);
				const date = new Date();
				const curYear = date.getFullYear();
				if(!setupYear){
					alerts.push('Не введен год установки оборудования');
				}
				if(setupYear < 1980){
					alerts.push('Год установки оборудования слишком мал');
				}
				if(setupYear > curYear){
					alerts.push('Год установки оборудования не может быть из будущего');
				}
				if(alerts.length > 0){
					res = false;
					alerts.map( error => this.$awn.alert(error));
				}
				return res;
			},
			addDevice(device, tbl_name){
				if(tbl_name == "App\device_aps"){
					if(this.check() == false){
						return;
					}
				}
				device.object_id = this.$route.params.id;
				device.device_id = device.id;
				device.tbl_name = tbl_name;
				device.setup_year = this.setupYear;
				this.$store.dispatch('ADD_OBJECT_DEVICE', device).then(success => this.$awn.success('Устройство добавлено'));
        		this.cancel();
			},
			cancel() {
				this.$emit('end-adding')
			}
		},
		watch:{
			selectedCategory(newVal){
				if(!newVal)
					this.deviceCategory = {};
				this.deviceCategory = this.availDevs[newVal];
				const devices = this.deviceCategory.devices;
				if(this.filterString){
					this.deviceCategory.devices = devices.filter( device => device.name.includes(this.filterString))
				}
			},
			filterString(newVal){
				if(newVal && this.deviceCategory){
					const devices = this.deviceCategory.devices;
					this.deviceCategory.devices = devices.filter( device => device.name.includes(newVal))
				}
			}
		},
		computed:{
			availDevs: function () {return this.$store.getters.AVAILABLE_DEVICES},
		},
	}
</script>

<style scoped>
	span{
		cursor: pointer;
	}
.dropdown {
  position: relative;
  height: 0;
  overflow: hidden;
  transition: height 350ms;
}

.dropdown::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 0;
  width: 100%;
  height: 1rem;
  background-image: linear-gradient(to top, white, rgba(white, 0));
}

.dropdown-enter,.dropdown-leave-to { opacity: 0 }

.dropdown-leave,.dropdown-enter-to { opacity: 1 }

.dropdown-enter-active,.dropdown-leave-active {
  position: absolute;
  width: 100%;
  transition: opacity 200ms ease-in-out;
}

.dropdown-enter-active { transition-delay: 100ms }
</style>