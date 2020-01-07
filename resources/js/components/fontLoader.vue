<template>
	<span>
  		<i class="fas fa-spinner fa-pulse"></i>{{text}}
	</span>
</template>

<script>
export default{
	props:{
		text:{
			type:String,
			default: 'Загрузка',
		}
	}
}
</script>