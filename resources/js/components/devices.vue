<template>
	<device-component></device-component>
</template>

<script>
import deviceComponent from './device-component.vue';

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
		deviceComponent
	},
	mounted: function(){
		const oid = this.objectid;		
		axios
			.post(`/api/objectdevice/get/${oid}`)
			.then( response => this.crateTree(response.data) )
	},

	methods:{
		crateTree: function (devices) {
			const tree = [];
			devices.map(val => {
				const childrenEl = [];
				/*for(let i = 0; i < val.device.wires_count; i++ ){				
					childrenEl.push({
						name: `Шлейф ${val.id}-${i}`,
		                id: 2,
		                isLeaf: true,
		                pid: 1	
					});	                
				};*/
				const treeEl = {
					name: val.device.name,
					pid: 0,
		            dragDisabled: true,
		            addTreeNodeDisabled: false,
		            addLeafNodeDisabled: true,
		            editNodeDisabled: true,
		            delNodeDisabled: true,
		            children: childrenEl,
		            max_wires: val.device.wires_count,
				};	
				val.device
				this.tree.push(treeEl);
			})	
			console.log(this.$store, this.tree);
			this.$store.commit('SET_DEVICES', this.tree);
		}		

		/*
            name: 'Node 1',
            id: 1,
            pid: 0,
		*/
	}
}
	
</script>

<style scoped>
	
</style>