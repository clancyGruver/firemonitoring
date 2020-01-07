<template>
  <div v-if="show">
    <transition name="modal">
      <div class="modal-mask">
        <div class="modal-wrapper">

        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header bg-gradient-primary">
                    <h3 class="modal-title">Добавить в работу</h3>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true" @click="handleClose()">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <h3>{{object.name}}</h3>
					<date-picker
						v-model="res.planned_at"
						:lang="'ru'"
						:type="'date'"
						:placeholder="`Дата проведения работ`"
						:input-class="`form-control`"
						:clearable="false"
						:format="`DD/MM/YYYY`"
						:not-before="new Date()"
						:default-value="new Date()"
						class="mb-4"
					/>
					<vue-select
						:options="$store.getters.TECHNICS_USERS"
						:multiple="false"
						:description="`Выберите техника для проведения работ`"
						@selected="setTechnic"
					/>
					<vue-select
						:options="workTypes"
						:multiple="true"
						:description="`Выберите тип проведения работ`"
						@selected="setWorkType"
					/>
					<vue-textarea
						:rows="3"
						:description="`Комментарий`"
						@selected="setComment"
					/>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" @click="handleClose()">Отмена</button>
                    <button type="button" class="btn btn-success"  @click="handleSave()">Сохранить</button>
                </div>
            </div>
        </div>

        </div>
      </div>
    </transition>
  </div>
</template>
<script>
import VueSelect from '../../editForms/select';
import VueTextarea from '../../editForms/textAerea';
import DatePicker from 'vue2-datepicker';

export default{
	props:['show','object'],
	components:{VueSelect,VueTextarea,DatePicker},
	data(){
		return{
			res:{
				technic_id: '',
				work_type:[],
				object_id: -1,
				comment: '',
				planned_at: '',
			},
			workTypes:[
				{id: 'setup', name: 'Установка оборудования'},
				{id: 'repair', name: 'Проведение ремонта'},
				{id: 'reglament', name: 'Проведение регламентных работ'},

			],
		}
	},
	methods:{
		setComment(e){this.res.comment = e},
		setWorkType(e){this.res.work_type = e},
		setTechnic(e){this.res.technic_id = e},
		check(){
			const errors = [];
			if(!this.res.technic_id)
				errors.push('Не выбран техник.');
			if(this.res.work_type.length == 0)
				errors.push('Не выбран тип работ.');
			if(!this.res.object_id)
				errors.push('Не выбран объект.');
			if(!this.res.planned_at)
				errors.push('Не выбрана дата.');
			if(errors.length > 0){
				errors.map(error => this.$awn.alert(error));
				return false;
			}
			return true;
		},
		close(){
			const resVal = this.res.object_id > -1 ? this.res : {};
			this.$emit('endEdit', resVal);
			this.res = {
				technic_id: '',
				work_type:[],
				object_id: -1,
				planned_at: '',
				comment: '',
			}
		},
		handleClose(){
			this.close();
		},
		handleSave(){
			this.res.object_id = this.object.id;
			if(this.check()){
				const date = this.res.planned_at;
				this.res.planned_at = `${date.getFullYear()}-${date.getMonth()+1}-${date.getDate()}`;
				this.$store.dispatch('CALENDAR_ADD_OBJECT',this.res)
					.then(success => this.$awn.success('Работы на объекте добавлены.'))
					.catch( error => {
										console.log(error);
										this.$awn.alert('Работы на объекте не добавлены.')
									})
				this.close();
			}
			else{
				return false;
			}
		}
	}
}
</script>

<style scoped>
.modal-mask {
  position: fixed;
  z-index: 9998;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, .5);
  display: table;
  transition: opacity .3s ease;
}

.modal-wrapper {
  display: table-cell;
  vertical-align: middle;
}

</style>