<template>
	<modal name="new-user-district" transition="pop-out">
		<div class="card">
			<div class="card-body">
				<h5 class="card-title">Добавить техника</h5>
        <ul class="list-unstyled">
          <li v-for="user in users" :key="user.id" @click="addUser(user)">{{user.name}}</li>
        </ul>

				<div class="button-set">
					<button type="button" class="btn btn-danger" @click.prevent="cancel">Отмена</button>
				</div>
			</div>
		</div>
	</modal>
</template>
<script>
export default {
  name: 'NewUserDistrictModal',
  props:['currentUsers'],
  data () {
    return {
    }
  },
  methods:{
  	addUser(user){
  		this.$store.dispatch('NEW_USER_DISTRICT',{
        districtId: this.$route.params.districtId,
        user
      })
  					.then(() => this.cancel())
  					.catch(error => {
  						this.$aws.alert('При добавлении пользователя произошли ошибки');
  						console.log(error);
  					});
  	},
  	cancel(){
  		this.name = "";
  		this.$modal.hide('new-user-district');
  	},
  },
  computed:{
    currentUsersIds(){
      return this.currentUsers.length ? this.currentUsers.map(user => user.user.id) : []
    },
    users(){
      return this.$store.getters.USERS.filter( user => !this.currentUsersIds.includes(user.id));
    },
  }
}
</script>

