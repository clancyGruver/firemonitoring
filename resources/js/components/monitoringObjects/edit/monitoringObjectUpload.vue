<template>
    <form action="" id="mediafileupload"  class="col-md-6 offset-md-3">
        <div class="form-row">
            <div class="form-group col">
                <label for="project_year">Файл</label>
                <input type="file" id="file" name="file" class="form-control-file" @change="onImageChange">
            </div>
        </div>
        <div class="form-row">
            <div class="form-group col">
                <label for="project_year">Описание</label>
                <input type="text" id="description" name="description" class="form-control" v-model="description">
            </div>
        </div>
        <div class="form-row">
            <div class="form-group col">
                <button class="btn btn-icon btn-3 btn-success" type="button" id="mediafiflesend" @click.prevent="uploadFile">
                    <span class="btn-inner--icon"><i class="fas fa-plus"></i></span>
                    <span class="btn-inner--text">Загрузить</span>
                </button>
            </div>
        </div>
    </form>
</template>

<script>

export default {
	props:{
        type: String,
    },

	data() {
		return {
            image: '',
            description: '',
		}
	},

	components:{},

	mounted: function(){
	},

	methods:{
        onImageChange(e) {
            this.image = e.target.files[0];
        },

		uploadFile: function () {
            this.$store.commit('MEDIAFILE_UPLOAD', this.sendData);
            this.image = '';
            this.description = '';
		}
	},

	computed: {
        sendData() {
            let fd = {};
            fd.image = this.image;
            fd.description = this.description;
            fd.type = this.type;
            return fd;
        }
	}
}
</script>

<style scoped>

</style>