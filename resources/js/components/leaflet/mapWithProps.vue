<template>
    <div id="map"></div>
</template>

<script>
export default {
	props:['lat','lng'],
	data() {
		return {
	      	map:{},
            tileLayer:{},
            markerLayer:{},
            icon: L.icon({
                iconUrl: '/images/map/marker-icon-red.png',
                shadowUrl: '/images/map/marker-shadow.png',
                iconSize: [25, 41],
                iconAnchor: [12, 41],
                popupAnchor: [1, -34],
                shadowSize: [41, 41]
            }),
		}
	},
	mounted(){
        this.initMap();
	},
    watch:{
        lat(){
            this.setMarker();
            this.setCenter();
        },
        lng(){
            this.setMarker();
            this.setCenter();
        },
    },
	methods:{
        setCenter(){
            this.map.panTo(this.coords);
        },
        setMarker(){
            if(this.markerLayer)
                this.map.removeLayer(this.markerLayer);
            const marker =
                L.marker(this.coords,{
                    icon:this.icon,
                    draggable:true,
                })
                .on('dragend', function() {
                    const coord = marker.getLatLng();
                    this.$emit("change",coord);
                });
            this.markerLayer = marker;
            marker.addTo(this.map);
        },
        initMap(){
            this.map = L.map('map').setView(this.coords, 13);
            this.tileLayer = L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
                attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
                maxZoom: 18,
            });
            this.map.on('click', (val) => {
                const coord = val.latlng;
                this.$emit("change",coord);
            });
            this.tileLayer.addTo(this.map);
            this.setMarker();
        },
	},

	computed: {
        coords(){return {lat:this.lat, lng: this.lng}},
	}
}
</script>

<style scoped>
    #map {
        width: 100%;
        height: 400px;
    }
</style>
