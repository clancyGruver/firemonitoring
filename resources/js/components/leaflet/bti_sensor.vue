<template>
	<div class="btiMap" :id="containerName"></div>
</template>

<script>

	export default{
	    data () {
	      return {
	      	map:{},
	      	mapMarkers: [],
			imageOverlay: {},
	      }
	    },
	    props:{
	    	containerName:{
	    		type: String,
	    		default: 'btiMap'
	    	},
	    	sensor:{
	    		type: Object,
	    		default: {}
	    	}
	    },
	    methods: {
			addImageToMap: function (w,h) {
				const img = new Image();
				img.src = this.img.path;
				img.onload = (e) => {
					const southWest = this.map.unproject([0, img.height], this.map.getMaxZoom()-1),
						northEast = this.map.unproject([img.width, 0], this.map.getMaxZoom()-1),
						bounds = new L.LatLngBounds(southWest, northEast);
					if(this.map.hasLayer(this.imageOverlay))
						this.map.removeLayer(this.imageOverlay);
					this.imageOverlay = L.imageOverlay(this.img.path, bounds);
					this.imageOverlay.addTo(this.map);
					this.map.fitBounds(bounds);
					this.map.invalidateSize(bounds);
					this.map.panTo(bounds.getCenter());
				}
			},
	    	setMarkers(){
    			const markerParams = {}
    			if(this.sensor.icon != 'default'){
    				markerParams.icon = L.icon({
    					iconUrl: this.sensor.icon,
    					iconSize: [38, 38],
    				});
    			}
    			const theMarker = L.marker({lat: this.sensor.lat, lng: this.sensor.lng}, markerParams);
    			this.mapMarkers.push(theMarker);
    			theMarker.addTo(this.map);
	    	},
	    	mapInit(){
				this.map = L.map(this.containerName, {
					crs: L.CRS.Simple,
					minZoom: 1,
					maxZoom: 3,
					zoom: 1
				})
				this.addImageToMap();
				this.setMarkers();
	    	},
	    },

	    computed: {
	    	object() {return this.$store.getters.CURRENT_OBJECT;},
			img(){return this.object.btifiles.find(file => file.id == this.sensor.bti_files_id); },
		},
		mounted(){
			this.$nextTick(function () {
				this.mapInit();
			});
		}
	}
</script>

<style scoped>
	.btiMap{
		height: 100%;
		min-height: 600px;
	}
</style>