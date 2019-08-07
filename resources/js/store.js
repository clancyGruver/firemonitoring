import Vue from 'vue';
import Vuex from 'vuex';

Vue.use(Vuex);

export const store = new Vuex.Store({

  state: {
    raions: {},
    objects: {},
    current_object: {},
    user: null,
    object_id: null,
    devices: {},
    availabledevices: [],
    sensors: [],
    setMarker: false,
    markerObj: {},
  },

  mutations: {
    SET_RAIONS: (state, payload) => {
      state.raions = payload;
    },
    SET_OBJECTS: (state, payload) => {
      state.objects = payload;
    },
    DELETE_OBJECT: (state, payload) => {
      const p = {...payload}
      axios.post(`/api/objects/delete/${p.id}`)
      .then(
        response => {
          const idx = state.objects.findIndex(obj => obj.id == p.id );
          Vue.delete(state.objects,idx);
        }
      );
    },
    SET_OBJECT_LL: (state, {p, getters}) => {
      const idx = getters.FIND_CURRENT_OBJECT_INDEX;
      state.objects[idx].lat = p.lat;
      state.objects[idx].lng = p.lng;
    },
    SET_CURRENT_OBJECT: (state, {payload, getters}) => {
      state.object_id = payload;
      state.current_object = getters.OBJECT(payload);
    },

    MEDIAFILE_UPLOAD:(state, payload) => {
      let fd = new FormData();
      fd.append('object_id', state.object_id)
      fd.append('image', payload.image)
      fd.append('description', payload.description)
      let url = '';
      if(payload.type == 'media')
        url = '/api/objects/fileUpload';
      else if(payload.type == 'bti_files')
        url = '/api/objects/btiUpload';
      const config = {
        headers: { 'content-type': 'multipart/form-data' }
      }
      axios.post(url, fd, config).then(response => {
        if(payload.type == 'media')
          state.current_object.mediafiles.push(response.data);
        else if(payload.type == 'bti_files')
          state.current_object.btifiles.push(response.data);
      });
    },

    MEDIAFILE_DELETE:(state, payload) => {
      const p = {...payload};
      const url = `/api/objects/${p.type == 'media' ? 'fileDelete' : 'btiDelete'}/${p.id}`;
      console.log(p,url);
      let idx = -1;
      axios.post(url).then(response => {
        if(p.type == 'media'){
          idx = state.current_object.mediafiles.findIndex((item) => item.id == p.id)
          Vue.delete(state.current_object.mediafiles,idx);
        }
        else if(p.type == 'bti_files'){
          idx = state.current_object.btifiles.findIndex((item) => item.id == p.id)
          Vue.delete(state.current_object.btifiles,idx);
        }
      });
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
    TOGGLE_DEVICE_ISGOOD: (state,payload) => {
      const p = {... payload };
      const device_idx = state.devices[p.typeIdx].items.findIndex(obj => obj.id == p.deviceId)
      const is_good = !state.devices[p.typeIdx].items[device_idx].is_good;
      axios.post(`/api/objectdevice/isgood/${p.deviceId}`,{is_good})
      .then(
        response => {
          Vue.set(state.devices[p.typeIdx].items[device_idx], 'is_good', is_good);
        }
      );
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
    SET_SENSORS: (state, payload) => {
      state.sensors = payload;
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
    SET_MAP_ACTIVE_ALARM:(state, payload) => {
      const p = {...payload};
      const idx = state.devices[p.typeIdx].items.findIndex(obj => obj.id == p.deviceId );
      const alarmIdx = state.devices[p.typeIdx].items[idx].alarms.findIndex(obj => obj.id == p.alertId );
      state.markerObj = state.devices[p.typeIdx].items[idx].alarms[alarmIdx];
      state.markerObj.typeIdx = p.typeIdx;
      state.markerObj.itemsIdx = idx;
      state.markerObj.alarmIdx = alarmIdx;
      state.markerObj.type = 'alarm';
    },
    UPDATE_DEVICE_COORDS:(state, {getters, payload}) => {
      const p = {...payload};
      const idx = getters.FIND_DEVICE_INDEX(p.tbl_name, p.id);
      const obj = state.devices[p.tbl_name].items[idx];
      state.markerObj.lng = obj.lng = p.coords.lng;
      state.markerObj.lat = obj.lat = p.coords.lat;
      state.markerObj.bti_files_id = obj.bti_files_id = p.bti_plan_id;
    },
    UPDATE_SENSOR_COORDS:(state, payload) => {
      const p = {...payload};
      const mo = state.markerObj;
      const obj = state.devices[mo.typeIdx].items[mo.itemsIdx].wires[mo.wireIdx].sensors[mo.sensorIdx]
      state.markerObj.lng = obj.lng = p.coords.lng;
      state.markerObj.lat = obj.lat = p.coords.lat;
      state.markerObj.bti_files_id = obj.bti_files_id = p.bti_plan_id;
    },
    UPDATE_ALERT_COORDS:(state, payload) => {
      const p = {...payload};
      const mo = state.markerObj;
      const obj = state.devices[mo.typeIdx].items[mo.itemsIdx].alarms[mo.alarmIdx]
      state.markerObj.lng = obj.lng = p.coords.lng;
      state.markerObj.lat = obj.lat = p.coords.lat;
      state.markerObj.bti_files_id = obj.bti_files_id = p.bti_plan_id;
    },
    UPDATE_ANTENNA:(state, payload) => {
      const p = {...payload};
      const id = p.id || '';
      axios.post(`/api/antennas/storeParams/${id}`,p)
       .then(
          response => {
            const device_idx = state.devices[p.tbl_name].items.findIndex( device => device.id == p.device_id);
            state.devices[p.tbl_name].items[device_idx].params = p;
          }
        )
    },
    UPDATE_RSPI:(state, payload) => {
      const p = {...payload};
      axios.post(`/api/rspi/storeParams`,p)
       .then(
          response => {
            const device_idx = state.devices[p.tbl_name].items.findIndex( device => device.id == p.device_id);
            state.devices[p.tbl_name].items[device_idx].params = p;
          }
        )
    },
    ADD_ALARM:(state, payload) => {
      const p = {...payload};
      const tbl_name = 'App\\device_system_voice_alert';
      axios.post(`/api/sys_alert_dev/store`,p)
       .then(
          response => {
            const device_idx = state.devices[tbl_name].items.findIndex( device => device.id == p.device_system_voice_alerts_id);
            state.devices[tbl_name].items[device_idx].alarms = response.data;
          }
        )
    },
    CHANGE_LIMITATION:(state, {getters, payload}) => {
      const p = {...payload};
      const limitation = getters.LIMITATION_BY_ID(p.type, p.id);
      limitation.text = p.text;
    },
    ADD_LIMITATION:(state, {getters, payload}) => {
      const p = {...payload};
      const avail_device = getters.AVAILABLE_DEVICE(p.type, p.device_id)
      const limitation_id = avail_device.limitations.findIndex( obj => obj.id == p.fake_id);
      avail_device.limitations[limitation_id] = p;
    },
    REMOVE_LIMITATION:(state, {getters, payload}) => {
      const p = {...payload};
      const avail_device = getters.AVAILABLE_DEVICE(p.type, p.device_id)
      const limitation_id = avail_device.limitations.findIndex( obj => obj.id == p.id);
      Vue.delete(avail_device.limitations,limitation_id);
    },
  },

  getters: {
    RAIONS: state => state.raions,
    ALERT_DEVICE_BY_NAME: state => name => state.availabledevices.voice_alerts.devices.find( el => el.name == name),
	  DEVICES: state => state.devices,
    AVAILABLE_DEVICES: state => state.availabledevices,
    AVAILABLE_DEVICE: state => (type, id) => state.availabledevices[type].devices.find(obj => obj.id == id),
    AVAILABLE_DEVICE_MODEL: state => type => state.availabledevices[type].tbl_name,
    FIND_DEVICE_INDEX: state => (tbl_name, id) => state.devices[tbl_name].items.findIndex(obj => obj.id == id ),
    AVAILABLE_ALARMS: state => 'alerts' in state.availabledevices ? state.availabledevices.alerts.devices.filter( device => ['sound','voice'].indexOf(device.type) > -1 ) : [],
    ALL_SENSORS: state => state.sensors,
    SENSOR: state => id => state.sensors.find( el => el.id == id ),
    MARKER_SETTABLE: state => state.setMarker,
    MARKER_OBJECT: state => state.markerObj,
    OBJECTS: state => state.objects,
    OBJECT: state => id => state.objects.find( el => el.id == id),
    FIND_CURRENT_OBJECT_INDEX: state => state.objects.findIndex(obj => obj.id == state.object_id ),
    CURRENT_OBJECT: state => state.current_object,
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
              deviceType: deviceType,
              name: device.name,
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
                          deviceType: 'sensor',
                          name: `Извещатель ${device.name}/${wire.description}/${sensor.name}`,
                        })
                      }
                    )
                  }
                }
              )
            if( device.alarms && device.alarms.length > 0 )
              device.alarms.map(
                alarm => {
                  if(!markers[alarm.bti_files_id])
                    markers[alarm.bti_files_id] = [];
                  markers[alarm.bti_files_id].push({
                    lng: alarm.lng,
                    lat: alarm.lat,
                    icon: alarm.icon,
                    alarmId: alarm.id,
                    deviceType: 'alarm',
                    name: alarm.name,
                  })
                }
              )
          }
        )
      }
      return markers;
    },
    LIMITATION_BY_ID: state => (type, id) => {
      state.availabledevices[type].devices.map(
        device => device.limitations.find( obj => obj.id == id )
      )
    },
    LIMITATION_ID: state => (type, id) => {
      state.availabledevices[type].devices.map(
        device => device.limitations.findIndex( obj => obj.id == id )
      )
    },
	},

  actions:{
    setCurrentObjectAction({commit, getters}, payload){
      commit('SET_CURRENT_OBJECT', {payload, getters})
    },
    async LOAD_OBJECTS({commit}) {
      await axios.post(`/api/objects`)
        .then( response => commit('SET_OBJECTS', response.data));
    },
    async LOAD_RAIONS({commit}) {
      await axios.post(`/api/raions`)
        .then(response => commit('SET_RAIONS', response.data));
    },
    async LOAD_SENSORS({commit}) {
      await axios.post('/api/sensors/getall')
        .then( response => commit('SET_SENSORS', response.data));
    },
    async LOAD_AVAILABLE_DEVICES({commit}){
      await axios
        .post(`/api/devices/getbyclass`)
        .then( response => commit('SET_AVAILABLE_DEVICES', response.data));
    },
    async CHANGE_OBJECT_LL({state, commit, getters}, payload){
      const p = {...payload}
      await axios.post(`/api/objects/storeCoords/${state.object_id}`,p)
        .then(response => commit('SET_OBJECT_LL', {p,getters}));
    },
    async OBJECT_UPDATE({state}){
      await axios.post(`/api/objects/update/${state.current_object.id}`,state.current_object);
    },
    async SET_DEVICE_COORDS({commit, state, getters}, payload){
      const p = {...payload};
      await axios.post(`/api/objectdevice/storeCoords/${state.markerObj.id}`, {
        lat: p.coords.lat,
        lng: p.coords.lng,
        bti_files_id: p.bti_files_id,
      })
        .then( response => commit('UPDATE_DEVICE_COORDS', {payload: {...p, ...response.data}, getters}))
    },
    async SET_SENSOR_COORDS({commit, state}, payload){
      const p = {...payload};
      await axios.post(`/api/sensorwire/storeCoords/${state.markerObj.id}`, {
        lat: p.coords.lat,
        lng: p.coords.lng,
        bti_files_id: p.bti_plan_id,
      })
        .then(response => commit('UPDATE_SENSOR_COORDS', {...p, ...response.data}) );
    },
    async SET_ALERT_COORDS({commit, state}, payload){
      const p = {...payload};
      axios.post(`/api/sys_alert_dev/storeCoords/${state.markerObj.dsvad}`,{
        lat: p.coords.lat,
        lng: p.coords.lng,
        bti_files_id: p.bti_files_id,
      })
       .then(response => commit('UPDATE_ALERT_COORDS', {...p, ...response.data}))
    },
    async UPDATE_LIMITATION({commit, getters}, payload){
      const p = {...payload};
      axios.post(`/api/limitations/update/${p.id}`,{
        text: p.text
      })
       .then(response => commit('CHANGE_LIMITATION', {payload: p, getters}))
    },
    async INSERT_LIMITATION({commit, getters}, payload){
      const p = {...payload};
      axios.post(`/api/limitations/insert`,p)
       .then(response => commit('ADD_LIMITATION', {payload: {
          ...response.data,
          fake_id: p.id,
          type: p.type,
          device_id: p.device_id
        }, getters}))
    },
    async DELETE_LIMITATION({commit, getters}, payload){
      const p = {...payload}
      console.log(p);
      axios.post(`/api/limitations/delete/${p.id}`)
      .then(response => commit('REMOVE_LIMITATION', {payload, getters}));
    },
  }
});