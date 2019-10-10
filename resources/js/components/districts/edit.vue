<template>
    <div>
        <h3>{{ district.name }}</h3>
    </div>
</template>
<script>
export default {
    
    computed:{
        district() {
            const id = this.$route.params.districtId;
            return this.$store.getters.DISTRICT(id);
        },
    },
}
</script>
