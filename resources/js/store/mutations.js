import Vue from 'vue';

export default{
  TOGGLE_SIDEBAR: state => state.sideBarACtive = !state.sideBarACtive,
  CHANGE_PRELOADER: (state, payload) => {
    if(payload)
      state.showPreloader = payload;
    else
      state.showPreloader = !state.showPreloader;
  },
  SET_DEVICE_SETUP_YEAR(state,payload){
    const obj = state.current_object;
    const dev = obj.devices.find( dev => dev.id == payload.object_device_id);
    dev.setup_year = payload.setup_year;
  },
  ADD_LIMITED_OBJECTS(state,payload){
    state.limitedObjects = payload;
    state.indexLoadres.limitedObjectsLoading = false;
  },
  SET_RAIONS: (state, payload) => {
    state.raions = payload;
  },
  SET_OBJECTS: (state, payload) => {
    state.objects = payload;
    state.indexLoadres.monitoringObjectsLoading = false;
  },
    DELETE_OBJECT: (state, payload) => {
      axios.post(`/api/objects/delete/${payload}`)
      .then(
        response => {
          const idx = state.objects.findIndex(obj => obj.id == payload );
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
      const objData = getters.OBJECT(payload);
      Vue.set(state, 'current_object', objData);
      Vue.set(state.current_object, 'devices', []);
    },
    SET_CURRENT_OBJECT_DEVICES_LOADER:(state) => {
      Vue.set(state.current_object.devices, 'loading', true);
    },
    SET_CURRENT_OBJECT_DEVICES: (state, {payload}) => {
      const idxs = Object.keys(payload);
      if(idxs.length > 0)
        idxs.map( (idx) => {
          const dev = payload[idx];
          dev.isShow = false;
          if(dev.wires && dev.wires.length > 0){
            dev.wires.forEach( wire => wire.isShow = false);
          }
          Vue.set(state.current_object.devices, idx, dev);
        } );
      Vue.set(state.current_object.devices, 'loading', false);
    },
    UPDATE_CURRENT_OBJECT: (state, {getters}) => state.current_object.raion = state.raions.find( obj => obj.id == state.current_object.raion_id),
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
    ADD_NEW_DEVICE:(state, {getters, load}) => {
      const p = {...load};
      state.availabledevices[p.mixins.type].devices.push(p.data);
    },
    UPDATE_DEVICE:(state, {getters, load}) => {
      const p = {...load};
      const idx = getters.AVAILABLE_DEVICE_IDX(p.mixins.type, p.mixins.deviceId);
      state.availabledevices[p.mixins.type].devices[idx] = p.data;
    },
    ADD_OBJECT_DEVICE: (state, payload) => {
      const idx = state.current_object.devices.length;
      payload.isShow = false;
      Vue.set(state.current_object.devices, idx, payload);
    },
    DELETE_OBJECT_DEVICE: (state, payload) => {
      const idx = state.current_object.devices.findIndex(obj => obj && (obj.id == payload) );
      state.current_object.devices.splice(idx, 1);
    },
    DELETE_AVAILABLE_DEVICE: (state, payload) => {
      const p = {...payload};
      const idx = state.availabledevices[p.type].devices.findIndex(obj => obj.id == p.id );
      Vue.delete(state.availabledevices[p.type].devices,idx);
    },
    TOGGLE_DEVICE_SHOW: (state,{payload}) => {
      const idx = state.current_object.devices.findIndex( dev => dev && (dev.id == payload) )
      const currentDevice = state.current_object.devices[idx];
      currentDevice.isShow = !currentDevice.isShow;
    },
    TOGGLE_DEVICE_ISGOOD: (state,payload) => {
      const p = {... payload };
      /*
      TODO: check device.alerts
      */
      const device_idx = state.current_object.devices.findIndex(obj => obj.id == p.odid)
      Vue.set(state.current_object.devices[device_idx], 'is_good', p.is_good);
    },
    ADD_WIRE: (state, payload) => {
      const idx = state.current_object.devices.findIndex(obj => obj.id == payload.odid);
      const wireIdx = state.current_object.devices[idx].wires.length;
      //Vue.set(state.current_object.devices[idx].wires, wireIdx, payload.wire);
      state.current_object.devices[idx].wires.splice(wireIdx, 0, payload.wire);
      Vue.set(state.current_object.devices[idx].wires[wireIdx+1], sensors, []);
    },
    EDIT_WIRE:(state, payload) => {
      const idx = state.current_object.devices.findIndex(obj => obj && (obj.id == payload.object_device_id));
      const wire_idx  = state.current_object.devices[idx].wires.findIndex(el => el.id == payload.id);
      Vue.set(state.current_object.devices[idx].wires, wire_idx, payload);
    },
    DELETE_WIRE: (state, payload) => {
      const idx = state.current_object.devices.findIndex(obj => obj && (obj.id == payload.object_device_id));
      const wire_idx  = state.current_object.devices[idx].wires.findIndex(el => el.id == payload.id);
      Vue.delete(state.current_object.devices[idx].wires, wire_idx);
    },
    TOGGLE_WIRE_SHOW:(state,payload) => {
      const p = {...payload}
      const device_idx = state.current_object.devices.findIndex(obj => obj && (obj.id == p.odid) );
      const currentWire = state.current_object.devices[device_idx].wires[p.wireIdx];
      if(!currentWire.isShow){
        Vue.set(currentWire,'isShow',false);
      }
      currentWire.isShow = !currentWire.isShow;
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
                state.availabledevices.sensors.devices.push(response.data);
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
                const idx2 = state.availabledevices.sensors.devices.findIndex(el => el.id == data.id);
                state.sensors[idx] = data;
                state.availabledevices.sensors[idx] = data;
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
                const idx2 = state.availabledevices.sensors.devices.findIndex(el => el.id == payload.id);
                Vue.delete(state.sensors, idx);
                Vue.delete(state.availabledevices.sensors.devices, idx2);
              }
            );
    },
    ADD_SENSOR_TO_WIRE: (state, {payload,dispatch}) => {
      const p = {...payload};
      const device_idx = state.current_object.devices.findIndex(obj => obj && (obj.id == p.sensorData.deviceId) );
      const wire_idx  = state.current_object.devices[device_idx].wires.findIndex(el => el.id == p.sensorData.wireId);
      const currentWire = state.current_object.devices[device_idx].wires[wire_idx];
      currentWire.sensors.push(p.responseData);
      dispatch('LOAD_UNREGLAMENTED_DEVICES');
    },
    UPDATE_SENSOR_TO_WIRE: (state, payload) => {
      const p = {...payload};
      const device_idx = state.current_object.devices.findIndex(obj => obj && (obj.id == p.sensorData.deviceId) );
      const wire_idx  = state.current_object.devices[device_idx].wires.findIndex(el => el.id == p.sensorData.wireId);
      const currentWire = state.current_object.devices[device_idx].wires[wire_idx];
      const sensor_idx = currentWire.sensors.findIndex(el => el.id == payload.sensorData.id);
      Vue.set(currentWire.sensors, sensor_idx, p.responseData);
    },
    DELETE_SENSOR_ON_WIRE: (state, payload) => {
      const p = {...payload};
      const device_idx = state.current_object.devices.findIndex(obj => obj && (obj.id == p.ObjectDeviceId) );
      const wire_idx  = state.current_object.devices[device_idx].wires.findIndex(el => el.id == p.wireId);
      const currentWire = state.current_object.devices[device_idx].wires[wire_idx];
      const sensor_idx = currentWire.sensors.findIndex(el => el.id == p.sensorId);
      Vue.delete(currentWire.sensors, sensor_idx);
    },
    TOGGLE_MAP: state => {
      state.setMarker = !state.setMarker;
    },
    SET_MAP_ACTIVE_DEVICE: (state, payload) => {
      const p = {...payload};
      const idx = state.current_object.devices.findIndex(obj => obj.id == p.deviceId );
      state.markerObj = state.current_object.devices[idx];
      state.markerObj.type = 'device';
    },
    SET_MAP_ACTIVE_SENSOR: (state, payload) => {
      const p = {...payload};
      const idx = state.current_object.devices.findIndex(obj => obj.id == p.deviceId );
      const wire_idx = state.current_object.devices[idx].wires.findIndex(obj => obj.id == p.wid );
      const sensor_id = state.current_object.devices[idx].wires[wire_idx].sensors.findIndex(obj => obj.id == p.sensor.id );
      state.markerObj = state.current_object.devices[idx].wires[wire_idx].sensors[sensor_id];
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
      const obj = state.current_object.devices[idx];
      state.markerObj.lng = obj.lng = p.coords.lng;
      state.markerObj.lat = obj.lat = p.coords.lat;
      state.markerObj.bti_files_id = obj.bti_files_id = p.bti_plan_id;
    },
    UPDATE_SENSOR_COORDS:(state, payload) => {
      const p = {...payload};
      const mo = state.markerObj;
      const obj = state.current_object.devices[mo.itemsIdx].wires[mo.wireIdx].sensors[mo.sensorIdx]
      state.markerObj.lng = obj.lng = p.coords.lng;
      state.markerObj.lat = obj.lat = p.coords.lat;
      state.markerObj.bti_files_id = obj.bti_files_id = p.bti_plan_id;
    },
    UPDATE_ALERT_COORDS:(state, payload) => {
      const p = {...payload};
      const mo = state.markerObj;
      const obj = state.current_object.devices[mo.itemsIdx].alarms[mo.alarmIdx]
      state.markerObj.lng = obj.lng = p.coords.lng;
      state.markerObj.lat = obj.lat = p.coords.lat;
      state.markerObj.bti_files_id = obj.bti_files_id = p.bti_plan_id;
    },
    UPDATE_OBJECT_DEVICE_PARAMS:(state, payload) => {
      const idx = state.current_object.devices.findIndex( dev => dev && (dev.id == payload.device_id));
      state.current_object.devices[idx].params = payload;
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
    DELETE_REGLAMENT_ELEMENT:(state, {getters, payload})=>{
      const p = {...payload};
      const reglament = getters.REGLAMENT(p.type, p.device_id, p.reglamentId);
      const elemIdx = getters.REGLAMENT_ELEMENT_IDX_IN_REGLAMENT(reglament, p.elementId);
      Vue.delete(reglament.elements,elemIdx);
    },
    ADD_REGLAMENT_ELEMENT(state, {getters, payload}){
      const p = {...payload};
      const reglament = getters.REGLAMENT(p.p.type, p.p.device_id, p.p.device_reglament_id);
      if(!('elements' in reglament))
        reglament.elements = [];
      const idx = reglament.elements.findIndex( el => el.id == p.p.id);
      Vue.delete(reglament.elements, idx);
      reglament.elements.push(p.response);
    },
    UPDATE_REGLAMENT_ELEMENT(state, {getters, payload}){
      const p = {...payload};
      const reglament = getters.REGLAMENT(p.p.type, p.p.device_id, p.p.device_reglament_id);
      const elemIdx = getters.REGLAMENT_ELEMENT_IDX_IN_REGLAMENT(reglament, p.p.elementId);
      reglament.elements[elemIdx] = p.response;
    },
    UPDATE_REGLAMENT(state, {getters, payload}){
      const p = {...payload};
      const dev = getters.AVAILABLE_DEVICE(p.p.type, p.p.device_id);
      const reglament_idx = getters.REGLAMENT(p.p.type, p.p.device_id, p.p.id);
      dev.reglaments[reglament_idx] = p.response;
    },
    DELETE_REGLAMENT(state, {getters, payload}){
      const p = {...payload};
      const dev = getters.AVAILABLE_DEVICE(p.type, p.device_id);
      const idx = getters.REGLAMENT_IDX(p.type, p.device_id, p.reglamentId);
      Vue.delete(dev.reglaments,idx);
    },
    ADD_REGLAMENT(state, {getters, payload}){
      const p = {...payload.p};
      const dev = getters.AVAILABLE_DEVICE(p.type, p.device_id);
      if(!payload.response.elements)
        payload.response.elements=[];
      dev.reglaments.push(payload.response);
    },
    SET_UNREGLAMENTED_DEVICES(state, payload){
      const p = {...payload};
      const tmp = Object.keys(p);
      state.unreglamentedDevices = [];
      tmp.forEach( elem => state.unreglamentedDevices.push(p[elem]));
      state.indexLoadres.unreglamentedDevicesLoading = false;
      state.indexLoadres.unreglamentedObjectsLoading = false;
    },
    SET_USERS(state, payload){
      state.users = payload;
    },
    DELETE_USER(state, payload){
      const userIdx = state.users.findIndex( user => user.id == payload)
      Vue.delete(state.users, userIdx);
    },
    UPDATE_USER(state, {getters, payload}){
      const userIdx = state.users.findIndex( u => u.id == payload.id);
      state.users[userIdx] = payload;
    },
    ADD_USER(state, payload){
      state.users.push(payload);
    },
    ADD_NEW_OBJECT(state, payload){
      state.objects.push(payload);
    },
    SET_DISTRICTS(state, payload){
      state.districts = payload;
    },
    NEW_DISTRICT(state, payload){
      state.districts.push(payload);
    },
    NEW_USER_DISTRICT(state, payload){
      const district = state.districts.find( district => district.id == payload.districtId );
      district.users.push(payload.user);
    },
    DELETE_DISTRICT_USER(state, payload){
      const district = state.districts.find( district => district.id == payload.districtId );
      const userIdx = district.users.findIndex( user => user.id == payload.userId );
      district.users.splice(userIdx, 1);
    },
    DELETE_DISTRICT_OBJECT(state, payload){
      const district = state.districts.find( district => district.id == payload.districtId );
      const objectIdx = district.objects.findIndex( object => object.id == payload.objectId );
      district.objects.splice(objectIdx, 1);
    },
    CHANGE_DISTRICT_NAME(state, payload){
      const district = state.districts.find( district => district.id == payload.id );
      district.name = payload.name;
    },
    DELETE_DISTRICT(state, payload){
      const districtIdx = state.districts.findIndex( district => district.id == payload );
      state.districts.splice(districtIdx, 1);
    },
    SET_OBJECT_DISTRICT(state, payload){
      const district = state.districts.find( district => district.id == payload.districtId );
      district.objects.push(payload.object);
    },
}