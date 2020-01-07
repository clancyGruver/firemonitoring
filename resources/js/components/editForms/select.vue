<template>
    <div class="form-group">
        <select v-model="selected" :multiple="multiple" class="form-control">
            <option disabled value="">{{description}}</option>
            <option
                v-for="(option,index) in options"
                :key="index"
                :value="option.id"
            >
                {{option.name}}
            </option>
        </select>
    </div>
</template>

<script>

export default {
	props:{
        val:{
            type:String,
            default: '',
        },
        multiple: {
            type:Boolean,
            default: false,
        },
        options:{
            type:Array,
            default(){return [];},
        },
        description:{
            type: String,
            default: 'Выберите один из вариантов',
        }
    },
	data() {
		return {
            selected: this.multiple ? [] : '',
		}
	},
    mounted(){
        this.selected = this.val ? this.val : this.multiple ? [] : '';
    },
    watch:{
        selected(newVal){this.$emit('selected',newVal);}
    }
}
</script>

<style scoped>

</style>