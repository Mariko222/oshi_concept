<template>
  <div class="bg-white py-6 sm:py-8 lg:py-12">
    <div class="max-w-screen-2xl px-4 md:px-8 mx-auto">
      <h2 class="text-gray-800 text-2xl lg:text-3xl font-bold text-center mb-4 md:mb-8">新規登録</h2>

      <form class="max-w-lg border rounded-lg mx-auto">
        <div class="flex flex-col gap-4 p-4 md:p-8">
          <div>
            <label for="name" class="inline-block text-gray-800 text-sm sm:text-base mb-2">ユーザーネーム</label>
            <input id="name" type="text" v-model="user.name" class="w-full bg-gray-50 text-gray-800 border focus:ring ring-indigo-300 rounded outline-none transition duration-100 px-3 py-2" />
          </div>

          <div>
            <label for="email" class="inline-block text-gray-800 text-sm sm:text-base mb-2">メールアドレス</label>
            <input id="email" type="email" v-model="user.email" class="w-full bg-gray-50 text-gray-800 border focus:ring ring-indigo-300 rounded outline-none transition duration-100 px-3 py-2" />
          </div>

          <div>
            <label for="password" class="inline-block text-gray-800 text-sm sm:text-base mb-2">パスワード</label>
            <input id="password" type="password" v-model="user.password" class="w-full bg-gray-50 text-gray-800 border focus:ring ring-indigo-300 rounded outline-none transition duration-100 px-3 py-2" />
          </div>

          <div>
            <label for="password_confirmation" class="inline-block text-gray-800 text-sm sm:text-base mb-2">パスワード（確認用）</label>
            <input id="password_confirmation" type="password" v-model="user.password_confirmation" class="w-full bg-gray-50 text-gray-800 border focus:ring ring-indigo-300 rounded outline-none transition duration-100 px-3 py-2" />
          </div>

          <button
            type="button"
            class="block bg-gray-800 hover:bg-gray-700 active:bg-gray-600 focus-visible:ring ring-gray-300 text-white text-sm md:text-base font-semibold text-center rounded-lg outline-none transition duration-100 px-8 py-3"
            @click="register"
          >
            登録
          </button>
          <div class="flex justify-center items-center relative">
            <span class="h-px bg-gray-300 absolute inset-x-0"></span>
            <span class="bg-white text-gray-400 text-sm relative px-4">or</span>
          </div>
          <button
            class="flex justify-center items-center bg-twitter hover:bg-sky-400 active:bg-sky-500 focus-visible:ring ring-blue-300 text-white text-sm md:text-base font-semibold text-center rounded-lg outline-none transition duration-100 gap-2 px-8 py-3"
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
      </form>
    </div>
  </div>
</template>

<script>
import axios from "../../plugins/axios";
export default {
  name: "RegisterIndex",
  data() {
    return {
      user: {
        name: "",
        email: "",
        password: "",
        password_confirmation: "",
      },
    };
  },
  methods: {
    register() {
      axios
        .post('users', { user: this.user })
        .then(res => {
          this.$router.push({ name: 'LoginIndex' });
        })
        .catch((err) => {
          console.log(err)
        })
    },
  }
}
</script>
