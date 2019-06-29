<template>
	<div class="map-wrapper">
		<div id="btiMap"></div>
		<nav aria-label="Page navigation example">
			<ul class="pagination">
				<li @click="prevImg()" class="page-item">
					<a @click.prevent="" class="page-link" href="#" aria-label="Назад">
						<span aria-hidden="true">&laquo;</span>
        				<span class="sr-only">Назад</span>
					</a>
				</li>
			    <li class="page-item" @click="nextImg()">
			      <a class="page-link" @click.prevent="" href="#" aria-label="Вперед">
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
	      }
	    },

	    methods: {
	    	nextImg: function(){
				if(this.curImg == this.imgs.length-1)
					this.curImg = 0;
				else
					++this.curImg;
				this.addImageToMap();
	    	},
	    	prevImg: function(){
				if(this.curImg == 0)
					this.curImg = this.imgs.length;
				else
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
				this.map.setMaxBounds(bounds);
			}
	    },

	    computed: {
			imgUrl: function() {return this.imgs[this.curImg].path;},
			imgs: function() {return this.$store.getters.BTI_PLANS;},
		},

		mounted(){
			this.map = L.map('btiMap', {
				crs: L.CRS.Simple,
				minZoom: 1,
				maxZoom: 4,
				center: [0,0],
				zoom: 1
			})
			this.map.whenReady((e)=>{
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
			if(this.imgs.length > 0)
				this.addImageToMap();
		}
	}
</script>

<style scoped>
	#btiMap{
		height: 100%;
		min-height: 600px;
	}
</style>