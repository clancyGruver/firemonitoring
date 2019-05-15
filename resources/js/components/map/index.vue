<template>
  <l-map
      :zoom="zoom"
      :center="center"
      :options="mapOptions"
      style="height: 100%"
      @update:center="centerUpdate"
      @update:zoom="zoomUpdate"
    >
      <l-tile-layer :url="url"/>
      <template v-for="(marker, markerId) in markers">
        <l-marker :lat-lng="marker.ll" @click="$emit('object-select', marker.id)" :key="markerId" :icon="redIcon">
        </l-marker>      
      </template>      
</l-map>
</template>

<script>
import { latLng, icon } from "leaflet";
import { LMap, LTileLayer, LMarker, LPopup } from "vue2-leaflet";

export default {
    name: 'Map',
    components: {
      LMap,
      LTileLayer,
      LMarker,
      LPopup
    },
  data() {
    return {
      zoom: 13,
      center: latLng(55.173736, 61.407359),
      url: "http://{s}.tile.osm.org/{z}/{x}/{y}.png",
      markers: [
        {
          id:1,
          ll:latLng(55.173736, 61.407359),
          type:'repair'
        },
        {
          id:2,
          ll:latLng(55.193736, 61.407359),
          type:'reglament'
        },
        {
          id:3,
          ll:latLng(55.153736, 61.407359),
          type:'done'
        }
      ],
      redIcon: new L.Icon({
        iconUrl: './images/map/marker-icon-red.png',
        shadowUrl: './images/map/marker-shadow.png',
        iconSize: [25, 41],
        iconAnchor: [12, 41],
        popupAnchor: [1, -34],
        shadowSize: [41, 41]
      }),
      greenIcon: new L.Icon({
        iconUrl: './images/map/marker-icon-green.png',
        shadowUrl: './images/map/marker-shadow.png',
        iconSize: [25, 41],
        iconAnchor: [12, 41],
        popupAnchor: [1, -34],
        shadowSize: [41, 41]
      }),
      yellowIcon: new L.Icon({
        iconUrl: './images/map/marker-icon-yellow.png',
        shadowUrl: './images/map/marker-shadow.png',
        iconSize: [25, 41],
        iconAnchor: [12, 41],
        popupAnchor: [1, -34],
        shadowSize: [41, 41]
      }),
      currentZoom: 11.5,
      currentCenter: latLng(55.173736, 61.407359),
      showParagraph: false,
      mapOptions: {
        zoomSnap: 0.5
      }
    };
  },
  methods: {
    zoomUpdate(zoom) {
      this.currentZoom = zoom;
    },
    centerUpdate(center) {
      this.currentCenter = center;
    },
    markerClick(id) {
      console.log(`clicked ${id}`);
    }
  }
    /*mounted () {
      this.$nextTick(() => {
        const mapObject = this.$refs.myMap.mapObject;
        mapObject.setView([  ], 13);
        const marker = LMarker([  ]).addTo(mapObject);
        LTileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
            attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
        }).addTo(mapObject);

      })
    }*/
}
</script>