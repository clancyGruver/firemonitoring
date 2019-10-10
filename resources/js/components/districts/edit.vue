<template>
    <div>
        <h3>{{ district.name }}</h3>
        <users :users="district.users"></users>
    </div>
</template>
<script>
import users from './users';

export default {
    components:{users},
    computed:{
        district() {
            const id = this.$route.params.districtId;
            return this.$store.getters.DISTRICT(id);
        },
    },
}
</script>
