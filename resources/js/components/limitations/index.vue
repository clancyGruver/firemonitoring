<template>
	<div>
		<div class="row" v-for="(device, index) in devices" :key="index">
			<ul>
				<h3>{{device.name}}</h3>
				<li v-for="dev in device.devices" :key="dev.id" class="list-unstyled">
					{{dev.name}}
				</li>
			</ul>
		</div>
	</div>
</template>

<script>
	export default{
		computed:{
			devices() {return this.$store.getters.AVAILABLE_DEVICES},
		}
	}
</script>

<style scoped>

</style>