<template>
  <div>
    <MypageHeader v-if="authUser" class="mb-auto" />
    <div class="container mx-auto">
      <div class="bg-purple-100 py-6 sm:py-8 lg:py-12">
        <div class="grid grid-cols-3">
          <div class="flex justify-center items-center bg-gray-700 text-white rounded-lg">
            <router-link :to="{ name: 'PostIndex' }">概念リスト</router-link>
          </div>
          <div class="lg:flex flex-col sm:flex-row items-center gap-2.5 ml-8">
            <router-link :to="{ name: 'PostNew' }" button class="btn bg-indigo-800 text-white btn-outline mr-5">概念を追加</router-link>
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
