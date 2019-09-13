<template>
	<section>
		<section v-if="current_object.devices.loading" class="preloader">
			<div class="sk-cube-grid">
				<div class="sk-cube" :class="`sk-cube-${i}`" v-for="i in 9"></div>
			</div>
		</section>
		<div class="row" v-else>
			<div class="col">
				<tree-view />
			</div>
			<div class="col">
				<bti-map v-if="current_object.btifiles.length > 0"/>
				<p v-else>
					<i class="fas fa-exclamation-triangle text-danger">Планы БТИ отсутствуют</i>
				</p>
			</div>
		</div>
	</section>
</template>

<script>
import deviceComponent from './device-component.vue';
import TreeView from './treeView/treeview';
import btiMap from './leaflet/bti';

export default {
	props:[],
	data() {
		return {
			//tree: {},
		}
	},
	components:{
		deviceComponent,
		TreeView,
		btiMap,
	},
	mounted: function(){
		//this.createTree(this.current_object.devices);
	},

	methods:{
	},
	computed: {
		current_object(){return this.$store.getters.CURRENT_OBJECT},
		tree(){ return this.$store.getters.DEVICE_TREE },
	},
}
</script>

<style scoped>
.preloader {
	width: inherit;
	height: 100%;
	display: flex;
	background-color: #e3e3e3;
}
.sk-cube-grid {
  width: 4em;
  height: 4em;
  margin: auto;
}

.sk-cube {
    width: 33%;
    height: 33%;
    background-color: #337ab7;
    float: left;
    animation: sk-cube-grid-scale-delay 1.3s infinite ease-in-out;
}

.sk-cube-1 {
	animation-delay: 0.2s;
}
.sk-cube-2 {
	animation-delay: 0.3s;
}
.sk-cube-3 {
	animation-delay: 0.4s;
}
.sk-cube-4 {
	animation-delay: 0.1s;
}
.sk-cube-5 {
	animation-delay: 0.2s;
}
.sk-cube-6 {
	animation-delay: 0.3s;
}
.sk-cube-7 {
	animation-delay: 0s;
}
.sk-cube-8 {
	animation-delay: 0.1s;
}
.sk-cube-9 {
	animation-delay: 0.2s;
}

@keyframes sk-cube-grid-scale-delay {
  0%, 70%, 100% {
    transform: scale3D(1,1,1);
  }
  35%           {
    transform: scale3D(0,0,1);
  }
}

</style>
