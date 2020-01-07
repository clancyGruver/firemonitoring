<template>
	<div class="card">
		<div class="card-body">
    		<h5 class="card-title">{{reglament.name}}</h5>
			<ul class="list-unstyled" v-if="reglament">
				<li v-for="(element,idx) in reglament.elements" :key="element.id">
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
               	<router-link
               		tag="button"
               		class="btn btn-warning mt-4"
               		:to="`/objects/${$route.params.id}/devices`"
               	>
               		Назад
               	</router-link>
			</ul>
		</div>
	</div>
</template>

<script>
export default{
	props:{
		reglament:{
			type:Object,
			default: function(){return {};},
		},
		reglamentWorkId:{
			type:Number,
			default: -1,
		}
	},
	data(){
		return {
			checkedElements: [],
		}
	},
	methods:{
		save(){
			if(this.checkedElements.length != this.reglament.elements.length){
				this.$awn.alert('Не все работы по регламенту проведены');
				return false;
			}
			this.$store.dispatch('TOGGLE_DEVICE_REGLAMENT',{reglamentWorkId:this.reglamentWorkId});
		}
	}

}
</script>