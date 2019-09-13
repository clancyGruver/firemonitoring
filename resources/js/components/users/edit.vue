<template>
	<section>
        <div class="card-body">
            <h6 class="heading-small text-muted mb-4">Информация о пользователе</h6>
            <div class="pl-lg-4">
                <div class="form-group">
                    <label class="form-control-label" for="input-name">Имя</label>
                    <input
                    	type="text"
                    	name="name"
                    	id="input-name"
                    	class="form-control form-control-alternative"
                    	placeholder="Имя"
                    	required
                    	v-model.trim="user.name"
                    >
                </div>
                <div class="form-group">
                    <label class="form-control-label" for="input-phone">Телефон</label>
                    <input
                    	type="tel"
                    	name="phone"
                    	id="input-phone"
                    	class="form-control form-control-alternative"
                    	placeholder="Телефон"
                    	required
                    	v-model.number="user.phone"
                    >
                </div>
                <div class="form-group">
                    <label class="form-control-label" for="input-password">Пароль</label>
                    <input
                    	type="password"
                    	name="password"
                    	id="input-password"
                    	class="form-control form-control-alternative"
                    	placeholder="Пароль"
                    	v-model.trim="user.password"
                    >
                </div>
                <div class="form-group">
                    <label class="form-control-label" for="input-password-confirmation">Подтверждение пароля</label>
                    <input
                    	type="password"
                    	name="password_confirmation"
                    	id="input-password-confirmation"
                    	class="form-control form-control-alternative"
                    	placeholder="Подтверждение пароля"
                    	v-model.trim="user.passwordConfirm"
                    >
                </div>

                <div class="form-group">
                    <label for="raion_id">Район</label>
                    <select id="raion_id" name="raion_id" class="form-control" required>
                        <option>Выберите муниципальное образование</option>
                        <option
                            v-for="raion in raions"
                            :key="raion.id"
                            :selected="user.raion_id == raion.id"
                            :value="raion.id"
                        >{{raion.name}}</option>
                    </select>
                </div>

                <div class="form-group">
                    <div class="custom-control custom-control-alternative custom-checkbox">
                        <input
                            class="custom-control-input"
                            id="is_admin"
                            name="is_admin"
                            type="checkbox"
                            v-model="user.is_admin"
                        >
                        <label class="custom-control-label" for="is_admin">Права администратора</label>
                    </div>
                </div>

                <div class="text-center">
                    <button type="button" class="btn btn-success mt-4" @click.prevent="saveUser">Сохранить</button>
                </div>
            </div>
        </div>
	</section>
</template>

<script>
export default{
	props:{
		user:{
			type:Object,
			default:() => {
				return {
					name:'',
					phone:'',
					password:'',
					passwordConfirm:'',
					raion_id:'-1',
					raion:{},
					is_admin:false
				}
			}
		}
	},
	methods:{
		checkForm(){
			const user = this.user;
			const errors = [];
			if(user.name == '')
				errors.push('Имя не может быть пустым');
			if(user.phone == '')
				errors.push('Телефон не может быть пустым');
			if(!(user.raion_id * 1 > -1))
				errors.push('Не указан район');
			if(!('id' in user)){
				if(user.password == '')
					errors.push('Не указан пароль');
				if(user.password != user.passwordConfirm)
					errors.push('Пароль и подтверждение не совпадают');
			}
			if(errors.length > 0){
				errors.forEach( error => this.$awn.alert(error));
				return false;
			}
			else
				return true;
		},
		saveUser(){
			this.user.raion_id = document.getElementById('raion_id').value;
			if (!this.checkForm())
				return false;
			this.$store.dispatch('UPDATE_USER',this.user)
					.then( success => {
						this.$awn.success('Пользователь обновлен')
						this.$router.push({name:'usersIndex'})
					})
        			.catch( error => this.$awn.alert('Во время обновления пользователя произошли ошибки'))

			console.log('saved');
		},
	},
	computed:{
		raions(){return this.$store.getters.RAIONS;},
	}

}
</script>

<style scoped>

</style>