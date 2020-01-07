<template>
    <div class="form-group">
        <div class="input-group input-group-alternative">
            <div class="input-group-prepend">
                <span class="input-group-text"><i class="ni ni-calendar-grid-58"></i></span>
            </div>
            <input
                class="form-control datepicker"
                :placeholder="placeholder"
                type="text"
                v-model="localVal"
            >
        </div>
    </div>
</template>

<script>

export default {
	props:['placeholder', 'val'],
	data() {
		return {
            localVal: this.val ? this.val : this.curDate(),
		}
	},
	methods:{
        curDate(){
            const now = new Date();
            return `now.getDay() / now.getDate() / now.getFullYear()`;
        }
	},
    watch:{
        localVal(newVal){
            this.$emit('changed', newVal);
        }
    }
}
</script>

<style scoped>

</style>