<template>
	<section>
		<p>Количество оставшихся извещателей: {{devices.length}}</p>
		<distinct-reglament :reglament="devices[0]" v-if="devices.length > 0" />
       	<router-link
       		tag="button"
       		class="btn btn-warning mt-4"
       		:to="`/objects/${$route.params.id}/devices`"
       		v-else
       	>
       		Назад
       	</router-link>
	</section>
</template>
<script>
import DistinctReglament from './distinct';

export default{
	props:['objectDeviceId','wireId'],
	components:{DistinctReglament},
	computed:{
		devices(){
			return this.$store.getters.UNREGLAMENTED_SENSORS_ON_WIRE(this.objectDeviceId, this.wireId);
		}
	}
}
</script>