<template>
	<div class="row">
		<div id="mapid"></div>
	</div>
</template>

<script>
import L from 'leaflet';

export default {
	props:[	],

	data() {
		return {
	      	map:{},
		}
	},

	components:{	},

	mounted: function(){
		const objCoords = [ this.object.lat, this.object.lng];
		this.map = L.map('mapid').setView(objCoords, 13);
        var myIcon = L.icon({
            iconUrl: '/public/images/map/marker-icon-red.png',
            shadowUrl: '/public/images/map/marker-shadow.png',
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
                this.$store.commit('CHANGE_OBJECT_LL',{
                	lat: coord.lat,
                	lng: coord.lng,
                })
            });
        this.map.on('click', (val) => {
            coord = val.latlng;
            marker.setLatLng(coord);
                this.$store.commit('CHANGE_OBJECT_LL',{
                	lat: coord.lat,
                	lng: coord.lng,
                })
        });
        L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
            attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
            maxZoom: 18,
        }).addTo(this.map);
	},

	methods:{
		createTree: function (devices) {
		}
	},

	computed: {
		object() {return this.$store.getters.OBJECT(this.$route.params.id)},
	}
}
</script>

<style>
    #mapid {
		height: 400px;
        width: 100%;
    }
</style>
