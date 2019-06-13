import Vue from 'vue';
import Vuex from 'vuex';

Vue.use(Vuex);

export const store = new Vuex.Store({
  
  state: {
    user: null,
    object_id: null,
    devices: [],
    availabledevices: [],
    sensors: [],
  },

  mutations: {
    SET_OBJECT_ID: (state, payload) => {
      state.object_id = payload;
    },
    SET_USER: (state, payload) => {
      state.user = payload;
    },
    SET_DEVICES: (state, payload) => {
      state.devices = payload;
    },
    SET_AVAILABLE_DEVICES: (state, payload) => {
      state.availabledevices = payload;
    },
    ADD_DEVICE: (state, payload) => {
      axios.post('/api/objectdevice/store',{
        user_id: state.user.id,
        object_id: state.object_id,
        device_id: payload.id
      })
      .then(
        response => state.devices.push({
          id: response.id,
          name: payload.name,
          wires: [],
          wires_count: payload.wires_count,
        })
      );      
    },
    DELETE_DEVICE: (state, payload) => {
      axios.post(`/api/objectdevice/delete/${payload}`)
      .then(
        response => {
          const idx = state.devices.findIndex(obj => obj.id == payload );  
          Vue.delete(state.devices,idx)
        }
      );
    },
    ADD_WIRE: (state, payload) => {
      const idx = state.devices.findIndex(obj => obj.id == payload.odid );            
      axios.post('/api/wire/store',{
        user_id: state.user.id,
        object_device_id: payload.odid,
        wire_data: payload.wire
      })
      .then(
        response => {
          payload.wire.id = response.data.id;
          payload.wire.sensors = [];
          state.devices[idx].wires.push(
            payload.wire
          );
        }
          
      );
    },
    EDIT_WIRE:(state, payload) => {
      payload.user_id = state.user.id;
      axios.post(`/api/wire/update/${payload.id}`,payload)
      .then(
        response => {
          const device_idx = state.devices.findIndex(obj => obj.id == payload.object_device_id );
          const wire_idx  = state.devices[device_idx].wires.findIndex(el => el.id == payload.id);
          Vue.set(state.devices[device_idx].wires, wire_idx, payload);
        }
          
      );
    },
    DELETE_WIRE: (state, payload) => {
      axios.post(`/api/wire/delete/${payload}`)
      .then(
        response => {
          const device_idx = state.devices.findIndex(obj => obj.id == payload.object_device_id );
          const wire_idx  = state.devices[device_idx].wires.findIndex(el => el.id == payload.id);
          Vue.delete(state.devices[idx].wires, wire_idx)
        }
      );
    },
    FILL_SENSORS: (state) => {
      axios.post('/api/sensors/getall',{})
      .then(
        response => {
          state.sensors = response.data;
        }          
      );
    },
    ADD_SENSOR: (state, payload) => {
      axios.post('/api/sensors/store',{
              user_id: state.user.id,
              sensor_data: payload
            })
            .then(
              response => {
                state.sensors.push(response.data);
              }          
            );
    },
    UPDATE_SENSOR: (state, payload) => {
      axios.post('/api/sensors/update',{
              user_id: state.user.id,
              sensor_data: payload
            })
            .then(
              response => {
                const data = response.data;
                const idx = state.sensors.findIndex(el => el.id == data.id);
                state.sensors[idx] = data;
              }          
            );
    },
    DELETE_SENSOR: (state, payload) => {
      axios.post('/api/sensors/delete',{
              user_id: state.user.id,
              sensor_id: payload.id
            })
            .then(
              response => {
                const idx = state.sensors.findIndex(el => el.id == payload.id);
                Vue.delete(state.sensors, idx);
              }          
            );
    },
    ADD_SENSOR_TO_WIRE: (state, payload) => {
      axios.post('/api/sensorwire/add',{
        payload,
        user_id: state.user.id,
      })
      .then(
        resonse => {
          const device_idx = state.devices.findIndex(el => el.id == payload.sensorData.deviceId);
          const wire_idx  = state.devices[device_idx].wires.findIndex(el => el.id == payload.sensorData.wire_id);
          state.devices[device_idx].wires[wire_idx].sensors.push(resonse.data);
        }
      )
    },
    UPDATE_SENSOR_TO_WIRE: (state, payload) => {
      axios.post('/api/sensorwire/update',{
        payload,
        user_id: state.user.id,
      })
      .then(
        resonse => {
          const device_idx = state.devices.findIndex(el => el.id == payload.sensorData.deviceId);
          const wire_idx  = state.devices[device_idx].wires.findIndex(el => el.id == payload.sensorData.wire_id);
          const sensor_idx = state.devices[device_idx].wires[wire_idx].sensors.findIndex(el => el.id == payload.sensorData.id);
          Vue.set(state.devices[device_idx].wires[wire_idx].sensors, sensor_idx, resonse.data);
        }
      )
    }
  },

  getters: {
	  DEVICES: state => state.devices,
    AVAILABLE_DEVICES: state => state.availabledevices,
    ALL_SENSORS: state => state.sensors,
    SENSOR: (state, getters) => (id) => state.sensors.find( el => el.id == id ),
	}
});   