<template>
	<div>
		<ul class="list-unstyled">
			<li  v-for="(item, itemIdx) in items" :key="itemIdx">
				<h4 class="pl-4 ml-4">
					{{ item.name }}
					<i class="ml-4 fas fa-edit text-warning pointer" @click="editDevice(item)"></i>
					<i class="ml-2 fas fa-times text-danger pointer" @click="deleteDevice(item)"></i>
					<i class="ml-2 fas fa-map-marker text-danger pointer" @click="setMarker(item)"></i>
				</h4>
			</li>
		</ul>
	</div>
</template>

<script>
	export default
	{
		components: {
		},
		props: ['items'],
		data: function () {
			return {
			}
		},
		methods: {
			setMarker(device){
				const typeIdx = 'App\\device_system_voice_alert';
				this.$store.commit('TOGGLE_MAP');
				this.$store.commit('SET_MAP_ACTIVE_ALARM',{
					typeIdx:typeIdx,
					alertId:device.id,
					deviceId:device.parent_device_id,
				});
			},
		}
	}
</script>

<style scoped>
	.underline{
		text-decoration: underline;
	}
	.pointer{
		cursor:pointer;
	}
</style>