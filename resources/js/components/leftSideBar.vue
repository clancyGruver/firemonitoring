<template>
	<nav class="sidebar">
        <div class="sidebar-backdrop" @click="closeSidebarPanel" v-if="isPanelOpen"></div>
        <transition name="slide">
            <div v-if="isPanelOpen" class="sidebar-panel">
		        <!-- Navigation -->
		        <ul class="sidebar-panel-nav">
		            <li class="nav-item">
						<router-link
							class="nav-link"
							:active-class="active"
							:to="{
		                    	name: 'raionIndex'
		                  	}"
		              	>
							<i class="ni ni-world text-primary"></i> Районы
						</router-link>
		            </li>
		            <li class="nav-item">
						<router-link
							class="nav-link"
							:active-class="active"
							:to="{
		                    	name: 'districts'
		                  	}"
		              	>
							<i class="ni ni-world text-primary"></i> Рабочие участки
						</router-link>
		            </li>
		            <li class="nav-item">
						<router-link :active-class="active" class="nav-link" :to="{
		                name: 'objects',
		                params:{
		                  mode:'all'
		                }
		              }">
							<i class="ni ni-building text-primary"></i> Объекты мониторинга
						</router-link>
		            </li>
		            <li class="nav-item">
						<router-link
							class="nav-link"
							:active-class="active"
							:to="{
		                        name: 'usersIndex'
		              		}"
		              	>
							<i class="fas fa-users text-primary"></i> Пользователи
						</router-link>
		            </li>
		            <li class="nav-item">
		                <a class="nav-link pointer" role="button" @click.prevent="deviceCollapsed = !deviceCollapsed">
		                    <i class="fas fa-cogs" style="color: #f4645f;"></i>
		                    <span class="nav-link-text" style="color: #f4645f;">Оборудование</span>
		                </a>

		                <div
		                	class="collapse"
							:class="[
								deviceCollapsed ? 'show' : '',
							]"
		                	id="devices"
		                >
		                    <ul class="nav nav-sm flex-column">
				                <li class="nav-item">
									<router-link :active-class="active" class="nav-link" :to="{ name: 'reglamentsIndex' }">
										  <i class="fas fa-cog text-primary"></i>
										  Регламентные работы оборудования
									</router-link>
				                </li>

				                <li class="nav-item">
									<router-link :active-class="active" class="nav-link" :to="{ name: 'limitationsIndex' }">
										<i class="fas fa-exclamation-triangle text-primary"></i> Недостатки оборудования
									</router-link>
				                </li>
		                        <li class="nav-item">
									<router-link
										class="nav-link"
										:active-class="active"
										:to="{
											path:`/devices/aps`,
											params: {
												device_type: 'aps',
											}
										}"
									>
										<i class="fas fa-exclamation-triangle text-primary"></i> Охранно-пожарная сигнализация
									</router-link>
		                        </li>
		                        <li class="nav-item">
									<router-link
										class="nav-link"
										:active-class="active"
										:to="{
											path:`/devices/sensors`,
											params: {
												device_type: 'sensors'
											}
										}"
									>
		                                <i class="fas fa-bell text-primary"></i>Извещатели
									</router-link>
		                        </li>
		                        <li class="nav-item">
									<router-link
										class="nav-link"
										:active-class="active"
										:to="{
											path:`/devices/antennas`,
											params: {
												device_type: 'antennas'
											}
										}"
									>
										<i class="fas fa-broadcast-tower text-primary"></i>Антенны
									</router-link>
		                        </li>
		                        <li class="nav-item">
									<router-link
										class="nav-link"
										:active-class="active"
										:to="{
											path:`/devices/rspi`,
											params: {
												device_type: 'rspi'
											}
										}"
									>
										<i class="fas fa-podcast text-primary"></i>Системы передачи извещений
									</router-link>
		                        </li>
		                        <li class="nav-item">
									<router-link
										class="nav-link"
										:active-class="active"
										:to="{
											path:`/devices/voice_alerts`,
											params: {
												device_type: 'voice_alerts',
											}
										}"
									>
										<i class="fas fa-microphone-alt text-primary"></i>Системы речевого оповещения
									</router-link>
		                        </li>
		                        <li class="nav-item">
									<router-link
										class="nav-link"
										:active-class="active"
										:to="{
											path:`/devices/alerts`,
											params: {
												device_type: 'alerts',
											}
										}"
									>
										<i class="fas fa-bullhorn text-primary"></i> Оповещатели
									</router-link>
		                        <li class="nav-item">
									<router-link
										class="nav-link"
										:active-class="active"
										:to="{
											path:`/devices/power_supply`,
											params: {
												device_type: 'power_supply',
											}
										}"
									>
										<i class="fas fa-battery-full text-primary"></i> Блоки питания
									</router-link>
		                        </li>
		                    </ul>
		                </div>
		            </li>
		        </ul>
            </div>
        </transition>

	</nav>
</template>

<script>
export default {
    components: {
    },
    data () {
      return {
      	active: 'active',
      	deviceCollapsed: false,
      	collapseShow: false
      }
    },

    computed: {
        isPanelOpen(){return this.$store.state.sideBarACtive;}
    },

    methods: {
    	logout(){
			document.getElementById('logout-form').submit();
    	},
        closeSidebarPanel() {this.$store.commit('TOGGLE_SIDEBAR');}
    },
  }
</script>

<style>
    .slide-enter-active,.slide-leave-active{transition: transform 0.2s ease;}
    .slide-enter,.slide-leave-to {
        transform: translateX(-100%);
        transition: all 150ms ease-in 0s
    }
    .sidebar-backdrop {
        background-color: rgba(0,0,0,.5);
        width: 100vw;
        height: 100vh;
        position: fixed;
        top: 0;
        left: 0;
        cursor: pointer;
        z-index: 1000;
    }
    .sidebar-panel {
        overflow-y: auto;
        background-color: #130f40;
        position: fixed;
        left: 0;
        top: 0;
        height: 100vh;
        z-index: 999;
        padding: 1rem 0;
        width: 300px;
        z-index: 1001;
    }
 ul.sidebar-panel-nav {
   list-style-type: none;
 }

 ul.sidebar-panel-nav > li > a {
   color: #fff;
   text-decoration: none;
   font-size: 1rem;
   display: block;
   padding-bottom: 0.5em;
 }
</style>