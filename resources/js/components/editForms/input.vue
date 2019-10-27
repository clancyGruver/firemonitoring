<template>
        <div class="form-group">
            <label>{{name}}</label>
            <input
                class="form-control"
                :type="type"
                v-model="localVal"
                @change="changeHandler">
        </div>
</template>

<script>

export default {
	props:['type', 'name', 'val'],
	data() {
		return {
                        localVal: this.val,
		}
	},

	components:{},

	mounted: function(){
	},

	methods:{
        changeHandler(){
                if(this.type == 'number')
                this.localVal = this.localVal.replace(',','.');
                this.$emit('changed', this.localVal);
        }
	},

	computed: {
        res(){}
	}
}
</script>

<style scoped>

</style>