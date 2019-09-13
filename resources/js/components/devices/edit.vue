<template>
	<section>
		<div class="card-body">
        	<div class="card bg-secondary shadow border-0">
				<div class="card-header bg-transparent">
                    <h3 class="text-muted text-center">
                		<small v-if="deviceId">{{ sectionName }}: корректировка</small>
                		<small v-else>{{ sectionName }}: новое оборудование</small>
                	</h3>
                </div>
                <div class="card-body px-lg-5">
			        <div class="form-group col custom-control" v-if="device.instrution">
			            <a
			            	:href="device.instrutionPath"
			            	target="_blank"
			            >
			        		Инструкция
			        	</a>
			        </div>
					<form>
						<div class="form-group col custom-control" v-for="(param, index) in device" :key="index">
							<file-upload
								v-if="index == 'instruction'"
								:label="`Инструкция`"
								v-on:changed="setNewFile"
							/>
							<custom-input
								:val="param"
								:type="'text'"
								:name="'Название'"
								v-if="index == 'name'"
								v-on:changed="setName"
							/>
							<custom-input
								:val="param"
								:type="'number'"
								:name="'Количество шлейфов'"
								v-if="index == 'wires_count'"
								v-on:changed="setWiresCount"
							/>
							<custom-input
								v-if="index == 'power'"
								:val="param"
								:type="'number'"
								:name="'Мощность'"
								v-on:changed="setPower"
							/>
							<custom-select
								v-if="device_type=='alerts' && index == 'type'"
								:val="param"
								:options="[
									{id: 'sound', name:'звуковая'},
									{id: 'voice', name:'голосовая'},
									{id: 'light', name:'световая'}
								]"
								:description="`Тип`"
								@selected="handleAlertType"
							/>
						</div>
					    <div class="">
					        <div class="form-group col btn-group">
								<button type="button" class="btn btn-success" @click.prevent="saveDevicehandler" :disabled="saving">
									<div class="fa" v-if="saving">
									  <i class="fas fa-spinner fa-spin"></i>
									  Сохранение
									</div>
									<div v-else>
										<span v-if="deviceId">Обновить</span>
										<span v-else>Сохранить</span>
									</div>
								</button>
								<button type="button" class="btn btn-error" @click.prevent="$router.go(-1)">
									Отмена
								</button>
							</div>
						</div>
					</form>
                </div>
            </div>
		</div>
	</section>
</template>

<script>
import FileUpload from '../editForms/fileupload';
import CustomInput from '../editForms/input';
import CustomSelect from '../editForms/select';

export default{
	components:{
		FileUpload,
		CustomInput,
		CustomSelect
	},
	props:['device_type', 'deviceId'],
	data: function() {
		return {
			saving: false,
		}
	},
	methods:{
		setPower(e){ this.device.power = e; },
		handleAlertType(e){ this.device.type = e; },
		setName(e){ this.device.name = e; },
		setWiresCount(e){ this.device.wires_count = e; },
		setNewFile(e){ this.device.newFile = e; },
		saveDevicehandler(){
			this.saving = true;
			if(!this.device.name){
				this.$awn.alert(`Не введено название`);
				this.saving = false;
				return false;
			}
			const res = this.saveDevice();
			res.then( response => {
				const routerParams = {
					path:`/devices/${this.device_type}`,
					params: {
						device_type: this.device_type,
					}
				};
				this.$router.push(routerParams);
			})
		},
		saveDevice(){
            let fd = new FormData();
            fd.append('name', this.device.name);
            if(this.device.newFile)
            	fd.append('newFile', this.device.newFile);
            if(this.device.wires_count)
            	fd.append('wires_count', this.device.wires_count*1);
            if(this.device.power)
            	fd.append('power', this.device.power*1);
            if(this.device.type)
            	fd.append('type', this.device.type);

			return this.$store.dispatch('UPDATE_DEVICE',{
				fd,
				device_type: this.device_type,
				deviceId: this.deviceId
			})
				.then( success => {
					const successWord = this.deviceId ? 'обновлен' : 'добавлен'
					this.$awn.success(`${this.device.name} успешно ${successWord}.`)
				})
				.catch( error => {
					this.$awn.alert(`Во время добавления ${this.device.name} произошла ошибка.`)
					console.log(error)
				} )
		}
	},
	computed:{
		sectionName(){return this.$store.getters.AVAILABLE_DEVICES[this.device_type].name},
		device(){
			const res = {};
			if(this.deviceId){
				const curDev = {...this.$store.getters.AVAILABLE_DEVICE(this.device_type, this.deviceId)};
				res.name = curDev.name;
				res.instruction = curDev.instruction ? curDev.instruction : '';
				res.instrutionPath = curDev.instrutionPath ? curDev.instrutionPath : null;
				if(this.device_type == 'aps'){
					res.wires_count = curDev.wires_count ? curDev.wires_count : null;
				}
				if(this.device_type == 'alerts'){
					res.power = curDev.power ? curDev.power : null;
					res.type = curDev.type ? curDev.type : null;
				}
			}
			else{
				res.name = '';
				res.instruction = '';
				if(this.device_type == 'aps'){
					res.wires_count = 0;
				}
				if(this.device_type == 'alerts'){
					res.power = 0;
					res.type = '';
				}
			}
			return res;
		},
	}
}
</script>

<style scoped>

</style>