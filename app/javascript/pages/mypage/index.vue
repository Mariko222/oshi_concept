<template>
  <div>
    <MypageHeader v-if="authUser" class="mb-auto" />
    <div class="container mx-auto">
      <div class="bg-white py-6 sm:py-8 lg:py-12">
        <div class="max-w-screen-2xl px-4 md:px-8 mx-auto">
          <div class="grid grid-cols-2 rounded-lg gap-8">
            <div class="h-16 sm:h-32 flex justify-center items-center bg-gray-100 text-gray-400 rounded-lg p-4">
              <router-link :to="{ name: 'PostIndex' }">概念リストをみる</router-link>
            </div>
            <div class="flex-auto flex justify-center items-center">
              <div class="lg:flex flex-col sm:flex-row items-center gap-2.5 ml-8">
                <router-link :to="{ name: 'PostNew' }" button class="btn bg-indigo-800 text-white btn-outline mr-5">概念を追加</router-link>
              </div>
              <div class="lg:flex flex-col sm:flex-row items-center gap-2.5 ml-8">
                <button
                  class="flex justify-center bg-twitter hover:bg-sky-400 active:bg-sky-500 focus-visible:ring ring-blue-300 text-white text-sm md:text-base font-semibold text-center rounded-lg outline-none transition duration-100 gap-2 px-8 py-3"
                >
                  <svg class="w-5 h-5 shrink-0" width="24" height="24" viewBox="328 355 335 276" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="
                      M 630, 425
                      A 195, 195 0 0 1 331, 600
                      A 142, 142 0 0 0 428, 570
                      A  70,  70 0 0 1 370, 523
                      A  70,  70 0 0 0 401, 521
                      A  70,  70 0 0 1 344, 455
                      A  70,  70 0 0 0 372, 460
                      A  70,  70 0 0 1 354, 370
                      A 195, 195 0 0 0 495, 442
                      A  67,  67 0 0 1 611, 380
                      A 117, 117 0 0 0 654, 363
                      A  65,  65 0 0 1 623, 401
                      A 117, 117 0 0 0 662, 390
                      A  65,  65 0 0 1 630, 425
                      Z"
                      fill="white" />
                  </svg>
                  Twitterで共有
                </button>
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
