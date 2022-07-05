<template>
  <div class="container mx-auto">
    <MypageHeader v-if="authUser" class="mb-auto" />
    <div class="bg-white py-6 sm:py-8 lg:py-12">
      <div class="max-w-screen-2xl px-4 md:px-8 mx-auto">
        <div class="flex justify-between items-end gap-4 mb-6">
          <h2 class="text-gray-800 text-2xl lg:text-3xl font-bold">概念</h2>
        </div>
        <div class="grid sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-x-4 md:gap-x-6 gap-y-8">
          <div>
            <a href="#" class="group h-80 block bg-gray-100 rounded-lg overflow-hidden relative mb-2 lg:mb-3">
            </a>
            <div class="flex items-end gap-2">
              <p>タイトル</p>
            </div>
          </div>
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
