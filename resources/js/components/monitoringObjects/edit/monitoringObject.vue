<template>
	<div>
        <form class="col-md-6 offset-md-3">
            <div class="form-row">
                <div class="form-group col">
                <label for="name">Название объекта мониторинга</label>
                    <input
                        id="name"
                        name="name"
                        type="text"
                        class="form-control"
                        placeholder="Название объекта мониторинга"
                        v-model="object.name"
                    >
                </div>
            </div>

            <div class="form-row">
                <div class="form-group col">
                    <label for="raion_id">Район</label>
                    <select id="raion_id" name="raion_id" class="form-control" v-model="object.raion_id">
                        <option>Выберите муниципальное образование</option>
                        <option
                            v-for="raion in raions"
                            :key="raion.id"
                            :value="raion.id"
                            :selected="raion.id == object.raion_id"
                            >
                                {{ raion.name }}
                            </option>
                    </select>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group col">
                    <label for="address">Адрес объекта мониторинга</label>
                    <input
                        id="address"
                        name="address"
                        type="text"
                        class="form-control"
                        placeholder="Адрес объекта мониторинга"
                        v-model="object.address"
                    >
                </div>
            </div>

            <div class="form-row">
                <div class="form-group col">
                    <label for="director_name">ФИО директора</label>
                    <input
                        id="director_name"
                        name="director_name"
                        type="text"
                        class="form-control"
                        placeholder="ФИО директора"
                        v-model="object.director_name"
                    >
                </div>
                <div class="form-group col">
                    <label for="director_phone">Телефон директора</label>
                    <input
                        id="director_phone"
                        name="director_phone"
                        type="text"
                        class="form-control"
                        placeholder="Телефон директора"
                        v-model="object.director_phone"
                    >
                </div>
            </div>

            <div class="form-row">
                <div class="form-group col">
                    <label for="contact_name">ФИО ответственного</label>
                    <input
                        id="contact_name"
                        name="contact_name"
                        type="text"
                        class="form-control"
                        placeholder="ФИО ответственного"
                        v-model="object.contact_name"
                    >
                </div>
                <div class="form-group col">
                    <label for="contact_phone">Телефон ответственного</label>
                    <input
                        id="contact_phone"
                        name="contact_phone"
                        type="text"
                        class="form-control"
                        placeholder="Телефон ответственного"
                        v-model="object.contact_phone"
                    >
                </div>
            </div>

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
                        <span class="btn-inner--text">Обновить</span>
                    </button>
                </div>
            </div>
        </form>

        <hr class="mt-4 mb-4"/>
        <media-file-list :header="'Планы БТИ'" :fileList="object.btifiles" :type="'bti_files'" />

        <hr class="mt-4 mb-4"/>
        <media-file-list :header="'Медиафайлы'" :fileList="object.mediafiles" :type="'media'" />
	</div>
</template>

<script>
import MediaFileList from '../mediaFilelist';

export default {
	props:{
    },

	data() {
		return {
		}
	},

	components:{MediaFileList},

	mounted: function(){
	},

	methods:{
        updateObject() {
            this.$store.commit('OBJECT_UPDATE');
        },
	},

	computed: {
        raions() {return this.$store.getters.RAIONS},
        object() {return this.$store.getters.CURRENT_OBJECT},
	}
}
</script>

<style scoped>

</style>
