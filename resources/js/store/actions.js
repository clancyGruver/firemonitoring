import {router} from '../router.js';

export default{
    setCurrentObjectAction({commit, getters}, payload){
      commit('SET_CURRENT_OBJECT', {payload, getters});
      commit('SET_CURRENT_OBJECT_DEVICES_LOADER');
      axios
        .post(`/api/objectdevice/get/${payload}`)
        .then( response => {
          commit('SET_CURRENT_OBJECT_DEVICES', {payload: response.data, getters})
          //this.$store.commit('CHANGE_PRELOADER',false);
        } );
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
    async LOAD_DISTRICTS({commit}){
      await axios
        .post(`/api/district/getAll`)
        .then( response => commit('SET_DISTRICTS', response.data));
    },
    async CHANGE_OBJECT_LL({state, commit, getters}, payload){
      const p = {...payload}
      await axios.post(`/api/objects/storeCoords/${state.object_id}`,p)
        .then(response => commit('SET_OBJECT_LL', {p,getters}));
    },
    async OBJECT_UPDATE({state, commit, getters}){
      await axios.post(`/api/objects/update/${state.current_object.id}`,state.current_object)
        .then(response => commit('UPDATE_CURRENT_OBJECT', {getters}));
    },
    async SET_DEVICE_COORDS({commit, state, getters}, payload){
      const p = {...payload};
      await axios.post(`/api/objectdevice/storeCoords/${state.markerObj.id}`, {
        lat: p.coords.lat,
        lng: p.coords.lng,
        bti_files_id: p.bti_plan_id,
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
        bti_files_id: p.bti_plan_id,
      })
       .then(response => commit('UPDATE_ALERT_COORDS', {...p, ...response.data}))
    },
    async UPDATE_LIMITATION({commit, getters}, payload){
      const p = {...payload};
      axios.post(`/api/limitations/update/${p.id}`,{
        text: p.text,
        isCritical: p.isCritical,
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
          device_id: p.device_id,
          isCritical: p.isCritical,
        }, getters}))
    },
    async DELETE_LIMITATION({commit, getters}, payload){
      const p = {...payload}
      axios.post(`/api/limitations/delete/${p.id}`)
      .then(response => commit('REMOVE_LIMITATION', {payload, getters}));
    },
    async LOAD_LIMITED_OBJECTS({commit}){
      /*
        Send request to load objects with limitations
        Commit ADD_LIMITED_OBJECTS
      */
      axios.post('/api/objects/limited')
        .then( response => commit('ADD_LIMITED_OBJECTS',response.data));
    },
    async TOGGLE_DEVICE_ISGOOD({commit, dispatch},payload) {
      /*
        Send request to store object_device_reglament_limitations
        Send request to store object_device {is_good == true if no limitations | is_good == false if no limitations}
        Commt DEVICE_ISGOODs
      */
      const p = {... payload };

      //store object_device_reglament_limitations
      axios.post(`/api/limitations/set/${p.odid}`,{
        additionalLimit: p.additionalLimit,
        isCritical: p.isCritical,
        allLimits: p.allLimits,
      }).then( response => {
        //store object_device good or bad
        const is_good = response.data;
        axios.post(`/api/objectdevice/isgood/${p.odid}`,{is_good})
        .then(
          response => {
            commit('TOGGLE_DEVICE_ISGOOD', {
              odid: p.odid,
              typeIdx: p.typeIdx,
              is_good
            });
            dispatch('LOAD_LIMITED_OBJECTS');
          }
        );
      });
    },
    async DELETE_REGLAMENT_ELEMENT({commit, getters},payload){
      const p = {...payload};
      axios.post(`/api/reglamentElement/delete/${p.elementId}`)
           .then( () => commit('DELETE_REGLAMENT_ELEMENT', {getters, payload:p}) )
    },
    async SAVE_REGLAMENT_ELEMENT({commit, getters},payload){
    	if(payload.id * 1 < 0 && payload.text != '')
    		axios.post(`/api/reglamentElement/add`,payload)
    			 .then(response => commit('ADD_REGLAMENT_ELEMENT', {
    			 	getters,
    			 	payload: {
    			 		response: {...response.data},
    			 		p: {...payload},
    			 	},
    			 }))
    	else
    		axios.post(`/api/reglamentElement/update/${payload.id}`,payload)
    			 .then(response => commit('UPDATE_REGLAMENT_ELEMENT', {
    			 	getters,
    			 	payload: {
    			 		response: {...response.data},
    			 		p: {...payload},
    			 	},
    			 }))
    },
    SAVE_REGLAMENT({commit, getters, dispatch},payload){
    	const p = {...payload};
		const res = {};
    	if(p.id) //Update reglament
    		axios.post(`/api/reglament/update/${p.id}`,p)
    			 .then(response => {
    			 	commit('UPDATE_REGLAMENT', {
	     			 	getters,
	     			 	payload: {
	     			 		p,
	     			 		response: response.data,
	     			 	}
	     			 });
			    	//save all elements
			    	p.elements.map(
			    		async elem => dispatch('SAVE_REGLAMENT_ELEMENT', {
			    			...elem,
			    			type: p.type,
			    			device_id: p.device_id,
			    		})
			    	);
			    	res.type = 'old';
    			})
    	else{ //save new reglament
    		axios.post(`/api/reglament/add`,p)
    			 .then(response => {
    			 	if(p.elements && p.elements.length > 0)
						p.elements.map(
							async elem =>
								dispatch('SAVE_REGLAMENT_ELEMENT', {
								...elem,
								type: p.type,
								device_id: p.device_id,
								device_reglament_id: response.data.id
							})
						);
    			 	commit('ADD_REGLAMENT',{
	     			 	getters,
	     			 	payload: {
	     			 		p,
	     			 		response: response.data,
	     			 	}
	     			});
	     			res.type = 'new';
	     			res.id = response.data.id;
    			})
    		return res;
    	}
    },
    async DELETE_REGLAMENT({commit, getters},payload){
    	axios.post(`/api/reglament/delete/${payload.reglamentId}`)
    		 .then(response => commit('DELETE_REGLAMENT', {getters, payload}) )
    },
    async LOAD_UNREGLAMENTED_DEVICES({commit}){
    	axios.post(`/api/reglament/unworked`)
    		 .then(response => commit('SET_UNREGLAMENTED_DEVICES', response.data) )
    },
    async SEND_DEVICE_REGLAMENT({dispatch}, payload){
      await axios.post(`/api/reglament/updateWork/${payload}`)
        .then(response => console.log(response) );
    },
    async TOGGLE_DEVICE_REGLAMENT({dispatch}, payload){
      /*const res = await dispatch('SEND_DEVICE_REGLAMENT',payload.reglamentWorkId);
      res.then( promise => console.log(promise) );*/
  		//dispatch('LOAD_UNREGLAMENTED_DEVICES');
      let res = await axios.post(`/api/reglament/updateWork/${payload.reglamentWorkId}`);
      dispatch('LOAD_UNREGLAMENTED_DEVICES');
    },
    async LOAD_USERS({commit}){
      await axios.post(`/api/users/getAll`)
      	.then(response => {
      		commit('SET_USERS',response.data);
      	});
    },
    async DELETE_USER({commit},payload){
      await axios.post(`/api/users/delete/${payload.id}`)
                 .then(success => commit('DELETE_USER',payload.id))
    },
    async UPDATE_USER({commit, getters},payload){
      if(payload.id)
        axios.post(`/api/users/update/${payload.id}`,payload)
             .then(success =>  commit('UPDATE_USER',{getters, payload}))
      else
        axios.post(`/api/users/add`,payload)
             .then(success =>  commit('ADD_USER',payload))
    },
    async TOGGLE_RAION({commit, dispatch}, payload){
      axios.post(`/api/raions/${payload}`)
            .then(success => dispatch('LOAD_RAIONS'))
    },
    async DELETE_DEVICE({commit}, payload){
      axios.post(`/api/devices/delete/${payload.type}/${payload.id}`)
           .then( response => commit('DELETE_AVAILABLE_DEVICE', payload) );
    },
    async DELETE_OBJECT_DEVICE({commit}, payload){
      axios.post(`/api/objectdevice/delete/${payload}`)
      .then( response => commit('DELETE_OBJECT_DEVICE',payload) );
    },
    UPDATE_DEVICE({commit, getters}, payload){
      const config = {headers: {'content-type': 'multipart/form-data'}};

      const mixins = {
        type: payload.device_type,
        deviceId: payload.deviceId,
      };

      const url = payload.deviceId ?
        `/api/devices/update/${mixins.type}/${mixins.deviceId}` :
        `/api/devices/add/${mixins.type}`;

      const commitName = payload.deviceId ?
        'UPDATE_DEVICE' :
        'ADD_NEW_DEVICE';

      return axios.post(
        url,
        payload.fd,
        config
      )
      .then( response => commit(commitName, {load:{data:response.data, mixins}, getters}) );
    },
    async ADD_OBJECT_DEVICE({commit}, payload){
      const p = {...payload}
      axios.post('/api/objectdevice/store',p)
        .then(response => commit('ADD_OBJECT_DEVICE',response.data) );
    },
    async TOGGLE_DEVICE_SHOW({commit,getters}, payload){
      commit('TOGGLE_DEVICE_SHOW', {payload, getters});
    },
    async ADD_WIRE({commit,getters}, payload){
      axios.post('/api/wire/store',{
        object_device_id: payload.odid,
        wire_data: payload.wire
      })
      .then(
        response => {
          const data = {};
          payload.wire.id = response.data.id;
          payload.wire.sensors = [];
          data.wire = payload.wire;
          data.odid = payload.odid;
          commit('ADD_WIRE', data);
        }
      );
    },
    async UPDATE_OBJECT_DEVICE_PARAMS({commit}, payload){
      const p = {...payload};
      const id = p.data.id || '';
      axios.post(`/api/${p.type}/storeParams/${id}`,p.data)
       .then( response => commit('UPDATE_OBJECT_DEVICE_PARAMS', p.data) );
    },
    async EDIT_WIRE({commit}, payload){
      const p = {...payload};
      axios.post(`/api/wire/update/${p.wire.id}`,p.wire)
            .then( response => commit('EDIT_WIRE',p.wire) );
    },
    async DELETE_WIRE({commit}, payload){
      const p = {...payload};
      axios.post(`/api/wire/delete/${p.id}`)
            .then( response => commit('DELETE_WIRE',p) );
    },
    async ADD_SENSOR_TO_WIRE({commit, dispatch}, payload){
      const p = {...payload};
      axios.post('/api/sensorwire/add',payload)
            .then( response => commit('ADD_SENSOR_TO_WIRE',{payload:{sensorData:p, responseData:response.data},dispatch}) );
    },
    async DELETE_SENSOR_ON_WIRE({commit}, payload){
      axios.post(`/api/sensorwire/delete/${payload.sensorId}`)
            .then( response => commit('DELETE_SENSOR_ON_WIRE',payload) );
    },
    async UPDATE_SENSOR_TO_WIRE({commit}, payload){
      axios.post('/api/sensorwire/update', payload)
            .then( response => commit('UPDATE_SENSOR_TO_WIRE',{sensorData:payload, responseData:response.data}) );
    },
    async CALENDAR_ADD_OBJECT({commit}, payload){
      axios.post('/api/calendar/addObject', payload)
            .then( response => console.log(response) );
    },
    async ADD_NEW_OBJECT({commit}, payload){
      const resp = await axios.post('/api/objects/addObject', payload);
      commit('ADD_NEW_OBJECT',resp.data);
      const id = resp.data.id;
      router.push(`/objects/${id}/main`);
    },
    async SET_DEVICE_SETUP_YEAR({commit}, payload){
      axios.post(`/api/objectdevice/storeSetupYear/${payload.object_device_id}`, payload)
          .then(response => commit('SET_DEVICE_SETUP_YEAR',payload));
    }
}