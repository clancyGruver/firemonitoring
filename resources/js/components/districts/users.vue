<template>
    <div class="card">
        <div class="card-body">
            <h4 class="card-title">Техники закрепленные за участком</h4>
            <ul>
                <li v-for="user in users" :key="user.id">
		            <button type="button" class="btn btn-outline-danger col-2" @click="delUser(user)">Удалить</button>
                    {{user.user.name}}
                </li>
            </ul>
            <a href="#" class="btn btn-primary">Go somewhere</a>
        </div>
    </div>
</template>

<script>
export default {
    props:['users'],
    methods:{
        delUser(user){
            if(confirm(`Вы действительно хотите удалить ${user.user.name}`)){
                $this.store.dispatch('DELETE_DISTRICT_USER',id);
            }
        }
    }
}
</script>
