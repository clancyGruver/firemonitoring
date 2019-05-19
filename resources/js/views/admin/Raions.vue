<template>
  <div class="main-content-container container-fluid px-4">
    <!-- Page Header -->
    <div class="page-header row no-gutters py-4">
      <div class="col-12 col-sm-4 text-center text-sm-left mb-0">
        <span class="text-uppercase page-subtitle">Администрирование</span>
        <h3 class="page-title">Районы</h3>
      </div>
    </div>

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
                  <th scope="col" class="border-0">Отображать</th>
                </tr>
              </thead>
              <tbody>
                <template v-for="(item, index) in items">
                  <tr :key="index">
                    <td>{{index}}</td>
                    <td>{{item.name}}</td>
                    <td>
                      <d-checkbox toggle class="custom-toggle-sm" :checked="!!+item.is_active" v-on:change="changeVisible(item.id, !+item.is_active)"></d-checkbox>
                    </td>
                  </tr>
                </template>
              </tbody>
            </table>
          </div>          
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
    data(){ 
      return {
        items: []
    }},
    methods:{
      changeVisible: function ( id, is_active ) {
          const self = this;
          this.items.map((v,i)=> {if(v.id == id) self.items[i]['is_active'] = is_active} );
          axios
          .post(`/api/raions/${id}`,{ is_active:is_active ? 1 : 0 })
          .then(response => console.log(response))
          .catch()
        }
    },
    mounted: function () {
      const self = this;
      this.$nextTick(function () {
        axios
        .get('/api/raions')
        .then( response => response.data.map(v=>self.items.push(v)) );
        })
    }
}
</script>