<template>
  <transition name="fade">
    <div class="z-1000 sticky">
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
@import url('https://fonts.googleapis.com/css2?family=Yomogi&display=swap');
.page-font {
  font-family: 'Yomogi', cursive;
}
.fade-enter-active,
.fade-leave-active {
  will-change: opacity;
  transition: opacity 225ms cubic-bezier(0.4, 0, 0.2, 1) 0ms;
}
.fade-enter,
.fade-leave-to {
  opacity: 0;
}
</style>
