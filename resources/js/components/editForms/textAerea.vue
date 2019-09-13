<template>
    <textarea
        class="form-control"
        :rows="rows"
        :placeholder="placeholder"
        v-model="message"
    >
    </textarea>
</template>

<script>

export default {
	props:{
        rows: {
            type:Number,
            default: 3,
        },
        placeholder:{
            type:String,
            default:'Введите комментарий',
        },
    },
	data() {
		return {
            message: '',
		}
	},
    watch:{
        message(newVal){this.$emit('entered',newVal);}
    }
}
</script>

<style scoped>

</style>