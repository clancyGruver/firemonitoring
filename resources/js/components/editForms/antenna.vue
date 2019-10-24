<template>
	<modal name="antenna-params" transition="pop-out" height="auto">
		<div class="mb-4">
			<div class="card-body">
				<div class="p-0">
                	<div class="card bg-secondary shadow border-0">
						<div class="card-header bg-transparent modal-header">
	                        <div class="text-muted text-center">
                        		<small>Свойства антенны</small>
                        	</div>
							<div class="text-muted text-center mt-2"  v-if="errors.length">
								<p>
									<b>Пожалуйста исправьте указанные ошибки:</b>
									<ul>
										<li class="alert alert-danger" role="alert" v-for="(error, index) in errors" :key="index">{{ error }}</li>
									</ul>
								</p>
							</div>
	                    </div>
		                <div class="card-body">
							<form @keyup.enter="save">
								<div class="form-group col custom-control">
									<label for="setup_place">Место установки</label>
									<input
											id="setup_place"
											name="setup_place"
											type="text"
											class="form-control"
											placeholder="Место установки"
											v-model="deviceData.setup_place"
										>
									</div>
									<div class="form-group col custom-control">
											<label class="" for="mast_isset">Наличие мачты</label>
										<select class="form-control" id="mast_isset" name="mast_isset" v-model="deviceData.mast_isset">
											<option disabled value="" >Выберите один из вариантов</option>
											<option value="1">Есть</option>
											<option value="0">Нет</option>
										</select>
									</div>

								<div v-show="deviceData.mast_isset == 1">
									<div class="form-group col">
										<label for="mast_height">Высота мачты</label>
										<input
											id="mast_height"
											name="mast_height"
											type="number"
											class="form-control"
											v-model="deviceData.mast_height"
										>
									</div>
								</div>

						        <div class="form-group col custom-control">
						          <label class="" for="cable_type">Тип кабеля</label>
											<autocomplete
												:search="search"
												:default-value="getCableTypeName"
												@submit="handleCableType"
											>
											</autocomplete>
										</div>


							    <div class="">
							        <div class="form-group col btn-group">
										<button type="button" @click="cancel" class="btn btn-danger">Отмена</button>
										<button type="button" @click="save" class="btn btn-success">Сохранить</button>
									</div>
								</div>
							</form>
		                </div>
		            </div>
                </div>
			</div>
		</div>
	</modal>
</template>

<script>
import Autocomplete from "@trevoreyre/autocomplete-vue";
import "@trevoreyre/autocomplete-vue/dist/style.css";

export default {
  name: "antennaParams",
  components: { Autocomplete },
  props: {
    deviceData: {
      type: Object,
      default: () => {}
    }
  },
  data: function() {
    return {
      errors: []
    };
  },
  methods: {
    handleCableType(cableType) {
      this.$store
        .dispatch("CHECK_CABLE_TYPE", cableType)
        .then(resp => (this.deviceData.cable_type = resp));
    },
    search(input) {
      const result = this.cableTypes.filter(cableType => {
        return cableType.toLowerCase().includes(input.toLowerCase());
      });
      result.unshift(input);
      return result;
    },
    save() {
      if (!this.check()) return false;
      this.$store.dispatch("UPDATE_OBJECT_DEVICE_PARAMS", {
        type: "antenna",
        data: this.deviceData
      });
      this.cancel();
    },
    cancel() {
      this.$modal.hide("antenna-params");
    },
    check() {
      let res = true;
      this.errors = [];
      if (!this.deviceData.setup_place) {
        this.errors.push("Требуется указать место установки.");
        res = false;
      }
      if (![0, 1].includes(this.deviceData.mast_isset)) {
        this.errors.push("Требуется указать наличие мачты.");
        res = false;
      }
      return res;
    }
  },
  computed: {
    cableTypes() {
      return this.$store.getters.CABLE_TYPES.map(cableType => cableType.name);
    },
    getCableTypeName() {
      const cableId = this.deviceData.cable_type;
      const cableType = this.$store.getters.CABLE_TYPES.find(
        ct => ct.id == cableId
      );
      let result = "";
      if (cableType && cableType.name) result = cableType.name;
      return result;
    }
  }
};
</script>

<style scoped>
</style>