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
                    <suggestions
                        :defaultValue="object.address"
                        @update="updateAdressHandler"
                    />
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
            <hr />
            <div class="form-inline">
                <input type="text" class="form-control mb-2 mr-sm-2" id="contractId" v-model.trim="object.contract_id" placeholder="Номер договора">

                <date-picker
                    v-model="object.contract_created_at"
                    placeholder="Дата подписания"
                    lang="ru"
                />

                <date-picker
                    v-model="object.contract_ends_at"
                    placeholder="Дата окончания"
                    lang="ru"
                />
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
	</div>
</template>

<script>
import suggestions from '../../leaflet/suggetion';
import DatePicker from 'vue2-datepicker';

export default {
	data() {
		return {
		}
	},
	components:{suggestions, DatePicker},
	methods:{
        updateAdressHandler(obj){
            this.object.address = obj.address;
            this.object.lat = obj.lat;
            this.object.lng = obj.lng;
        },
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
        raions() {return this.$store.getters.RAIONS},
        object() {return this.$store.getters.CURRENT_OBJECT},
	}
}
</script>

<style scoped>

</style>
