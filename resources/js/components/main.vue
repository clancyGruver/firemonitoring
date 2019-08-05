<template>
  <transition name="slide">
    <router-view></router-view>
  </transition>
</template>
<script>
  export default {
    components: {
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