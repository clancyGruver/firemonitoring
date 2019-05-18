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
              <a href="#" class="btn btn-lg" @click.prevent="createItem()">
                <span class="d-none d-md-inline-block">
                    <i class="material-icons text-primary">add</i> Добавить объект мониторинга
                </span>
              </a>
            </h5>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
    data: {
        items: [],
        hasError: true,
        newItem: { 'name': '','age': '','profession': '' },
    },
    methods:{
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
    }
}
</script>