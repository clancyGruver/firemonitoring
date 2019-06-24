<template>
	<div class="map-wrapper">
		<div id="btiMap">
		</div>
		<ul>
			<li @click="nextImg()"><span><i class="fas fa-arrow-left"></i></span></li>
			<li @click="prevImg()"><span><i class="fas fa-arrow-right"></i></span></li>
		</ul>
	</div>
</template>

<script>
	import L from 'leaflet';

	export default{
	    data () {
	      return {
	      	map:{},
	      	imgs:[
	      		'http://localhost:5000/uploads/bti/6/plan-bti-3.jpg',
	      		'http://localhost:5000/uploads/bti/6/plan-bti-2.jpg',
	      		'http://localhost:5000/uploads/bti/6/plan-bti.jpg',
	      	],
	      	curImg: 0,
	      }
	    },

	    methods: {
	    	nextImg: function(){
	    		console.log('nextImg');
				if(this.curImg == this.imgs.length)
					this.curImg = 0;
				else
					++this.curImg;
				this.changeMapImg();
	    	},
	    	prevImg: function(){
	    		console.log('prevImg');
				if(this.curImg == 0)
					this.curImg = this.imgs.length;
				else
					--this.curImg;
				this.changeMapImg();
	    	},
			changeMapImg: function () {
				const self = this;
				this.addImageToMap();
				/*const img = new Image();
				img.src = this.imgUrl;
				img.onload = function() {
					const w = this.width,
						  h = this.height;
					self.addImageToMap(w,h);
				}*/
			},
			addImageToMap: function (w,h) {
				const /*southWest = this.map.unproject([0, h], this.map.getMaxZoom()-1),
					  northEast = this.map.unproject([w, 0], this.map.getMaxZoom()-1),*/
					  //bounds = new L.LatLngBounds(southWest, northEast),
					  bounds = [[0,0],[1000,1000]];
				this.map.fitBounds(bounds);
			  	L.imageOverlay(this.imgUrl, bounds).addTo(this.map);
				//console.log(southWest, northEast);
				//this.map.setView([southWest.lat, northEast.lng], 1);
				this.map.setView([500, 500], -1);
			}
	    },

	    computed: {
			imgUrl: function() {
				return this.imgs[this.curImg];
			}
		},

		mounted(){
			this.map = L.map('btiMap', {
				crs: L.CRS.Simple,
				minZoom: -5,
				maxZoom: 4,
				center: [500,500],
				zoom: 1
			})
			this.map.whenReady((e)=>{
				this.addImageToMap();
				this.map.on('click', (e)=>{
					console.log(e.latlng);
					const marker = L.marker(e.latlng);
					markers.push(marker);
					marker.addTo(this.map);
				});
				const markers = [
					L.marker(L.latLng(-131,75)).on('click', () => alert('Object 1')),
					L.marker(L.latLng(-81,77)).on('click', () => alert('Object 2')),
				];
				markers.forEach((el) => el.addTo(this.map));
			});
			this.map.on('moveend',(e)=>{console.log('moveEnded: ',this.map.getCenter(), this.map.getZoom())});
		}
	}
</script>

<style scoped>
	#btiMap{
		height: 100%;
		min-height: 600px;
	}
</style>