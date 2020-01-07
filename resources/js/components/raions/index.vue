<template>
    <div class="table-responsive">
        <table class="table align-items-center">
	        <thead class="thead-light">
	            <tr>
	                <th scope="col" class="border-0">#</th>
	                <th scope="col" class="border-0">Наименование</th>
	                <th scope="col" class="border-0">Отображать</th>
	            </tr>
	        </thead>
	        <tbody>
	            <tr v-for="raion, index in raions" :key="raion.id">
	                <th scope="row">
	                    {{index + 1 }}
	                </th>
	                <td>
	                    {{ raion.name }}
	                </td>
	                <td>
	                    <label class="custom-toggle">
	                        <input
	                        	type="checkbox"
	                        	:checked= "!raion.deleted_at"
	                        	@click="toggleRaion(raion)"
	                        >
	                        <span class="custom-toggle-slider rounded-circle"></span>
	                    </label>
	                </td>
	            </tr>
	        </tbody>
	    </table>
    </div>
</template>

<script>
export default{
	methods:{
		toggleRaion(raion){
			this.$store.dispatch('TOGGLE_RAION',raion.id)
			.catch(error => this.$awn.alert('Во время обновления отображения района произошли ошибки') );
		}
	},
	computed:{
		raions(){return this.$store.getters.ALL_RAIONS;},
	}
}
</script>

<style scoped>
	
</style>