<template>
  <div>
    <MypageHeader v-if="authUser" class="mb-auto" />
    <div class="container mx-auto mt-60">
      <div class="bg-purple-100 py-6 sm:py-8 lg:py-12">
        <div class="grid grid-cols-3">
          <div class="page-font lg:flex flex-col sm:flex-row gap-2.5 ml-8 flex justify-center items-center bg-lime-500 hover:bg-lime-400 active:bg-lime-600 text-white rounded-lg py-3">
            <router-link :to="{ name: 'PostIndex' }">概念リスト</router-link>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import MypageHeader from "../../components/MypageHeader"
import { mapGetters } from "vuex"
import axios from "../../plugins/axios";
export default {
  components: {
    MypageHeader
  },
  computed: {
    ...mapGetters("users", ["authUser"])
  },
  data() {
    return {
    }
  },
}
</script>

<style scoped>

</style>
