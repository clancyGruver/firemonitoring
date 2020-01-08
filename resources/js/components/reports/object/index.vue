<template>
    <ul>
        <li @click="serviceAct()" class="pointer">
            Акт исправности
            <span v-if="serviceability">
                <a href="/Акт исправности.docx">Скачать</a>
            </span>
        </li>
    </ul>
</template>

<script>
export default {
data:function(){ return {
    serviceability: false,
}},
methods:{
    serviceAct: function() {
        this.$awn.success('Идет комплектование данных');
        axios.post(`/api/word/serviceabilityAct/${this.$route.params.id}`)
            .then( response => {
                this.serviceability = true;
                this.$store.state.current_object.mediafiles.push(response.data);
                this.$awn.success('Отчет сформирован');
            })
            .catch( alert => this.$awn.alert(alert))
    }
}
}
</script>

<style>

</style>
