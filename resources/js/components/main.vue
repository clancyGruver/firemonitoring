<template>
  <transition name="page" mode="out-in">
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