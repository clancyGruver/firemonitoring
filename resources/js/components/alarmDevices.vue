<template>
	<transition name="modal">
		<div class="modal-mask mb-4 " @click.self="cancel">
			<div class="modal-container card card-stats">
				<div class="card-body">
					<h5 class="card-title">Добавить извещатель</h5>
            <div class="row">
              <input class="form-control" type="text" v-model="searchString" placeholder="Поиск" >
              <ul class="list-unstyled">
                <li v-for="device in availDevs" :key="device.id">
                  <span class="h2 font-weight-bold mb-0" @click="addDevice(device)">{{device.name}}</span>
                </li>
              </ul>
            </div>
				</div>
			</div>
		</div>
	</transition>
</template>

<script>
	export default{
		props: {
			deviceData: {
				type: Object,
				default: function(){ return {} }
			}
		},
		data: function () {
			return {
        searchString:"",
			}
		},
		methods: {
			addDevice(device, tbl_name){
        //device.tbl_name = tbl_name
        const result = {
          object_id: this.$route.params.id,
          parent_id: this.deviceData.id,
          device_id:device.id,
          tbl_name : 'App\\device_alert'
        }
				this.$store.dispatch('ADD_OBJECT_DEVICE', result);
				this.$emit('end-adding')
			},
			cancel () {
				this.$emit('end-adding')
			}
		},
		computed:{
			availDevs: function () {
        let filtered = this.$store.getters.AVAILABLE_ALARMS;
        const SS = this.searchString;
        if(SS)
          filtered = filtered.filter(s => s.name.toLowerCase().includes(SS.toLowerCase()) )
        return filtered;
      },
		},
	}
</script>

<style scoped>
	span{
		cursor: pointer;
	}
.modal-mask {
  background-color: rgba(0, 0, 0, 0.7);
  cursor: pointer;
  display: flex;
  justify-content: center;
  align-items: center;
  position: fixed;
  z-index: 9998;
  top: 0;
  left: 0;
  height: 100%;
  width: 100%;
  transition: opacity 0.3s ease;
}
.modal-mask .modal-container {
  background-color: white;
  border-radius: 2px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.33);
  cursor: default;
  font-family: Helvetica, Arial, sans-serif;
  margin: 40px auto 0;
  padding: 20px 30px;
  transition: all 0.3s ease;
}
.modal-mask .modal-container .modal-content {
  border-radius: 10px;
  color: black;
  margin: 1em;
  padding: 1em;
  width: 800px;
}
.modal-mask .modal-container .modal-content h1 {
  margin: 0;
}
.modal-mask .modal-container .modal-content form {
  display: flex;
  flex-wrap: wrap;
  justify-content: flex-end;
  width: 100%;
}
.modal-mask .modal-container .modal-content form input {
  border: 1px solid rgba(0, 0, 0, 0.5);
  border-radius: 5px;
  font-size: 16px;
  font-weight: bold;
  margin: 1em 0;
  padding: 0.2em 0.5em;
  height: 30px;
  width: 100%;
}
.modal-mask .modal-container .modal-content form button {
  background: none;
  border-radius: 5px;
  cursor: pointer;
  font-size: 16px;
  font-weight: bold;
  height: 30px;
  transition: all 0.3s ease-in-out;
}
.modal-mask .modal-container .modal-content form button.save {
  border: 3px solid #3498db;
  color: #3498db;
  margin-left: 1em;
}
.modal-mask .modal-container .modal-content form button.save:hover {
  background-color: #3498db;
}
.modal-mask .modal-container .modal-content form button.cancel {
  border: 3px solid #f39c12;
  color: #f39c12;
}
.modal-mask .modal-container .modal-content form button.cancel:hover {
  background-color: #f39c12;
}
.modal-mask .modal-container .modal-content form button:hover {
  color: white;
}

.modal-enter, .modal-leave-active {
  opacity: 0;
}

.modal-enter .modal-container, .modal-leave-active .modal-container {
  transform: scale(1.1);
}
</style>