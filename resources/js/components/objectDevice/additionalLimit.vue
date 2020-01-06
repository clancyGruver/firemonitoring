<template>
  <form class="form-inline">
    <input type="text" class="form-control mb-3 mr-sm-2" placeholder="Недостаток" v-model.trim="additionalLimit">

    <div class="custom-control custom-control-alternative custom-checkbox mb-3">
      <input class="custom-control-input" id="customCheck6" type="checkbox" v-model="isCritical">
      <label class="custom-control-label" for="customCheck6">Критично</label>
    </div>
		<button type="button" class="btn btn-alert mt-4" @click.prevent="delLimit">Устранено</button>
  </form>
</template>

<script>
export default{
  props:[
    'id',
    'text',
    'critical'
  ],
  data() {
    return {
      additionalLimit: this.text,
      isCritical: Boolean(this.critical) || false,
    }
  },
  watch:{
    additionalLimit: function(){this.updateLimit();},
    isCritical: function(){this.updateLimit();},
  },
  methods:{
    delLimit(){
      this.$emit('deleteLimit',obj)
    },
    updateLimit(){
      const obj = {
        id: this.id,
        additionalLimit: this.additionalLimit,
        isCritical: this.isCritical,

      };
      this.$emit('updateLimit',obj);
    },
  }

}
</script>