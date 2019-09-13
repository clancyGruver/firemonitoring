<template>
	<transition name="dropdown" tag="section" class="dropdown">
		<div class="mb-4 mt-4" v-show="creating" @click.self="cancel">
			<div class="card">
				<div class="card-body">
					<h5 class="card-title">Добавить оборудование</h5>
                    <div class="row">
                        <div class="col" v-for="devClass in availDevs" v-if="devClass.name != 'sensors'">
                            <h5 class="card-title text-uppercase text-muted mb-0">{{ devClass.name }}</h5>
                            <ul class="list-unstyled">
                                <li v-for="device in devClass.devices">
                                    <span class="h2 font-weight-bold mb-0" @click="addDevice(device,devClass.tbl_name)">{{device.name}}</span>
                                </li>
                            </ul>
                        </div>
                    </div>
				</div>
			</div>
		</div>
	</transition>
</template>

<script>
	export default{
		props: {
			creating: {
				type: Boolean,
				default: false
			}
		},
		data: function () {
			return {
			}
		},
		methods: {
			addDevice(device, tbl_name){
				device.object_id = this.$route.params.id;
				device.device_id = device.id;
				device.tbl_name = tbl_name;
				this.$store.dispatch('ADD_OBJECT_DEVICE', device).then(success => this.$awn.success('Устройство добавлено'));
        		this.cancel();
			},
			cancel() {
				this.$emit('end-adding')
			}
		},
		computed:{
			availDevs: function () {return this.$store.getters.AVAILABLE_DEVICES},
		},
	}
</script>

<style scoped>
	span{
		cursor: pointer;
	}
.dropdown {
  position: relative;
  height: 0;
  overflow: hidden;
  transition: height 350ms;
}

.dropdown::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 0;
  width: 100%;
  height: 1rem;
  background-image: linear-gradient(to top, white, rgba(white, 0));
}

.dropdown-enter,.dropdown-leave-to { opacity: 0 }

.dropdown-leave,.dropdown-enter-to { opacity: 1 }

.dropdown-enter-active,.dropdown-leave-active {
  position: absolute;
  width: 100%;
  transition: opacity 200ms ease-in-out;
}

.dropdown-enter-active { transition-delay: 100ms }
</style>