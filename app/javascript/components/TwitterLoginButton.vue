<template>
  <div>
    <div class="flex items-center justify-center space-x-2 mb-3">
      <button
        type="button"
        @click="twitterLogin"
        class="page-font flex justify-center w-full items-center bg-twitter hover:bg-sky-400 active:bg-sky-500 focus-visible:ring ring-blue-300 text-white text-sm md:text-base font-semibold text-center rounded-full outline-none transition duration-100 gap-2 px-8 py-3"
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
        Twitterでログイン
      </button>
    </div>
  </div>
</template>

<script>
import axios from "../plugins/axios";
export default {
  methods: {
    twitterLogin() {
      axios.get("oauth/twitter").then(res => {
        const url = res.data
        window.location.href = url
      })
    }
  },
};
</script>
