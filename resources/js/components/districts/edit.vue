<template>
    <div>
        <div  v-if="editName">
            <input type="text" v-model="district.name">
            <i class="ml-2 fas fa-check-circle text-success pointer" @click="saveName"></i>
        </div>
        <h3 v-else @dblclick="edit">{{ district.name }}</h3>
        <users :users="district.users"></users>
        <objects :objects="district.objects"></objects>
    </div>
</template>
<script>
import users from './users';
import objects from './objects';

export default {
    components:{users,objects},
    data:() => {
        return {
            editName:false,
        }
    },
    methods:{
        edit(){
            this.editName = !this.editName;
        },
        saveName(){
            this.$store.dispatch('CHANGE_DISTRICT_NAME',this.district)
                        .then( () => this.edit() );
        },
    },
    computed:{
        district() {
            const id = this.$route.params.districtId;
            return this.$store.getters.DISTRICT(id);
        },
    },
}
</script>
