<template>
	<div class="row">
		<div class="col">
			<div class="row" v-for="(device, index) in devices" :key="index">
				<ul>
					<h3>{{device.name}}</h3>
					<li v-for="dev in device.devices" :key="dev.id" class="list-unstyled">
						<router-link :active-class="'active'" class="nav-link" :to="{ name: 'reglamentsEdit', params: { deviceId: dev.id, type: index, name: dev.name} }">
							{{dev.name}}
						</router-link>
					</li>
				</ul>
			</div>
		</div>
		<div class="col">
	        <transition name="slide">
	          <router-view></router-view>
	        </transition>
		</div>
	</div>
</template>

<script>
export default{
	props: [],
	data(){
		return {

		}
	},
	methods:{

	},
	computed:{
		devices() {return this.$store.getters.AVAILABLE_DEVICES},
	}
}
</script>