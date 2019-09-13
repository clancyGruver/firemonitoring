<template>
	<form class="form-inline">
		<div class="col-4">
			<label for="name">Наименование</label>
			<input id="name" name="name" type="text" class="form-control mb-2 mr-sm-2" v-model.trim="reglament.name">
		</div>
		<div class="col-8">
			<span>Частота проведения регламентных работ</span>
			<input type="number" class="form-control mb-2 mr-sm-2" v-model.number="periodLongitude">
			<select name="" id="" v-model="periodType">
				<option value=""></option>
				<option v-for="pt in periodTypes" :key="pt.name" :value="pt.name">{{ pt.ruName }}</option>
			</select>
		</div>
	</form>

</template>

<script>
export default{
	props:['reglament'],
	data(){
		return{
			periodTypes:[
				{
					name: 'day',
					ruName: 'День',
				},
				{
					name: 'week',
					ruName: 'Неделя',
				},
				{
					name: 'month',
					ruName: 'Месяц',
				},
				{
					name: 'year',
					ruName: 'Год',
				},
			],
			periodType: '',
			periodLongitude: 0,
		}
	},
	methods:{

	},
	watch:{
		periodType(newVal,oldVal){
			this.reglament[oldVal] = null;
			this.reglament[newVal] = this.periodLongitude;
		},
		periodLongitude(newVal,oldVal){this.reglament[this.periodType] = newVal;},
	},
	updated(){
		let type = '';
		if(this.reglament.day){
			type = 'day';
		}
		if(this.reglament.week){
			type = 'week';
		}
		if(this.reglament.month){
			type = 'month';
		}
		if(this.reglament.year){
			type = 'year';
		}
		this.periodType = type;
		this.periodLongitude = this.reglament[type];
	}
}
</script>