<template>
  <div class="">
    <left-side-bar />
    <div class="main-content">
      <div class="container-fluid mt-3">
        <h3>{{ $route.meta.title }}</h3>
        <transition name="slide">
          <router-view></router-view>
        </transition>
      </div>
    </div>
  </div>
</template>
<script>
  import LeftSideBar from './leftSideBar';

  export default {
    components: {
      LeftSideBar
    },
    data () {
      return {
      }
    },

    computed: {
    },

    methods: {
    },

    mounted: async function(){
      this.$store.dispatch('LOAD_OBJECTS')
        .catch( error => this.$awn.alert('Объекты мониторинга не загружены'));
      this.$store.dispatch('LOAD_RAIONS')
        .catch( error => this.$awn.alert('Доступные районы не загружены'));
      this.$store.dispatch('LOAD_SENSORS')
        .catch( error => this.$awn.alert('Доступные извещатели не загружены'));
      this.$store.dispatch('LOAD_AVAILABLE_DEVICES')
        .catch( error => this.$awn.alert('Доступные устройства не загружены'));
    },
  }
</script>

<style>
</style>