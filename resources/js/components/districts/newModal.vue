<template>
	<modal name="new-district" transition="pop-out">
		<div class="card">
			<div class="card-body">
				<h5 class="card-title">Новый участок</h5>
				<form autocomplete="false">
			      <div class="form-group">
			        <input type="text" placeholder="Название участка" class="form-control form-control-alternative" v-model="name" />
			      </div>
				</form>

				<div class="button-set">
					<button type="button" class="btn btn-success" @click.prevent="add">Добавить</button>
					<button type="button" class="btn btn-danger" @click.prevent="cancel">Отмена</button>
				</div>
			</div>
		</div>
	</modal>
</template>
<script>
export default {
  name: 'NewDistrictModal',
  data () {
    return {
    	name:"",
    }
  },
  methods:{
  	add(){
      if(!this.name){
        this.$aws.alert('Название участка не может быть пустым');
      }
  		this.$store.dispatch('NEW_DISTRICT',{name: this.name})
  					.then(() => this.cancel())
  					.catch(error => {
  						this.$aws.alert('При добавлении участка произошли ошибки');
  						console.log(error);
  					});
  	},
  	cancel(){
  		this.name = "";
  		this.$modal.hide('new-district');
  	},
  }
}
</script>

