<template>
  <div class="main-content-container container-fluid px-4">
    <!-- Page Header -->
    <div class="page-header row no-gutters py-4">
      <div class="col-12 col-sm-4 text-center text-sm-left mb-0">
        <span class="text-uppercase page-subtitle">Администрирование</span>
        <h3 class="page-title">объекты мониторинга</h3>
      </div>
    </div>

    <p class="text-center alert alert-danger"
    v-bind:class="{ hidden: hasError }">Please fill all fields!</p>

    <!-- Default Light Table -->
    <div class="row">
      <div class="col">
        <div class="card card-small mb-4">
          <div class="card-body p-0 pb-3 text-center">
            <table class="table mb-0">
              <thead class="bg-light">
                <tr>
                  <th scope="col" class="border-0">#</th>
                  <th scope="col" class="border-0">Наименование</th>
                  <th scope="col" class="border-0">Район</th>
                  <th scope="col" class="border-0">Адрес</th>
                  <th scope="col" class="border-0">Директор</th>
                  <th scope="col" class="border-0">Контактное лицо</th>
                  <th scope="col" class="border-0"></th>
                </tr>
              </thead>
              <tbody>
                
              </tbody>
            </table>
          </div>          
            <h5 class="card-footer">
              <a href="#" class="btn btn-lg" @click.prevent="handleModal">
                <span class="d-none d-md-inline-block">
                    <i class="material-icons text-primary">add</i> Добавить объект мониторинга
                </span>
              </a>
            </h5>
        </div>
      </div>
    </div>

    <d-modal v-if="showModal" @close="handleModal">
        <d-modal-header>
            <d-modal-title>Добавление объекта мониторинга</d-modal-title>
        </d-modal-header>
        <d-modal-body>
          <d-container fluid>
            <d-row class="my-1">
              <d-col sm="3"><label for="name">Название</label></d-col>
              <d-col sm="9"><d-input id="name" v-model="newItem.name" type="text" > </d-input></d-col>
            </d-row>

            <d-row class="my-1">
              <d-col sm="3"><label for="raion">Район</label></d-col>
              <d-col sm="9"> <d-select id="raion" v-model="newItem.raion" :options="raions" /></d-col>
            </d-row>

            <d-row class="my-1">
              <d-col sm="3"><label for="address">Адрес</label></d-col>
              <d-col sm="9"><d-input id="address" v-model="newItem.address" type="text" > </d-input></d-col>
            </d-row>

            <d-row class="my-1">
              <d-col sm="3"><label for="director_name">ФИО директора</label></d-col>
              <d-col sm="9"><d-input id="director_name" v-model="newItem.director_name" type="text" > </d-input></d-col>
            </d-row>
            <d-row class="my-1">
              <d-col sm="3"><label for="director_phone">Телефон директора</label></d-col>
              <d-col sm="9"><d-input id="director_phone" v-model="newItem.director_phone" type="tel" > </d-input></d-col>
            </d-row>

            <d-row class="my-1">
              <d-col sm="3"><label for="contact_name">ФИО ответственного</label></d-col>
              <d-col sm="9"><d-input id="contact_name" v-model="newItem.contact_name" type="text" > </d-input></d-col>
            </d-row>
            <d-row class="my-1">
              <d-col sm="3"><label for="contact_phone">Телефон ответственного</label></d-col>
              <d-col sm="9"><d-input id="contact_phone" v-model="newItem.contact_phone" type="tel" > </d-input></d-col>
            </d-row>
          </d-container>           
        </d-modal-body>
        <d-modal-footer>
            <a href="#" class="btn btn-lg" @click.prevent="handleModal">
              <span class="d-none d-md-inline-block">
                  <i class="material-icons text-primary">add</i> Добавить объект мониторинга
              </span>
            </a>
        </d-modal-footer>
    </d-modal>
  </div>
</template>

<script>
export default {
    data: function(){ return{
        items: [],
        hasError: false,
        showModal: true,
        raions: [],
        newItem: { 
          'name': '',
          'raion': '',
          'address': '',
          'director_name': '',
          'director_phone': '',
          'contact_name': '',
          'contact_phone': '',
        },
    }},
    methods:{
      handleModal() {this.showModal = !this.showModal},
        createItem: function createItem() {
            var _this = this;
            var input = this.newItem;
            
            if (input['name'] == '' || input['age'] == '' || input['profession'] == '' ) {
                this.hasError = false;
            } else {
                this.hasError = true;
                axios.post('/vueitems', input).then(function (response) {
                _this.newItem = { 'name': '' };
                _this.getVueItems();
                });
            }
        }
    },
    mounted: function () {
      const self = this;
      this.$nextTick(function () {
        axios
        .get('/api/raions')
        .then( response => response.data.map( v => { if (v.is_active == 1) self.raions.push({'value': v.id, 'text': v.name }) } ) );
        })
    }
}
</script>