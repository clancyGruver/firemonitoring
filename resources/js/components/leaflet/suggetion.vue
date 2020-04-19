<template>
	<autocomplete
		:value="defaultValue"
		:defaultValue="defaultValue"
		:search="search"
    	:get-result-value="getResultValue"
    	@submit="handleSubmit"
    >
    </autocomplete>
</template>

<script>
import Autocomplete from '@trevoreyre/autocomplete-vue'
import '@trevoreyre/autocomplete-vue/dist/style.css'

export default{
	components: {Autocomplete},
	props:['defaultValue'],
	data(){
		return{
			object:{
				lat: 55.198003,
				lng: 61.359724,
	            address:'',
			},
            options: {
                headers: {
                    "Content-Type": "application/json",
                    "Accept": "application/json",
                    "Authorization": "Token dd1b616c26fa31d568415b551b7bdc5b77e877e6"
                }
            }
		}
	},
	methods:{
		async handleSubmit(val){
			if(val.data && val.data.fias_level >= 8){
				const res = await this.fiasQuery(val.data.fias_id);
				this.object.address = res.address;
				this.object.lat = res.lat;
				this.object.lng = res.lng;
			} else {
				this.object.address = val.value;
			}
			this.$emit('update',this.object);
		},
		getResultValue(val){
			return val.value
		},
		async search(val){
            this.loading = true;
            const query = `${val}`;
            const count = 5;
            const locations = {
                "region": "Челябинская",
            };
            const url = 'https://suggestions.dadata.ru/suggestions/api/4_1/rs/suggest/address';
            let res = await axios.post(url, {query,locations,count}, this.options);
			this.loading = false;
			res.data.suggestions.push({value:val});
        	return res.data.suggestions;
        },
        async fiasQuery(fias_id){
        	const url = 'https://suggestions.dadata.ru/suggestions/api/4_1/rs/findById/address';
        	const response = await axios.post(url, {query:fias_id}, this.options);
        	const result = {
        		address: response.data.suggestions[0].value,
        		lat: response.data.suggestions[0].data.geo_lat,
        		lng: response.data.suggestions[0].data.geo_lon,
        	}
        	return result;
        }
	},
	computed:{
        query(){
            return this.defaultValue ? this.defaultValue : '';
        }
    },
}
</script>