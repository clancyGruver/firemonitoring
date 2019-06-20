<template>	
    <tree-view />
</template>

<script>
import deviceComponent from './device-component.vue';
import TreeView from './treeView/treeview'

export default {
	props:[
		'objectid',
	],
	data() {
		return {
			tree: [],
		}
	},
	components:{
		deviceComponent,
		TreeView
	},
	mounted: function(){
		const oid = this.objectid;

		axios
			.post(`/api/objectdevice/get/${oid}`)
			.then( response => this.createTree(response.data) );

		axios
			.post(`/api/devices/getbyclass`)
			.then( response => this.$store.commit('SET_AVAILABLE_DEVICES', response.data) )
			this.$store.commit('SET_OBJECT_ID', oid);

		this.$store.commit('FILL_SENSORS');
	},

	methods:{
		createTree: function (devices) {
			console.log(devices)
			const tree = [];
			devices.map(val => {
				const wireEl = [];
				val.wires.forEach( el => {el.isShow=false; wireEl.push(el)} );
				const treeEl = {
					name: val.devicable.name,
					tbl_name: val.tbl_name,
					isShow: false,
					id: val.id,
		            wires: wireEl,
		            wires_count: val.devicable.wires_count,
				};
				val.devicable
				this.tree.push(treeEl);
			})
			this.$store.commit('SET_DEVICES', this.tree);
		}
	}
}
</script>

<style scoped>

</style>
