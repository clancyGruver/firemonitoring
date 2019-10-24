<template>
	<div>
        <Map
            :lat="object.lat"
            :lng="object.lng"
            @change="setCoordsHandler"
        />
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
                        v-model.trim="object.name"
                    >
                </div>
            </div>

            <div class="form-row">
                <div class="form-group col">
                    <label for="raion_id">Район</label>
                    <select
                        id="raion_id"
                        name="raion_id"
                        class="form-control"
                        v-model="object.raion_id"
                        @change="raionChangeHandler"
                    >
                        <option disabled>Выберите муниципальное образование</option>
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

            <div class="form-row" v-show="object.raion_id">
                <div class="form-group col">
                    <label for="address">Адрес объекта мониторинга</label>
                    <suggestions
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

            <div class="form-row" v-show="object.project_isset">
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
            <div class="form-row" v-show="object.project_isset">
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
	</div>
</template>

<script>
import suggestions from '../../leaflet/suggetion';
import Map from '../../leaflet/mapWithProps';

export default {
    components: { suggestions, Map},
	data() {
		return {
            object:{
                name: '',
                raion_id: 0,
                address: '',
                contact_name: '',
                contact_phone: '',
                director_name: '',
                director_phone: '',
                project_isset: 0,
                project_cipher: '',
                project_year: 0,
                soue_type: 0,
                lat: '55.1598970',
                lng: '61.4025540',
            },
		}
	},
	methods:{
        raionChangeHandler(val){
            const raion = this.raions.find( raion => raion.id == val.target.value );
            this.object.lat = raion.lat;
            this.object.lng = raion.lng;
        },
        check(){
            const errors = [];
            if(!this.object.name){
                errors.push('Не введено название объекта');
            }
            if(!this.object.raion_id){
                errors.push('Не выбран район');
            }
            if(!this.object.address){
                errors.push('Не введен адрес');
            }
            if(!this.object.lng || !this.object.lat){
                errors.push('Не введены координаты объекта');
            }
            if(!this.object.director_name){
                errors.push('Не введено ФИО руководителя');
            }
            if(!this.object.director_phone){
                errors.push('Не введен телефон руководителя');
            }
            if(errors.length > 0){
                errors.map( error => this.$awn.alert(error) );
                return false;
            }
            return true;
        },
        setCoordsHandler(obj){
            this.object.lat = obj.lat;
            this.object.lng = obj.lng;
        },
        updateAdressHandler(obj){
            this.object.address = obj.address;
            this.object.lat = obj.lat;
            this.object.lng = obj.lng;
        },
        updateObject() {
            if(this.check()){
                this.$store.dispatch('ADD_NEW_OBJECT',this.object)
                    .then( success => this.$awn.success('Данные объекта сохранены'))
                    .catch( error => this.$awn.alert('При обновлении данных возникла ошибка'));
            }
        },
	},
	computed: {
        raions() {return this.$store.getters.RAIONS},
	}
}
</script>

<style scoped>

</style>
