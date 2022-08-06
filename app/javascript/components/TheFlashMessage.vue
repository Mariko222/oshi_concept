<template>
  <transition name="fade">
    <div class="fixed top-20 right-10 max-w-xs z-20 sticky">
      <div v-if="flash.type === 'success'">
        <div
          class="page-font border border-green-400 bg-green-100 px-4 py-3 text-green-700"
        >
          {{ flash.message }}
        </div>
      </div>
      <div v-if="flash.type === 'error'">
        <div
          class="page-font border border-red-400 bg-red-100 px-4 py-3 text-red-700"
        >
          {{ flash.message }}
        </div>
      </div>
    </div>
  </transition>
</template>

<script>
import { mapGetters } from "vuex";
export default {
  computed: {
    ...mapGetters(["flash"]),
  },
  mounted() {
    setTimeout(() => {
      this.$store.dispatch("setFlash", {
        type: "",
        flash: "",
      });
    }, 2000);
  },
};
</script>

<style scoped>

</style>
