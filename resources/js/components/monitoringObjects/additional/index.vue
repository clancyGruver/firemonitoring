<template>
    <form class="col-md-6 offset-md-3">
        <div class="form-row">
            <div class="form-group col">
                <label for="soue_type">Тип системы оповещения и управления эвакуацией людей при пожаре</label>
                <select id="soue_type" name="soue_type" class="form-control" v-model="object.soue_type">
                    <option>Выберите тип</option>
                    <option
                        v-for="i in [1,2,3,4,5]"
                        :key="i"
                        :value="i"
                        :selected="object.soue_type == i"
                    >{{ i }}</option>
                </select>
            </div>
        </div>

        <div class="">
            <div class="form-group col custom-control custom-control-alternative custom-checkbox">
                <input
                    class="custom-control-input"
                    id="project_isset"
                    name="project_isset"
                    type="checkbox"
                    v-model="object.project_isset"
                >
                <label class="custom-control-label" for="project_isset">Наличие проекта</label>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group col">
                <label for="project_cipher">Шифр проекта</label>
                <input
                    id="project_cipher"
                    name="project_cipher"
                    type="text"
                    class="form-control"
                    placeholder="Шифр проекта"
                    v-model="object.project_cipher"
                >
            </div>
        </div>
        <div class="form-row">
            <div class="form-group col">
                <label for="project_year">Год проекта</label>
                <input
                    id="project_year"
                    name="project_year"
                    type="number"
                    class="form-control"
                    v-model.number="object.project_year"
                >
            </div>
        </div>


        <div class="form-row">
            <div class="form-group col">
                <button class="btn btn-icon btn-3 btn-success" type="button" @click.prevent="updateObject">
                    <span class="btn-inner--icon"><i class="fas fa-check"></i></span>
                    <span class="btn-inner--text">Сохранить</span>
                </button>
            </div>
        </div>
    </form>
</template>

<script>
export default {
    methods:{

        updateObject() {
            const createdDate = this.object.contract_created_at ? this.object.contract_created_at : null;
            const endsDate = this.object.contract_ends_at ? this.object.contract_ends_at : null;

            if(createdDate){
                this.object.contract_created_at = `${createdDate.getFullYear()}-${createdDate.getMonth() +1 }-${createdDate.getDate()}`;
            }
            if(endsDate){
                this.object.contract_ends_at = `${endsDate.getFullYear()}-${endsDate.getMonth() +1 }-${endsDate.getDate()}`;
            }

            this.$store.dispatch('OBJECT_UPDATE')
                .then( success => this.$awn.success('Данные объекта сохранены'))
                .catch( error => this.$awn.alert('При обновлении данных возникла ошибка'));
        },
    },
    computed: {
        object() {return this.$store.getters.CURRENT_OBJECT},
    }
}
</script>