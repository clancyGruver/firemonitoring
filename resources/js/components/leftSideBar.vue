<template>
	<nav class="navbar navbar-vertical fixed-left navbar-expand-md navbar-light bg-white" id="sidenav-main">
	    <div class="container-fluid">
	        <!-- Toggler -->
	        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#sidenav-collapse-main" aria-controls="sidenav-main" aria-expanded="false" aria-label="Toggle navigation">
	            <span class="navbar-toggler-icon"></span>
	        </button>

			<a class="navbar-brand pt-0" href="./index.html">
				<i class="fas fa-fire text-danger"></i>FIREMONITORING
			</a>
	        <!-- User -->
	        <ul class="nav align-items-center d-md-none">
	            <li class="nav-item dropdown">
	                <div class="dropdown-menu dropdown-menu-arrow dropdown-menu-right">
	                    <div class="dropdown-divider"></div>
	                    <a href="user/logout" class="dropdown-item">
	                        <i class="ni ni-user-run"></i>
	                        <span>Выйти</span>
	                    </a>
	                </div>
	            </li>
	        </ul>
	        <!-- Collapse -->
	        <div class="collapse navbar-collapse" id="sidenav-collapse-main">
	            <!-- Collapse header -->
	            <div class="navbar-collapse-header d-md-none">
	                <div class="row">
	                    <div class="col-6 collapse-brand">
	                        <a href="/">
	                            Firemonitoring
	                        </a>
	                    </div>
	                    <div class="col-6 collapse-close">
	                        <button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#sidenav-collapse-main" aria-controls="sidenav-main" aria-expanded="false" aria-label="Toggle sidenav">
	                            <span></span>
	                            <span></span>
	                        </button>
	                    </div>
	                </div>
	            </div>
	            <!-- Navigation -->
	            <ul class="navbar-nav">
	                <li class="nav-item">
	                    <a class="nav-link" href="/raions">
	                        <i class="ni ni-world text-primary"></i> Районы
	                    </a>
	                </li>
	                <li class="nav-item">
						<router-link :active-class="active" class="nav-link" :to="{ name: 'objects' }">
							<i class="ni ni-building text-primary"></i> Объекты мониторинга
						</router-link>
	                </li>
	                <li class="nav-item">
	                    <a class="nav-link" href="route('user.index')">
	                        <i class="fas fa-users text-primary"></i>Пользователи
	                    </a>
	                </li>
	                <li class="nav-item">
	                    <a class="nav-link" href="#navbar-examples" data-toggle="collapse" role="button" aria-expanded="true" aria-controls="navbar-examples">
	                        <i class="fas fa-cogs" style="color: #f4645f;"></i>
	                        <span class="nav-link-text" style="color: #f4645f;">Оборудование</span>
	                    </a>

	                    <div class="collapse show" id="navbar-examples">
	                        <ul class="nav nav-sm flex-column">
				                <li class="nav-item">
									<router-link :active-class="active" class="nav-link" :to="{ name: 'limitationsIndex' }">
										<i class="fas fa-exclamation-triangle text-primary"></i> Недостатки оборудования
									</router-link>
				                </li>
	                            <li class="nav-item">
	                                <a class="nav-link" href="route('devices')">
	                                    <i class="fas fa-fire text-primary"></i> Охранно-пожарная сигнализация
	                                </a>
	                            </li>
	                            <li class="nav-item">
	                                <a class="nav-link" href="route('sensors')">
	                                    <i class="fas fa-bell text-primary"></i>Извещатели
	                                </a>
	                            </li>
	                            <li class="nav-item">
	                                <a class="nav-link" href="route('antennas')">
	                                    <i class="fas fa-broadcast-tower text-primary"></i>Антенны
	                                </a>
	                            </li>
	                            <li class="nav-item">
	                                <a class="nav-link" href="route('rspi')">
	                                    <i class="fas fa-podcast text-primary"></i>Системы передачи извещений
	                                </a>
	                            </li>
	                            <li class="nav-item">
	                                <a class="nav-link" href="route('sys_alert')">
	                                    <i class="fas fa-microphone-alt text-primary"></i>Системы речевого оповещения
	                                </a>
	                            </li>
	                            <li class="nav-item">
	                                <a class="nav-link" href="route('alert')">
	                                    <i class="fas fa-bullhorn text-primary"></i> Оповещатели
	                                </a>
	                            </li>
	                        </ul>
	                    </div>
	                </li>
	            </ul>
	        </div>
	    </div>
	</nav>
</template>

<script>
export default {
    components: {
    },
    data () {
      return {
      	active: 'active',
      }
    },

    computed: {
    },

    methods: {
    	logout(){
			document.getElementById('logout-form').submit();
    	},
    },
  }
</script>