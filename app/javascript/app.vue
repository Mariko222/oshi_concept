<template>
  <div>
    <body class="flex flex-col min-h-screen">
      <TheHeader class="mb-auto" />
      <MypageHeader v-if="authUser" class="mb-auto" />
      <router-view />
      <TheFooter class="mt-auto" />
    </body>
  </div>
</template>

<script>
import TheHeader from "components/TheHeader"
import TheFooter from "components/TheFooter"
import MypageHeader from "components/MypageHeader"
import { mapGetters } from "vuex"
import axios from "./plugins/axios";
export default {
  components: {
    TheHeader,
    TheFooter,
    MypageHeader
  },
  computed: {
    ...mapGetters("users", ["authUser"])
  }
}
</script>
