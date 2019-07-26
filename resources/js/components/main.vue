<template>
    <router-view></router-view>
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

    mounted: function(){
      this.$store.commit('LOAD_OBJECTS');
      this.$store.commit('LOAD_RAIONS');
      this.$store.commit('FILL_SENSORS');
      this.$store.commit('SET_AVAILABLE_DEVICES');
    },
  }
</script>

<style>
</style>