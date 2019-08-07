<template>
    <div class="container">
        <h3 class="text-center text-capitalize">{{ header }}</h3>
        <ul>
            <li v-for="file in fileList" :key="file.id">
                <a :href="file.path" target="_blank">{{file.description || file.filename}}</a>
                <i class="fas fa-times text-danger delete-mediafile pointer ml-4" @click="delFile(file)"></i>
            </li>
        </ul>
        <upload-form :type="type"></upload-form>
    </div>
</template>

<script>
import UploadForm from './edit/monitoringObjectUpload';

export default {
    props:{
        fileList: Array,
        type: String,
        header: String,
    },

    data() {
        return {
        }
    },

    components:{UploadForm},

    mounted: function(){
    },

    methods:{
        delFile(file) {
            if(confirm(`Вы действительно хотите удалить файл ${file.description || file.filename}`)){
                this.$store.commit('MEDIAFILE_DELETE', {
                    type: this.type,
                    id: file.id,
                });
            }
        },
    },

    computed: {
    }
}
</script>