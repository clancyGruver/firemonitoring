<template>
    <div class="row">
        <div class="col">
            <media-file-list :header="'Планы БТИ'" :fileList="object.btifiles" :type="'bti_files'" />
        </div>
        <div class="col left-bordered">
            <media-file-list :header="'Медиафайлы'" :fileList="object.mediafiles" :type="'media'" />
        </div>
	</div>
</template>

<script>
import MediaFileList from '../mediaFilelist';

export default {
	props:{
    },

	data() {
		return {
		}
	},

	components:{MediaFileList},

	mounted: function(){
	},

	methods:{
	},

	computed: {
        object() {return this.$store.getters.CURRENT_OBJECT},
	}
}
</script>

<style scoped>
    .left-bordered{
        border-left: 2px solid #c6c6c6;
    }
</style>
