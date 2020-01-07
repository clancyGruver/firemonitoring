<template>
    <div id="allMap"></div>
</template>

<script>
export default {
	props:{
        objects: {
            type: Array,
            default: ()=>{ return [] },
        },
        center: {
            type: Object,
            default: ()=>{ return {lat: 55.198016, lng: 61.359764} },
        },
    }
    ,

	data() {
		return {
	      	map:{},
            tileLayer:{},
            markers:[],
            myIcon: L.icon({
                iconUrl: '/images/map/marker-icon-red.png',
                shadowUrl: '/images/map/marker-shadow.png',
                iconSize: [25, 41],
                iconAnchor: [12, 41],
                popupAnchor: [1, -34],
                shadowSize: [41, 41]
            }),
		}
	},

	components:{	},

	mounted(){
        this.initMap();
	},

	methods:{
        removeMarkers(){
            this.markers.forEach( marker => this.map.removeLayer( marker ))
        },
        setObjects(){
            if(this.markers.length > 0)
                this.removeMarkers();
            this.objects.forEach(
                object => {
                    const objCoords = [ object.lat, object.lng];
                    const marker =
                        L.marker(objCoords,{
                            icon: this.myIcon,
                            draggable: true,
                        })
                        .bindPopup(`
                            <b>${object.name}</b><br/>
                            Адрес: ${object.address}<br/>
                            Директор: ${object.director_name}, ${object.director_phone}<br/>
                            Ответственный: ${object.contact_name}, ${object.contact_phone}<br/>
                        `)
                        .addTo(this.map);
                    this.markers.push(marker);
                }
            );
        },
        initMap(){
            const store = this.$store;
            this.map = L.map('allMap').setView(this.center, 13);
            this.map.scrollWheelZoom.disable();
            this.tileLayer = L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
                attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
                maxZoom: 18,
            });
            this.tileLayer.addTo(this.map);
            this.setObjects();
        },
	},

    watch:{
        center(nV,oV){
            this.map.panTo(nV);
        },
        objects(){
            this.setObjects();
        },
    },

	computed: {
	}
}
</script>

<style scoped>
    #allMap {
        width: 100%;
        height: 400px;
    }
</style>
