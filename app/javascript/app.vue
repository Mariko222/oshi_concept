<template>
  <div>
    <body class="flex flex-col min-h-screen">
      <TheHeader class="mb-auto" />
      <TheFlashMessage v-if="isFlash" />
      <router-view />
      <TheFooter class="mt-auto" />
    </body>
  </div>
</template>

<script>
import TheHeader from "components/TheHeader"
import TheFooter from "components/TheFooter"
import TheFlashMessage from "components/TheFlashMessage"
import { mapGetters } from "vuex"
import axios from "./plugins/axios";
export default {
  components: {
    TheHeader,
    TheFooter,
    TheFlashMessage,
  },
  computed: {
    ...mapGetters(["isFlash"]),
    ...mapGetters("users", ["authUser"])
  }
}
</script>
