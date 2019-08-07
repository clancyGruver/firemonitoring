<template>
	<div class="map-wrapper">
		<nav aria-label="bti map navigation">
			<ul class="pagination justify-content-center">
				<li class="page-item">
      				<span class="page-link" @click.prevent="prevImg()">Назад</span>
				</li>
				<li class="page-item" v-for="(img, index) in imgs" :key="img.id">
      				<span class="page-link" @click.prevent="setImg(index)">{{++index}}</span>
				</li>
				<li class="page-item">
      				<span class="page-link" @click.prevent="nextImg()">Вперед</span>
				</li>
			</ul>
		</nav>
		<h3 class="text-center">{{ name }}</h3>
		<div id="btiMap" ref="btiMap"></div>
	</div>
</template>

<script>

	export default{
	    data () {
	      return {
	      	map:{},
	      	curImg: -1,
	      	mapMarkers: [],
			imageOverlay: {},
			height: 0,
	      }
	    },

	    methods: {
	    	nextImg: function(){
				if(this.curImg >= this.imgs.length-1)
					this.curImg = 0;
				else
					++this.curImg;
	    	},
	    	prevImg: function(){
				if(this.curImg <= 0)
					this.curImg = this.imgs.length;
				--this.curImg;
	    	},
	    	setImg: function(index){
	    		this.curImg = index;
	    	},
			addImageToMap: function (w,h) {
				const img = new Image();
				img.src = this.imgUrl;
				img.onload = (e) => {
					const southWest = this.map.unproject([0, img.height], this.map.getMaxZoom()-1),
						northEast = this.map.unproject([img.width, 0], this.map.getMaxZoom()-1),
						bounds = new L.LatLngBounds(southWest, northEast);
					if(this.map.hasLayer(this.imageOverlay))
						this.map.removeLayer(this.imageOverlay);
					this.imageOverlay = L.imageOverlay(this.imgUrl, bounds);
					this.imageOverlay.addTo(this.map);
					this.map.fitBounds(bounds);
					this.map.invalidateSize(bounds);
					this.map.panTo(bounds.getCenter());
				}
			},
	    	setMarkers(){
	    		const self = this;
	    		if(this.mapMarkers.length > 0){
		    		this.mapMarkers.map(marker => marker.remove())
		    		this.mapMarkers = [];
	    		}
	    		if(typeof(this.markers) == "undefined" || this.markers.length < 1)
	    			return false;
	    		this.markers.map(marker => {
	    			const markerParams = {}
	    			if(marker.icon != 'default'){
	    				markerParams.icon = L.icon({
	    					iconUrl: marker.icon,
	    					iconSize: [38, 38],
	    				});
	    			}
	    			const theMarker = L.marker({lat: marker.lat, lng: marker.lng}, markerParams);
	    			theMarker.on('click',(e)=>console.log(e));
	    			theMarker.bindPopup(`${marker.name}`);
	    			self.mapMarkers.push(theMarker);
	    			theMarker.addTo(self.map);
	    		});
	    	},
	    	mapInit(){
				this.map = L.map('btiMap', {
					crs: L.CRS.Simple,
					minZoom: 1,
					maxZoom: 3,
					zoom: 1
				})
				const self = this;
				this.map.on('click', (e)=>{
					if(self.markerSetable){
						this.$store.commit('TOGGLE_MAP');
						const markerType = this.$store.getters.MARKER_OBJECT.type;
						if(markerType == 'device')
							this.$store.dispatch('SET_DEVICE_COORDS',{coords: e.latlng, bti_plan_id: self.imgs[this.curImg].id})
								.then( success => this.$awn.success('Координаты сохранены') )
								.catch( error => this.$awn.alert('Координаты не сохранены'));
						else if(markerType == 'sensor')
							this.$store.dispatch('SET_SENSOR_COORDS',{coords: e.latlng, bti_plan_id: self.imgs[this.curImg].id})
								.then( success => this.$awn.success('Координаты сохранены') )
								.catch( error => this.$awn.alert('Координаты не сохранены'));
						else if(markerType == 'alarm')
							this.$store.dispatch('SET_ALERT_COORDS',{coords: e.latlng, bti_plan_id: self.imgs[this.curImg].id})
								.then( success => this.$awn.success('Координаты сохранены') )
								.catch( error => this.$awn.alert('Координаты не сохранены'));
					}
				});
				this.nextImg();
				console.log(this.$refs.btiMap.clientHeight);
	    	},
	    },

	    computed: {
	    	object() {return this.$store.getters.CURRENT_OBJECT;},
			imgUrl() {return this.imgs[this.curImg].path;},
			name(){
				if (typeof this.imgs[this.curImg] === "undefined")
					return null;
				return this.imgs[this.curImg].description || this.imgs[this.curImg].filename;
			},
			imgs() {return this.object.btifiles;},
			markerSetable() {return this.$store.getters.MARKER_SETTABLE;},
			markers() {
				const markers = this.$store.getters.DEVICE_MARKERS[this.imgs[this.curImg].id];
				return markers;
			},
		},

		watch:{
			curImg: 'addImageToMap',
		},

		mounted(){
			this.$nextTick(function () {
				this.mapInit();
				this.$store.watch(
					(state)=>{
						if(this.imgs && this.curImg > -1)
							return this.$store.getters.DEVICE_MARKERS[this.imgs[this.curImg].id]
					},
					(newValue, oldValue)=>{
						this.setMarkers();
					}
				);
			});
		}
	}
</script>

<style scoped>
	#btiMap{
		height: 100%;
		min-height: 600px;
	}
</style>