<template>
    <div class="card">
        <div class="card-body">
            <h4 class="card-title">Объекты закрепленные на участке</h4>
            <ul>
                <li v-for="object in objects" :key="object.id">
                    <i class="ml-2 fas fa-times text-danger pointer" @click="delObject(object)"></i>
                    {{object.object.name}}
                </li>
            </ul>
        </div>
    </div>
</template>

<script>
export default {
    props:['objects'],
    methods:{
        delObject(object){
            if(confirm(`Вы действительно хотите удалить ${object.object.name}`)){
                this.$store.dispatch('DELETE_DISTRICT_OBJECT',{
                    districtId: this.$route.params.districtId,
                    objectId:object.id,
                });
            }
        }
    }
}
</script>
