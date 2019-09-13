export default{
    USERS: state => state.users,
    USER_BY_ID: state => id => state.users.find( user => user.id == id),
    TECHNICS_USERS: state => state.users.filter(user => user.is_admin == 0),
    CURRENT_USER: state => state.user,
    PRELOADER: state => state.showPreloader,
    LIMITED_OBJECTS: state => state.limitedObjects,
    RAIONS: state => (typeof [] === typeof state.raions) && (state.raions.length > 0) ? state.raions.filter( raion => !raion.deleted_at) : [],
    ALL_RAIONS: state => state.raions,
    RAION_BY_ID: state => id => state.raions.find(raion => raion.id == id),
    ALERT_DEVICE_BY_NAME: state => name => state.availabledevices.voice_alerts.devices.find( el => el.name == name),
    DEVICES: state => state.devices,
    AVAILABLE_DEVICES: state => state.availabledevices,
    AVAILABLE_DEVICE: state => (type, id) => state.availabledevices[type].devices.find(obj => obj.id == id),
    AVAILABLE_DEVICE_IDX: state => (type, id) => state.availabledevices[type].devices.findIndex(obj => obj.id == id),
    AVAILABLE_DEVICE_MODEL: state => type => state.availabledevices[type].tbl_name,
    FIND_DEVICE_INDEX: state => (tbl_name, id) => state.devices[tbl_name].items.findIndex(obj => obj.id == id ),
    AVAILABLE_ALARMS: state => 'alerts' in state.availabledevices ? state.availabledevices.alerts.devices.filter( device => ['sound','voice'].indexOf(device.type) > -1 ) : [],
    ALL_SENSORS: state => state.availabledevices.sensors ? state.availabledevices.sensors.devices : [],
    SENSOR: state => id => state.sensors.find( el => el.id == id ),
    SENSOR_NAME: state => id => {
      const sensor = state.sensors.find( el => el.id == id );
      return sensor ? sensor.name : '';
    },
    MARKER_SETTABLE: state => state.setMarker,
    MARKER_OBJECT: state => state.markerObj,
    LIMITED_OBJECTS_BY_TYPE: (state,getters) => type => {
      let ids = [];
      if(type=='all' || state.objects.length == 0)
        return state.objects;
      else if(['sp5','devices', 'sensors'].includes(type))
        ids = state.limitedObjects[type];
      else if(type == 'unreglamented')
        ids = getters.UNREGLAMENTED_DEVICES_OBJECTS;
      const res = state.objects.filter( obj => ids.includes(obj.id));
      return res;
    },
    OBJECTS: state => state.objects,
    OBJECT: state => id => state.objects.find( el => el.id == id),
    OBJECT_IDX_BY_ID: state => id => state.objects.findIndex( el => el.id == id),
    FIND_CURRENT_OBJECT_INDEX: state => state.objects.length > 0 ? state.objects.findIndex(obj => obj.id == state.object_id ) : false,
    CURRENT_OBJECT: state => state.current_object,
    DEVICE_MARKERS: (state, getters) => {
      const markers = [];
      const devices = getters.DEVICE_TREE;
      for(let deviceType in devices){
        devices[deviceType].items.map(
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
    REGLAMENT: (state, getters) => (type, device_id, reglamentId) => {
      const avail_device = getters.AVAILABLE_DEVICE(type, device_id);
      const reglament = avail_device.reglaments.find( reg => reg.id == reglamentId );
      return reglament;
    },
    REGLAMENT_IDX: (state, getters) => (type, device_id, reglamentId) => {
      const avail_device = getters.AVAILABLE_DEVICE(type, device_id);
      const reglament_idx = avail_device.reglaments.findIndex( reg => reg.id == reglamentId );
      return reglament_idx;
    },
    REGLAMENT_ELEMENT_IDX_IN_REGLAMENT: (state, getters) => (reglament, elementId) => {
      const elemIdx = reglament.elements.findIndex( elem => elem.id == elementId);
      return elemIdx;
    },
    UNREGLAMENTED_DEVICES: state => {
      const devices = [];
      if(state.unreglamentedDevices.length > 0)
        state.unreglamentedDevices.forEach( dev => {
          if(!devices.includes(dev.device_id))
            devices.push(dev.device_id)
        });
      return devices;
    },
    UNREGLAMENTED_DEVICES_OBJECTS: (state, getters) => {
      const objects = [];
      if(state.unreglamentedDevices.length > 0)
        state.unreglamentedDevices.forEach( dev => {
          if(dev.object){
            if(!objects.includes(dev.object.object_id))
              objects.push(dev.object.object_id)
          }
        });
      return objects;
    },
    SENSORS_ON_WIRE: state => (odId,wireId) => {
      const deviceIdx = state.current_object.devices.findIndex(obj => obj && (obj.id == odId) );
      const wireIdx  = state.current_object.devices[deviceIdx].wires.findIndex(el => el.id == wireId);
      return state.current_object.devices[deviceIdx].wires[wireIdx].sensors || [];
    },
    SENSOR_ON_WIRE_BY_ID: (state, getters) => (odId,wireId, sensorId) => {
      const device = state.current_object.devices.find(obj => obj && (obj.id == odId) );
      const wire  = device.wires.find(el => el.id == wireId);
      const sensor = wire.sensors.find( sensor => sensor.id == sensorId);
      sensor.fullName = `${device.devicable.name}/${wire.description}/${sensor.name}`
      return sensor || {};
    },
    UNREGLAMENTED_SENSORS_ON_WIRE: state => (odId,wireId) => {
      if(state.unreglamentedDevices.length > 0){
        const deviceIdx = state.current_object.devices.findIndex(obj => obj && (obj.id == odId) );
        const wireIdx  = state.current_object.devices[deviceIdx].wires.findIndex(el => el.id == wireId);
        const wireSensorsIds = state.current_object.devices[deviceIdx].wires[wireIdx].sensors.map( sensor => sensor.id);
        const unreglamentedSensors = state.unreglamentedDevices.filter( dev => dev.tbl_name == 'App/Sensor' && wireSensorsIds.includes(dev.device_id));
        return unreglamentedSensors;
      }
      return [];
    },
    DEVICE_TREE: (state) => {
      const tree = {};
      if(!state.current_object.devices)
        return tree;
      state.current_object.devices.map(val => {
        const wireEl = val.wires ? val.wires : [];
        const alarmEl = [];
        if('alerts' in val){
          val.alerts.forEach( el => {
            const curEl = el;
            curEl.dsvad = el.id;
            curEl.parent_device_id = val.id;
            curEl.icon = el.alert_device.icon;
            curEl.name = el.alert_device.name;
            curEl.type = el.alert_device.type;
            curEl.power = el.alert_device.power;
            alarmEl.push( curEl );
          });
        }
        if(!(val.tbl_name in tree)){
          tree[val.tbl_name] = {
            name: val.type,
            items: [],
          };
        }
        const treeEl = {
          name: val.devicable.name,
          tbl_name: val.tbl_name,
          isShow: val.isShow,
          is_good: val.is_good,
          id: val.id,
          alarms:alarmEl,
                wires: wireEl,
                wires_count: val.devicable.wires_count,
                lng: val.lng,
                lat: val.lat,
                icon: val.devicable.icon || 'default',
                bti_files_id: val.bti_files_id,
                params: val.params || {},
        };
        tree[val.tbl_name].items.push(treeEl);
      })
      return tree;
    },
    OBJECT_DEVICE_WIRE_BY_ID:state => (odid, wireId) => {
      const deviceIdx = state.current_object.devices.findIndex(obj => obj && (obj.id == odid) );
      const wireIdx = state.current_object.devices[deviceIdx].wires.findIndex( wire =>  wire && (wire.id == wireId) );
      return state.current_object.devices[deviceIdx].wires[wireIdx];
    },
}