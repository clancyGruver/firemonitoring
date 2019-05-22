  <template>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="card card-default">
                        <div class="card-header">Вход</div>

                        <div class="card-body">
                            <form method="POST" action="/login">
                                <div class="form-group row">
                                    <label for="phone" class="col-sm-4 col-form-label text-md-right">Телефон</label>

                                    <div class="col-md-6">
                                        <input id="phone" type="phone" class="form-control" v-model="phone" required autofocus>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="password" class="col-md-4 col-form-label text-md-right">Пароль</label>

                                    <div class="col-md-6">
                                        <input id="password" type="password" class="form-control" v-model="password" required>
                                    </div>
                                </div>

                                <div class="form-group row mb-0">
                                    <div class="col-md-8 offset-md-4">
                                        <button type="submit" class="btn btn-primary" @click="handleSubmit">
                                            Войти
                                        </button>
                                    </div>
                                </div>
                            </form>
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
                    phone : "",
                    password : ""
                }
            },
            methods : {
                handleSubmit(e){
                    e.preventDefault()

                    if (this.password.length > 0) {
                        axios.post('api/login', {
                            phone: this.phone,
                            password: this.password
                          })
                          .then(response => {
                            localStorage.setItem('user',response.data.success.name)
                            localStorage.setItem('is_admin',response.data.success.is_admin)
                            localStorage.setItem('jwt',response.data.success.token)

                            if (localStorage.getItem('jwt') != null){
                                if(localStorage.getItem('is_admin'))
                                    this.$router.go('/admin')
                                else
                                    this.$router.go('/technician')
                            }
                          })
                          .catch(function (error) {
                            console.error(error);
                          });
                    }
                }
            },
            beforeRouteEnter (to, from, next) { 
                if (localStorage.getItem('jwt')) {
                    if(localStorage.getItem('is_admin'))
                        return next('/admin');
                    else
                        return next('/technician');
                }

                next();
            }
        }
    </script>