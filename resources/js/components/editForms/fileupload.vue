<template>
    <div class="form-group">
        <label for="file">{{ label ? label : 'Файл'}}</label>
        <input type="file" id="file" ref="file" name="file" class="form-control-file" @change="onFileChange">
    </div>
</template>

<script>

export default {
	props:['curFile', 'label'],
	data() {
		return {
            file: ''
		}
	},
	components:{},
	mounted: function(){
	},
	methods:{
        onFileChange() {
            this.file = this.$refs.file.files[0];
            this.$emit('changed', this.file)
        },
	}
}
</script>

<style scoped>

</style>