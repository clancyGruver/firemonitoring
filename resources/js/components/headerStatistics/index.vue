<template>
	<div class="header bg-gradient-primary pb-8 pt-5 pt-md-8">
      <div class="container-fluid">
        <div class="header-body">
          <!-- Card stats -->
          <div class="row">
            <div class="col-xl-3 col-lg-6">
              <div class="card card-stats mb-4 mb-xl-0">
                <div class="card-body">
                  <div class="row">
                    <div class="col">
                      <h5 class="card-title text-uppercase text-muted mb-0">Объектов мониторинга</h5>
                      <span class="h2 font-weight-bold mb-0">{{ monitoring_objects && monitoring_objects > 0 ? monitoring_objects : 0 }}</span>
                    </div>
                    <div class="col-auto">
                      <div class="icon icon-shape bg-info text-white rounded-circle shadow">
                        <i class="ni ni-building"></i>
                      </div>
                    </div>
                  </div>
                  <p class="mt-3 mb-0 text-muted text-sm">
                    <font-loader v-if="MOLoaded" />
                    <router-link
                      v-else
                      :to="{
                        name: 'objects',
                        params:{
                          mode:'all'
                        }
                      }"
                    >
                      Перейти
                    </router-link>
                  </p>
                </div>
              </div>
            </div>
            <div class="col-xl-3 col-lg-6">
              <div class="card card-stats mb-4 mb-xl-0">
                <div class="card-body">
                  <div class="row">
                    <div class="col">
                      <h5 class="card-title text-uppercase text-muted mb-0">Объектов с неисправным оборудованием</h5>
                      <span class="h2 font-weight-bold mb-0">{{ limited_objects.devices ? limited_objects.devices.length : 0 }}</span>
                    </div>
                    <div class="col-auto">
                      <div class="icon icon-shape bg-danger text-white rounded-circle shadow">
                        <i class="ni ni-building"></i>
                      </div>
                    </div>
                  </div>
                  <p class="mt-3 mb-0 text-muted text-sm">
                    <font-loader v-if="LOLoaded" />
                    <router-link
                      v-else
                      :to="{
                        name: 'objects',
                        params:{
                          mode:'devices'
                        }
                      }"
                    >
                    Перейти
                    </router-link>
                  </p>
                </div>
              </div>
            </div>

            <div class="col-xl-3 col-lg-6">
              <div class="card card-stats mb-4 mb-xl-0">
                <div class="card-body">
                  <div class="row">
                    <div class="col">
                      <h5 class="card-title text-uppercase text-muted mb-0">Объектов с неисправными извещателями</h5>
                      <span class="h2 font-weight-bold mb-0">{{ limited_objects.sensors ? limited_objects.sensors.length : 0 }}</span>
                    </div>
                    <div class="col-auto">
                      <div class="icon icon-shape bg-danger text-white rounded-circle shadow">
                        <i class="ni ni-building"></i>
                      </div>
                    </div>
                  </div>
                  <p class="mt-3 mb-0 text-muted text-sm">
                    <font-loader v-if="LOLoaded" />
                    <router-link
                      v-else
                      :to="{
                        name: 'objects',
                        params:{
                          mode:'sensors'
                        }
                      }"
                    >
                    Перейти
                    </router-link>
                  </p>
                </div>
              </div>
            </div>
            <div class="col-xl-3 col-lg-6">
              <div class="card card-stats mb-4 mb-xl-0">
                <div class="card-body">
                  <div class="row">
                    <div class="col">
                      <h5 class="card-title text-uppercase text-muted mb-0">Объектов с несоответствием СП5</h5>
                      <span class="h2 font-weight-bold mb-0">{{ limited_objects.sp5 ? limited_objects.sp5.length : 0 }}</span>
                    </div>
                    <div class="col-auto">
                      <div class="icon icon-shape bg-danger text-white rounded-circle shadow">
                        <i class="ni ni-building"></i>
                      </div>
                    </div>
                  </div>
                  <p class="mt-3 mb-0 text-muted text-sm">
                    <font-loader v-if="LOLoaded" />
                    <router-link
                      v-else
                      :to="{
                        name: 'objects',
                        params:{
                          mode:'sp5'
                        }
                      }"
                    >
                    Перейти
                    </router-link>
                  </p>
                </div>
              </div>
            </div>
          </div>

          <div class="row mt-2">

            <div class="col-xl-3 col-lg-6">
              <div class="card card-stats mb-4 mb-xl-0">
                <div class="card-body">
                  <div class="row">
                    <div class="col">
                      <h5 class="card-title text-uppercase text-muted mb-0">Объекты, требующие проведения регламентных работ</h5>
                      <span class="h2 font-weight-bold mb-0">{{ unreglamented_objects ? unreglamented_objects.length : 0 }}</span>
                    </div>
                    <div class="col-auto">
                      <div class="icon icon-shape bg-danger text-white rounded-circle shadow">
                        <i class="ni ni-building"></i>
                      </div>
                    </div>
                  </div>
                  <p class="mt-3 mb-0 text-muted text-sm">
                    <font-loader v-if="UOLoaded" />
                    <router-link
                      v-else
                      :to="{
                        name: 'objects',
                        params:{
                          mode:'unreglamented'
                        }
                      }"
                    >
                    Перейти
                    </router-link>
                  </p>
                </div>
              </div>
            </div>

          </div>
        </div>
      </div>
    </div>
</template>

<script>
  import FontLoader from '../fontLoader';

  export default {
    components: {FontLoader},
    data () {
      return {
      }
    },

    computed: {
      monitoring_objects(){return this.$store.getters.OBJECTS.length},
      limited_objects(){return this.$store.getters.LIMITED_OBJECTS},
      unreglamented_devices(){return this.$store.getters.UNREGLAMENTED_DEVICES},
      unreglamented_objects(){return this.$store.getters.UNREGLAMENTED_DEVICES_OBJECTS},
      MOLoaded(){return this.$store.state.indexLoadres.monitoringObjectsLoading},
      LOLoaded(){return this.$store.state.indexLoadres.limitedObjectsLoading},
      UDLoaded(){return this.$store.state.indexLoadres.unreglamentedDevicesLoading},
      UOLoaded(){return this.$store.state.indexLoadres.unreglamentedObjectsLoading},
    },

    methods: {
    },

    mounted: async function(){
    },
  }
</script>

<style>
</style>