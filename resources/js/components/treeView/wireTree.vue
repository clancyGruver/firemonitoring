<template>
		<ul class="list-unstyled">
			<add-wire
				:creating="addWireShow"
				v-on:end-adding="addWireShow = !addWireShow"
				:odid="ObjectDeviceId"
				:type="typeIdx"
				:newWire="wireData"
				:mode="wireMode"
			/>
			<li v-for="(wire, wireIndex) in wires" :key="wireIndex">
				<h3 class="pl-4 pointer">
					<span @click="toggleWire(wireIndex)">
						<span v-if="wire.isShow">-</span>
						<span v-else>+</span>
						{{ wire.description }}
					</span>
					<span class="badge badge-pill badge-success" v-if="wire.type == 'safe'">ПБ</span>
					<span class="badge badge-pill badge-danger" v-else-if="wire.type == 'unsafe'">ПО</span>
					<span class="badge badge-pill badge-default" v-else-if="wire.type == 'radio'">Радио</span>
					<span class="badge badge-pill badge-info">{{ wire.sensors.length }}</span>
					<i class="ml-4 fas fa-edit text-warning pointer" @click="editWire(wire)"></i>
					<i class="ml-2 fas fa-times text-danger pointer" @click="deleteWire(wire)"></i>
				</h3>
				<wire-sensor v-show="wire.isShow" :typeIdx="typeIdx" :ObjectDeviceId="ObjectDeviceId" :wireId="wire.id" :sensors="wire.sensors" />
			</li>
			<li v-if="wires.length < wires_count" class="mt-2 mb-2">
				<button type="button" class="btn btn-success" @click="addWire()">Добавить шлейф</button>
			</li>
		</ul>
</template>

<script>
	import addWire from '../add-wire';
	import wireSensor from "./wireSensor";

	export default
	{
		components: {
			addWire,
			wireSensor,
		},
		props: ['wires','wires_count','typeIdx', 'ObjectDeviceId'],
		data: function () {
			return {
				addWireShow: false,
				FormMethodAllowed: ['new','edit'],
				wireData:{
					description: this.wires.length + 1,
					is_good: true,
					type: 'unsafe',
				},
				wireMode: 'new',
			}
		},
		methods: {
			addWire(){
				this.addWireShow = !this.addWireShow;
				this.wireMode = 'new';
				//this.wireData = wire;
			},
			editWire(wire){
				this.addWireShow = true;
				this.wireMode = 'edit';
				this.wireData = wire;
			},
			deleteWire(wire){
				if(confirm(`Вы действительно хотите удалить ${wire.description}`)){
				  this.$store.commit('DELETE_WIRE', {typeIdx:this.typeIdx, object_device_id:this.ObjectDeviceId, id:wire.id});
				}
			},
			toggleWire(wireIdx){
				const tid = this.typeIdx,
					  odid = this.ObjectDeviceId;
				this.$store.commit('TOGGLE_WIRE_SHOW', {tid, odid, wireIdx});
			},
		},
		computed: {
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