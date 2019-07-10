import Vue from 'vue';
import Vuex from 'vuex';

Vue.use(Vuex);

export const store = new Vuex.Store({

  state: {
    user: null,
    object_id: null,
    devices: {},
    availabledevices: [],
    sensors: [],
    setMarker: false,
    markerObj: {},
    bti_plans: {
                status: false,
                items: []
              },
  },

  mutations: {
    SET_OBJECT_ID: (state, payload) => {
      state.object_id = payload;
    },
    SET_USER: (state, payload) => {
      state.user = {...payload};
    },
    SET_DEVICES: (state, payload) => {
      state.devices = {...payload};
    },
    SET_AVAILABLE_DEVICES: (state, payload) => {
      state.availabledevices = payload;
    },
    ADD_DEVICE: (state, payload) => {
      const p = {...payload}
      axios.post('/api/objectdevice/store',{
        user_id: state.user.id,
        object_id: state.object_id,
        device_id: p.id,
        tbl_name: p.tbl_name,
      })
      .then(
        response => {
          state.devices[p.tbl_name].items.push({
            id: response.id,
            name: p.name,
            isShow:true,
            tbl_name: p.tbl_name,
            wires: [],
            wires_count: p.wires_count,
          })
        }
      );
    },
    DELETE_DEVICE: (state, payload) => {
      const p = {...payload}
      axios.post(`/api/objectdevice/delete/${p.deviceId}`)
      .then(
        response => {
          const idx = state.devices[p.typeIdx].items.findIndex(obj => obj.id == p.deviceId );
          Vue.delete(state.devices[p.typeIdx].items,idx);
        }
      );
    },
    TOGGLE_DEVICE_SHOW: (state,payload) => {
      const p = {... payload };
      const isShow = !state.devices[p.typeIdx].items[p.idx].isShow;
      Vue.set(state.devices[p.typeIdx].items[p.idx], 'isShow', isShow);
      //state.devices[payload.typeIdx].items[payload.idx].isShow = !state.devices[payload.typeIdx].items[payload.idx].isShow;
    },
    ADD_WIRE: (state, payload) => {
      const idx = state.devices[payload.typeIdx].items.findIndex(obj => obj.id == payload.odid );
      axios.post('/api/wire/store',{
        user_id: state.user.id,
        object_device_id: payload.odid,
        wire_data: payload.wire
      })
      .then(
        response => {
          payload.wire.id = response.data.id;
          payload.wire.sensors = [];
          payload.wire.isShow = true;
          state.devices[payload.typeIdx].items[idx].wires.push(
            payload.wire
          );
        }
      );
    },
    EDIT_WIRE:(state, payload) => {
      const p = {...payload};
      p.wire.user_id = state.user.id;
      axios.post(`/api/wire/update/${p.wire.id}`,p.wire)
      .then(
        response => {
          const device_idx = state.devices[p.typeIdx].items.findIndex(obj => obj.id == p.wire.object_device_id );
          const wire_idx  = state.devices[p.typeIdx].items[device_idx].wires.findIndex(el => el.id == p.wire.id);
          Vue.set(state.devices[p.typeIdx].items[device_idx].wires, wire_idx, p.wire);
        }
      );
    },
    DELETE_WIRE: (state, payload) => {
      const p = {...payload};
      axios.post(`/api/wire/delete/${p.id}`)
      .then(
        response => {
          const device_idx = state.devices[p.typeIdx].items.findIndex(obj => obj.id == p.object_device_id );
          const wire_idx  = state.devices[p.typeIdx].items[device_idx].wires.findIndex(el => el.id == p.id);
          Vue.delete(state.devices[p.typeIdx].items[device_idx].wires, wire_idx)
        }
      );
    },
    TOGGLE_WIRE_SHOW:(state,payload) => {
      const p = {...payload}
      const device_idx = state.devices[p.tid].items.findIndex(obj => obj.id == p.odid );
      state.devices[p.tid].items[device_idx].wires[p.wireIdx].isShow = !state.devices[p.tid].items[device_idx].wires[p.wireIdx].isShow;
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
          const p = {...payload};
          const device_idx = state.devices[p.typeIdx].items.findIndex(el => el.id == p.ObjectDeviceId);
          const wire_idx  = state.devices[p.typeIdx].items[device_idx].wires.findIndex(el => el.id == p.wireId);
          state.devices[p.typeIdx].items[device_idx].wires[wire_idx].sensors.push(resonse.data);
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
          const p = {...payload};
          const device_idx = state.devices[p.typeIdx].items.findIndex(el => el.id == p.ObjectDeviceId);
          const wire_idx  = state.devices[p.typeIdx].items[device_idx].wires.findIndex(el => el.id == p.wireId);
          const sensor_idx = state.devices[p.typeIdx].items[device_idx].wires[wire_idx].sensors.findIndex(el => el.id == payload.sensorData.id);
          Vue.set(state.devices[p.typeIdx].items[device_idx].wires[wire_idx].sensors, sensor_idx, resonse.data);
        }
      )
    },
    DELETE_SENSOR_ON_WIRE: (state, payload) => {
      axios.post(`/api/sensorwire/delete/${payload.sensorId}`)
            .then(
              response => {
                const p = {...payload};
                const device_idx = state.devices[p.typeIdx].items.findIndex(el => el.id == p.ObjectDeviceId);
                const wire_idx  = state.devices[p.typeIdx].items[device_idx].wires.findIndex(el => el.id == p.wireId);
                const sensor_idx = state.devices[p.typeIdx].items[device_idx].wires[wire_idx].sensors.findIndex(el => el.id == p.sensorId);
                Vue.delete(state.devices[p.typeIdx].items[device_idx].wires[wire_idx].sensors, sensor_idx);
              }
            );
    },
    SET_BTIPLANS: (state, payload) => {
      axios.post(`/api/objects/btiFiles/${state.object_id}`)
           .then(
              response => state.bti_plans = {
                status: true,
                items: response.data
              }
            )
    },
    TOGGLE_MAP: state => {
      state.setMarker = !state.setMarker;
    },
    SET_MAP_ACTIVE_DEVICE: (state, payload) => {
      const p = {...payload};
      const idx = state.devices[p.typeIdx].items.findIndex(obj => obj.id == p.deviceId );
      state.markerObj = state.devices[p.typeIdx].items[idx];
      state.markerObj.type = 'device';
    },
    SET_MAP_ACTIVE_SENSOR: (state, payload) => {
      const p = {...payload};
      const idx = state.devices[p.typeIdx].items.findIndex(obj => obj.id == p.deviceId );
      const wire_idx = state.devices[p.typeIdx].items[idx].wires.findIndex(obj => obj.id == p.wid );
      const sensor_id = state.devices[p.typeIdx].items[idx].wires[wire_idx].sensors.findIndex(obj => obj.id == p.sensor.id );
      state.markerObj = state.devices[p.typeIdx].items[idx].wires[wire_idx].sensors[sensor_id];
      state.markerObj.typeIdx = p.typeIdx;
      state.markerObj.itemsIdx = idx;
      state.markerObj.wireIdx = wire_idx;
      state.markerObj.sensorIdx = sensor_id;
      state.markerObj.type = 'sensor';
    },
    SET_DEVICE_COORDS:(state, payload) => {
      const p = {...payload};
      state.markerObj.lng = p.coords.lng;
      state.markerObj.lat = p.coords.lat;
      state.markerObj.bti_files_id = p.bti_plan_id;
      axios.post(`/api/objectdevice/storeCoords/${state.markerObj.id}`,state.markerObj)
       .then(
          response => {
            const rd = response.data;
            const idx = state.devices[rd.tbl_name].items.findIndex(obj => obj.id == rd.id );
            const obj = state.devices[rd.tbl_name].items[idx];
            obj.lat = rd.lat;
            obj.lng = rd.lng;
            obj.bti_files_id = rd.bti_files_id;
          }
        )
    },
    SET_SENSOR_COORDS:(state, payload) => {
      const p = {...payload};
      state.markerObj.lng = p.coords.lng;
      state.markerObj.lat = p.coords.lat;
      state.markerObj.bti_files_id = p.bti_plan_id;
      axios.post(`/api/sensorwire/storeCoords/${state.markerObj.id}`,state.markerObj)
       .then(
          response => {
            const rd = response.data;
            const mo = state.markerObj;
            const obj = state.devices[mo.typeIdx].items[mo.itemsIdx].wires[mo.wireIdx].sensors[mo.sensorIdx]
            obj.lat = rd.lat;
            obj.lng = rd.lng;
            obj.bti_files_id = rd.bti_files_id;
          }
        )
    },
    UPDATE_ANTENNA:(state, payload) => {
      const p = {...payload};
      const id = p.id || '';
      axios.post(`/api/antenna/storeParams/${id}`,p)
       .then(
          response => {
            const device_idx = state.devices[p.tbl_name].items.findIndex( device => device.id == p.device_id);
            state.devices[p.tbl_name].items[device_idx].params = p;
          }
        )
    },
    ADD_ALARM:(state, payload) => {
      const p = {...payload};
      console.log(p);
      /*const id = p.id || '';
      axios.post(`/api/antenna/storeParams/${id}`,p)
       .then(
          response => {
            const device_idx = state.devices[p.tbl_name].items.findIndex( device => device.id == p.device_id);
            state.devices[p.tbl_name].items[device_idx].params = p;
          }
        )*/
    },
  },

  getters: {
	  DEVICES: state => state.devices,
    AVAILABLE_DEVICES: state => state.availabledevices,
    AVAILABLE_ALARMS: state => 'alerts' in state.availabledevices ? state.availabledevices.alerts.devices.filter( device => ['sound','voice'].indexOf(device.type) > -1 ) : [],
    ALL_SENSORS: state => state.sensors,
    SENSOR: (state, getters) => (id) => state.sensors.find( el => el.id == id ),
    BTI_PLANS: state => state.bti_plans,
    MARKER_SETTABLE: state => state.setMarker,
    MARKER_OBJECT: state => state.markerObj,
    DEVICE_MARKERS: state => {
      const markers = [];
      for(let deviceType in state.devices){
        state.devices[deviceType].items.map(
          device => {
            if(!markers[device.bti_files_id])
              markers[device.bti_files_id] = [];
            markers[device.bti_files_id].push({
              lng: device.lng,
              lat: device.lat,
              icon: device.icon,
              deviceId: device.id,
              deviceType: deviceType
            })
            if( device.wires && device.wires.length > 0 )
              device.wires.map(
                wire => {
                  if( wire.sensors.length > 0 ){
                    wire.sensors.map(
                      sensor => {
                        if(!markers[sensor.bti_files_id])
                          markers[sensor.bti_files_id] = [];
                        markers[sensor.bti_files_id].push({
                          lng: sensor.lng,
                          lat: sensor.lat,
                          icon: sensor.icon,
                          sensorId: sensor.id,
                          deviceType: 'sensor'
                        })
                      }
                    )
                  }
                }
              )
          }
        )
      }
      return markers;
    },
	}
});