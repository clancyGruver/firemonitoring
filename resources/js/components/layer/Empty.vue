<template>
  <d-container fluid>
    <d-row>
      <d-col class="main-content offset-lg-2 offset-md-3 p-0" tag="main" lg="10" md="9" sm="12">
        <!-- Content -->
        <slot>
      </d-col>
    </d-row>
  </d-container>
</template>

<script>
export default {
  name: 'empty',
  components: {
  },
  data() {
    return {
      isLoggedIn : null,
      name : null,
      is_admin: null
    };
  },
  mounted(){
      this.isLoggedIn = localStorage.getItem('jwt')
      this.name = localStorage.getItem('user')
      this.is_admin = localStorage.getItem('is_admin')
  }
};
</script>

