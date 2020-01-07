<template>
    <div class="card">
        <new-user-modal :currentUsers="users"/>
        <div class="card-body">
            <h4 class="card-title">Техники закрепленные за участком</h4>
            <ul>
                <li v-for="user in users" :key="user.id">
		            <i class="ml-2 fas fa-times text-danger pointer" @click="delUser(user)"></i>
                    {{user.user.name}}
                </li>
            </ul>
            <a href="#" class="btn btn-success" @click.prevent="$modal.show('new-user-district')">Добавить техника</a>
        </div>
    </div>
</template>

<script>
import newUserModal from "./newUserModal";

export default {
    props:['users'],
    components:{newUserModal},
    methods:{
        delUser(user){
            if(confirm(`Вы действительно хотите удалить ${user.user.name}`)){
                this.$store.dispatch('DELETE_DISTRICT_USER',{
                    districtId: this.$route.params.districtId,
                    userId:user.id,
                });
            }
        }
    }
}
</script>
