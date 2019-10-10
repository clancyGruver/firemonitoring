<template>
	<div class="container-fluid">
        <div class="row">
            <button class="btn btn-icon btn-3 btn-success">
                <span class="btn-inner--icon"><i class="fas fa-plus"></i></span>
		        <span class="btn-inner--text">Добавить объект</span>
            </button>
        </div>
        <div class="row">
            <div class="col">
                <h3>Участки</h3>
                <div class="row" v-for="district in districts" :key="district.id">
                    <ul>
                        <li class="list-unstyled">
                            <router-link :active-class="'active'" class="nav-link" :to="{ name: 'districtEdit', params: { districtId: district.id, name: district.name} }">
                                {{district.name}}
                            </router-link>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="col">
                <transition name="slide">
                <router-view></router-view>
                </transition>
            </div>
        </div>		
	</div>    
</template>

<script>
export default {
	computed:{
		districts() {return this.$store.getters.DISTRICTS},
	}
}
</script>

<style scoped>
</style>