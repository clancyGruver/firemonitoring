<template>
	<div class="container-fluid">
        <new-district-modal />
        <div class="row">
            <button class="btn btn-icon btn-3 btn-success" @click="$modal.show('new-district')">
                <span class="btn-inner--icon"><i class="fas fa-plus"></i></span>
		        <span class="btn-inner--text">Добавить участок</span>
            </button>
        </div>
        <div class="row">
            <div class="col">
                <h3>Участки</h3>
                <div class="row">
                    <ul>
                        <li class="list-unstyled" v-for="district in districts" :key="district.id">
                            <router-link :active-class="'active'" class="nav-link" :to="{ name: 'districtEdit', params: { districtId: district.id, name: district.name} }">
                            <i class="ml-2 fas fa-times text-danger pointer" @click.prevent.stop="delDistrict(district)"></i>
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
import NewDistrictModal from './newModal';

export default {
    components:{NewDistrictModal},
    methods:{
        delDistrict(district){
            if(confirm(`Вы действительно хотите удалить ${district.name}`)){
                this.$store.dispatch('DELETE_DISTRICT',district.id);
            }
        },
    },
	computed:{
		districts() {return this.$store.getters.DISTRICTS},
	}
}
</script>

<style scoped>
</style>