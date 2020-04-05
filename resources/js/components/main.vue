<template>
  <div class="wrapper">
    <nav class="main-nav bg-gradient-primary border-bottom border-dark">
        <Burger></Burger>

        <ul class="navbar-nav ml-lg-auto">
          <li class="nav-item">
            <router-link
              class="nav-link text-white mr-3"
              :to="{
                name: 'objects',
                params:{
                  mode:'all'
                }
              }">
              <i class="ni ni-building text-primary"></i> Объекты мониторинга
            </router-link>
          </li>
        </ul>
        <div class="logo">
          <router-link class="navbar-brand pt-0" :to="{ name: 'index' }" title="Главная">
            <i class="fas fa-fire text-danger mr-2"></i>FIREMONITORING
          </router-link>
        </div>
    </nav>
    <left-side-bar />
    <div class="main-content">
      <div class="container-fluid mt-3">
        <h3>{{ $route.meta.title }}</h3>
        <transition name="fade">
          <router-view></router-view>
        </transition>
      </div>
    </div>
  </div>
</template>
<script>
  import LeftSideBar from './leftSideBar';
  import Burger from './Menu/Burger';

  export default {
    components: {LeftSideBar, Burger},
    data () {
      return {
      }
    },

    computed: {
    },

    methods: {
    },

    mounted: async function(){
      await this.$store.dispatch('LOAD_RAIONS')
        .catch( error => this.$awn.alert('Доступные районы не загружены'));
      await this.$store.dispatch('LOAD_OBJECTS')
        .catch( error => this.$awn.alert('Объекты мониторинга не загружены'));
      this.$store.dispatch('LOAD_SENSORS')
        .catch( error => this.$awn.alert('Доступные извещатели не загружены'));
      this.$store.dispatch('LOAD_AVAILABLE_DEVICES')
        .catch( error => this.$awn.alert('Доступные устройства не загружены'));
      this.$store.dispatch('LOAD_LIMITED_OBJECTS')
        .catch( error => this.$awn.alert('Объекты с недостатками не загружены'));
      this.$store.dispatch('LOAD_UNREGLAMENTED_DEVICES')
        .catch( error => this.$awn.alert('Оборудование с непроведенными регламентными работами не загружено'));

      this.$store.dispatch('LOAD_CABLE_TYPES')
        .catch( error => this.$awn.alert('Типы кабелей незагружены'));
      this.$store.dispatch('LOAD_USERS')
        .catch( error => this.$awn.alert('Пользователи не загружены'));
      this.$store.dispatch('LOAD_DISTRICTS')
        .catch( error => this.$awn.alert('Участки не загружены'));
    },
  }
</script>

<style>
.pointer{
  cursor:pointer;
}
.fade-enter-active, .fade-leave-active {
  transition: opacity 0.5s;
}
.fade-enter, .fade-leave-to {
  opacity: 0;
}
.wrapper {
  display: block;
}
 .logo {
   align-self: center;
   color: #fff;
   font-weight: bold;
   font-family: 'Lato'
 }
 .main-nav {
   display: flex;
   justify-content: space-between;
   padding: 0.5rem 0.8rem;
 }
 .navbar-brand,.navbar-brand:hover{
   color:#32325d;
 }

</style>