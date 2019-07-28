<template>
	<div class="map-wrapper">
		<div id="btiMap"></div>
		<nav aria-label="Page navigation example">
			<ul class="pagination">
				<li class="page-item">
					<a @click.prevent="prevImg()" class="page-link" href="#" aria-label="Назад">
						<span aria-hidden="true">&laquo;</span>
        				<span class="sr-only">Назад</span>
					</a>
				</li>
			    <li class="page-item">
			      <a class="page-link" @click.prevent="nextImg()" href="#" aria-label="Вперед">
			        <span aria-hidden="true">&raquo;</span>
			        <span class="sr-only">Вперед</span>
			      </a>
			    </li>
			</ul>
		</nav>
	</div>
</template>

<script>
	import L from 'leaflet';

	export default{
	    data () {
	      return {
	      	map:{},
	      	curImg: 0,
	      	mapMarkers: [],
	      }
	    },

	    methods: {
	    	checkPlans: function() {
	    		const status = this.$store.getters.BTI_PLANS.status;
				if(status)
					this.addImageToMap();
				return status;
	    	},
	    	nextImg: function(){
				if(this.curImg >= this.imgs.length-1)
					this.curImg = 0;
				else
					++this.curImg;
				this.addImageToMap();
	    	},
	    	prevImg: function(){
				if(this.curImg <= 0)
					this.curImg = this.imgs.length;
				--this.curImg;
				this.addImageToMap();
	    	},
			addImageToMap: function (w,h) {
				const img = new Image();
				img.src = this.imgUrl;
				const southWest = this.map.unproject([0, img.height], this.map.getMaxZoom()-1),
					  northEast = this.map.unproject([img.width, 0], this.map.getMaxZoom()-1),
					  bounds = new L.LatLngBounds(southWest, northEast);
			  	L.imageOverlay(this.imgUrl, bounds).addTo(this.map);
				//this.map.setMaxBounds(bounds);
				//this.map.fitBounds(bounds);
				this.map.invalidateSize(bounds);
				this.map.panTo([southWest.lat/2, northEast.lng/2]);
				this.setMarkers();
			},
	    	setMarkers(){
	    		const self = this;
	    		const markers = this.$store.getters.DEVICE_MARKERS[this.imgs[this.curImg].id]
	    		if(this.mapMarkers.length > 0){
		    		this.mapMarkers.map(marker => marker.remove())
		    		this.mapMarkers = [];
	    		}
	    		if(typeof(markers) == "undefined" || markers.length < 1)
	    			return false;
	    		markers.map(marker => {
	    			const markerParams = {};
	    			if(marker.icon != 'default')
	    				markerParams.icon = L.icon({
	    					iconUrl: marker.icon,
	    					iconSize: [38, 38],
	    				});
	    			const theMarker = L.marker({lat: marker.lat, lng: marker.lng}, markerParams);
	    			self.mapMarkers.push(theMarker);
	    			theMarker.addTo(self.map);
	    		});
	    	},
	    },

	    computed: {
			imgUrl() {return this.imgs[this.curImg].path;},
			imgs() {return this.$store.getters.BTI_PLANS.items;},
			markerSetable() {return this.$store.getters.MARKER_SETTABLE;},
			markers() {
				const markers = this.$store.getters.DEVICE_MARKERS[this.imgs[this.curImg].id];
				return markers;
			},
		},

		mounted(){
			this.map = L.map('btiMap', {
				crs: L.CRS.Simple,
				minZoom: 1,
				maxZoom: 4,
				center: [0,0],
				zoom: 1
			})
			const self = this;
			this.map.whenReady((e)=>{
				this.map.on('click', (e)=>{
					if(self.markerSetable){
						this.$store.commit('TOGGLE_MAP');
						const markerType = this.$store.getters.MARKER_OBJECT.type;
						if(markerType == 'device')
							this.$store.commit('SET_DEVICE_COORDS',{coords: e.latlng, bti_plan_id: self.imgs[this.curImg].id});
						else if(markerType == 'sensor')
							this.$store.commit('SET_SENSOR_COORDS',{coords: e.latlng, bti_plan_id: self.imgs[this.curImg].id});
						else if(markerType == 'alarm')
							this.$store.commit('SET_ALERT_COORDS',{coords: e.latlng, bti_plan_id: self.imgs[this.curImg].id});
						self.setMarkers();
					}
				});
			});
			let timerId = setTimeout(function tick() {
			  const flag = self.checkPlans();
			  if(!flag)
			  	timerId = setTimeout(tick, 500);
			}, 500);
		}
	}
</script>

<style scoped>
	#btiMap{
		height: 100%;
		min-height: 600px;
	}
</style>