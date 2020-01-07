<template>
	<section>
		<div class="row mb-3">
           	<router-link :to="{name:'userEdit'}" class="btn btn-icon btn-3 btn-success" type="button">
           		<span class="btn-inner--icon"><i class="fas fa-plus"></i></span>
				<span class="btn-inner--text">Добавить пользователя</span>
           	</router-link>
		</div>
		<div class="row">
		    <div class="table-responsive">
		        <table class="table align-items-center table-flush">
		            <thead class="thead-light">
		                <tr>
		                    <th scope="col">Имя</th>
		                    <th scope="col">Телефон</th>
		                    <th scope="col">Права администратора</th>
		                    <th scope="col">Дата создания</th>
		                    <th scope="col">Район</th>
		                    <th scope="col"></th>
		                </tr>
		            </thead>
		            <tbody>
		                    <tr v-for="user in users" :ket="user.id">
		                        <td>{{ user.name }}</td>
		                        <td>
		                            {{ user.phone }}
		                        </td>
		                        <td>
		                                <strong v-if="user.is_admin">Да</strong>
		                                <span v-else >нет</span>
		                        </td>
		                        <td>{{ user.created_at }}</td>
		                        <td>{{ user.raion_id }}</td>
		                        <td class="text-right">
			                       	<router-link
			                       		data-toggle="tooltip"
	                        			data-placement="top"
	                        			title="Редактировать"
                        			 	class="btn edit-btn"
			                       		:to="{
			                       			name:'userEdit',
			                       			params:{
												user:user
				                       		}
			                       		}"
			                       	>
			                       		<i class="fas fa-edit text-warning"></i>
			                       	</router-link>
			                       	<a
			                       		data-toggle="tooltip"
	                        			data-placement="top"
	                        			title="Удалить"
                        			 	class="btn delete-btn"
	                        			@click.prevent="deleteUser(user)"
	                        		>
	                        			<i class="fas fa-trash-alt text-danger"></i>
			                       	</a>
		                        </td>
		                    </tr>
		            </tbody>
		        </table>
		    </div>
		</div>
	</section>
</template>

<script>
export default{
	methods:{
		deleteUser(user){
			if(confirm(`Удалиить пользователя: ${user.name}?`)){
				this.$store.dispatch('DELETE_USER',user)
					.then( success => this.$awn.success('Пользователь удален') )
        			.catch( error => this.$awn.alert('Во время удаления пользователя произошли ошибки'));
			}
			return false;
		}
	},
	computed:{
		users(){return this.$store.getters.USERS;},
		currentUser(){return this.$store.getters.CURRENT_USER;},
	}
}
</script>

<style scoped>

</style>