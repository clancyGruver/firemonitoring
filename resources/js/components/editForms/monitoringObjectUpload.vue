<template>
    <form action="" id="mediafileupload"  class="col-md-6 offset-md-3">
        <div class="form-row">
            <div class="form-group col">
                <label for="project_year">Медиафайл</label>
                <input type="file" id="file" name="file" class="form-control-file" >
            </div>
        </div>    
        <div class="form-row">
            <div class="form-group col">
                <label for="project_year">Описание</label>
                <input type="text" id="description" name="description" class="form-control">
            </div>
        </div>    
        <div class="form-row">
            <div class="form-group col">
                <button class="btn btn-icon btn-3 btn-success" type="button" id="mediafiflesend">
                    <span class="btn-inner--icon"><i class="fas fa-plus"></i></span>
                    <span class="btn-inner--text">Загрузить</span>
                </button>
            </div>
        </div>
    </form>
</template>

<script>
import UploadForm from './monitoringObjectUpload';

export default {
	props:{},

	data() {
		return {
		}
	},

	components:{UploadForm},

	mounted: function(){
	},

	methods:{
		createTree: function (devices) {
		}
	},

	computed: {
	}
}
</script>

<style scoped>

</style>