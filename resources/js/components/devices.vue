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
	props:[],
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
		const oid = this.$route.params.id;
		axios
			.post(`/api/objectdevice/get/${oid}`)
			.then( response => this.createTree(response.data) );
	},

	methods:{
		createTree: function (devices) {
			const tree = {};
			devices.map(val => {
				const wireEl = [];
				val.wires.forEach( el => {el.isShow=false; wireEl.push(el)} );
				const alarmEl = [];
				if('alerts' in val){
					val.alerts.forEach( el => {
						const curEl = el;
						curEl.dsvad = el.id;
						curEl.parent_device_id = val.id;
						curEl.icon = el.alert_device.icon;
						curEl.name = el.alert_device.name;
						curEl.type = el.alert_device.type;
						curEl.power = el.alert_device.power;
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
					is_good: val.is_good,
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
			//console.log(this.tree);
			this.$store.commit('SET_DEVICES', this.tree);
		}
	}
}
</script>

<style scoped>

</style>
