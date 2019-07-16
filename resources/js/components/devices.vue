<template>
	<div class="row">
		<div class="col"><tree-view /></div>
		<div class="col"><bti-map /></div>
	</div>
</template>

<script>
import deviceComponent from './device-component.vue';
import TreeView from './treeView/treeview';
import btiMap from './leaflet/bti';

export default {
	props:[
		'objectid',
	],
	data() {
		return {
			tree: {},
		}
	},
	components:{
		deviceComponent,
		TreeView,
		btiMap,
	},
	mounted: function(){
		const oid = this.objectid;
		this.$store.commit('SET_OBJECT_ID', oid);

		axios
			.post(`/api/objectdevice/get/${oid}`)
			.then( response => this.createTree(response.data) );

		axios
			.post(`/api/devices/getbyclass`)
			.then( response => this.$store.commit('SET_AVAILABLE_DEVICES', response.data) )

		this.$store.commit('SET_BTIPLANS');

		this.$store.commit('FILL_SENSORS');
	},

	methods:{
		createTree: function (devices) {
			console.log(devices)
			const tree = {};
			devices.map(val => {
				const wireEl = [];
				val.wires.forEach( el => {el.isShow=false; wireEl.push(el)} );
				const alarmEl = [];
				if('alerts' in val){
					val.alerts.forEach( el => {
						const curEl = el.alert_device;
						curEl.dsvad = el.id;
						curEl.parent_device_id = val.id;
						alarmEl.push( curEl );
					});
				}
				if(!(val.tbl_name in this.tree)){
					this.tree[val.tbl_name] = {
						name: val.type,
						items: [],
					};
				}
				const treeEl = {
					name: val.devicable.name,
					tbl_name: val.tbl_name,
					isShow: false,
					id: val.id,
					alarms:alarmEl,
		            wires: wireEl,
		            wires_count: val.devicable.wires_count,
		            lng: val.lng,
		            lat: val.lat,
		            icon: val.devicable.icon || 'default',
		            bti_files_id: val.bti_files_id,
		            params: val.params || {},
				};
				this.tree[val.tbl_name].items.push(treeEl);
			})
				console.log(this.tree);
			this.$store.commit('SET_DEVICES', this.tree);
		}
	}
}
</script>

<style scoped>

</style>
