<template>
    <div id="map"></div>
</template>

<script>
import "leaflet/dist/leaflet.css";
import L from 'leaflet';

export default {
	props:[	],

	data() {
		return {
	      	map:{},
            tileLayer:{},
		}
	},

	components:{	},

	mounted(){
        this.initMap();
	},

	methods:{
        initMap(){
            const objCoords = [ this.object.lat, this.object.lng];
            const store = this.$store;
            this.map = L.map('map').setView(objCoords, 13);
            this.tileLayer = L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
                attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
                maxZoom: 18,
            });
            var myIcon = L.icon({
                iconUrl: '/images/map/marker-icon-red.png',
                shadowUrl: '/images/map/marker-shadow.png',
                iconSize: [25, 41],
                iconAnchor: [12, 41],
                popupAnchor: [1, -34],
                shadowSize: [41, 41]
            });
            var marker =
                L.marker(objCoords,{
                    icon:myIcon,
                    draggable:true,
                })
                .addTo(this.map)
                .on('dragend', function() {
                    var coord = marker.getLatLng();
                    store.commit('CHANGE_OBJECT_LL',{
                        lat: coord.lat,
                        lng: coord.lng,
                    })
                });
            this.map.on('click', (val) => {
                coord = val.latlng;
                marker.setLatLng(coord);
                    store.commit('CHANGE_OBJECT_LL',{
                        lat: coord.lat,
                        lng: coord.lng,
                    })
            });
            this.tileLayer.addTo(this.map);
        },
	},

	computed: {
		object() {return this.$store.getters.OBJECT(this.$route.params.id)},
	}
}
</script>

<style scoped>
    #map {
        width: 100%;
        height: 400px;
    }
</style>
