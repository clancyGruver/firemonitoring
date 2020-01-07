<template>
    <ul>
        <li @click="serviceAct()">
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
            .then( success => {
                this.serviceability = true;
                this.$awn.success('Отчет сформирован');
            })
            .catch( alert => this.$awn.alert(alert))
    }
}
}
</script>

<style>

</style>
