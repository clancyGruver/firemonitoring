<template>
  <form class="form-inline">
    <input type="text" class="form-control mb-3 mr-sm-2" placeholder="Недостаток" v-model.trim="additionalLimit">

    <div class="custom-control custom-control-alternative custom-checkbox mb-3">
      <input
        class="custom-control-input"
        :id="`isCritical-${id}`"
        name="isCritical"
        type="checkbox"
        v-model="isCritical"
        @click="clickHandler"
      >
      <label class="custom-control-label" :for="`isCritical-${id}`">Критично</label>
    </div>
		<button type="button" class="btn btn-outline-danger ml-1 mb-3" @click.prevent="delLimit">
      <span v-if="isNew()">Удалить</span>
      <span v-else>Устранено</span>
    </button>
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
    clickHandler(){
      console.log(this.id);
    },
    isNew(){
      return `${this.id}`.startsWith('tempid');
    },
    delLimit(){
      this.$emit('deleteLimit',this.id);
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