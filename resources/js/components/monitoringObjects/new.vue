<template>
	<div class="container-fluid mt-3">
        <transition>
			<monitoring-object-new />
		</transition>
	</div>
</template>

<script>
import MonitoringObjectNew from './new/monitoringObject';

export default {
	props:{},

	data() {
		return {
		}
	},

	components:{MonitoringObjectNew},
}
</script>

<style scoped>

</style>
