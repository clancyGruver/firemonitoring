<template>
    <div id="full_div">
        <Map v-on:object-select="objectSelectHandle"/>
    </div>
</template>

<script>
import Map from '../map/index';

export default {
    components: { Map },
    methods:{
        objectSelectHandle: function(odjectId){
            console.log(odjectId);
        }
    },
    mounted: function () {
        this.$nextTick(function () {
            /*const elem = document​.get​Element​ById("full_div");
            elem.style.height = '600px';*/
        })
    }
}
</script>
<style>
@import "../../../../node_modules/leaflet/dist/leaflet.css";
#full_div{
    height: 600px;
}
</style>