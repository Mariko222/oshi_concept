<template>
  <div class="bg-purple-100 py-6 sm:py-8 lg:py-12">
    <div class="max-w-screen-2xl px-4 md:px-8 mx-auto">
      <h2 class="text-gray-800 text-2xl lg:text-3xl page-font text-center mb-4 md:mb-8">新規登録</h2>
      <ValidationObserver v-slot="ObserverProps">
        <form class="max-w-lg border rounded-lg mx-auto">
          <div class="flex flex-col gap-4 p-4 md:p-8">
            <ValidationProvider name="ユーザーネーム" rules="required|max:50">
              <div slot-scope="ProviderProps">
                <label for="name" class="page-font inline-block text-gray-800 text-sm sm:text-base mb-2">ユーザーネーム</label>
                <input id="name" type="text" v-model="user.name" class="w-full bg-gray-50 text-gray-800 border focus:ring ring-indigo-300 rounded outline-none transition duration-100 px-3 py-2" />
                <span class="page-font text-red-500 text-center">{{
                  ProviderProps.errors[0]
                }}</span>
              </div>
            </ValidationProvider>

            <ValidationProvider name="メールアドレス" rules="required|email">
              <div slot-scope="ProviderProps">
                <label for="email" class="page-font inline-block text-gray-800 text-sm sm:text-base mb-2">メールアドレス</label>
                <input id="email" type="email" v-model="user.email" class="w-full bg-gray-50 text-gray-800 border focus:ring ring-indigo-300 rounded outline-none transition duration-100 px-3 py-2" />
                <span class="page-font text-red-500 text-center">{{
                  ProviderProps.errors[0]
                }}</span>
              </div>
            </ValidationProvider>

            <ValidationProvider name="パスワード" rules="required|min:5" vid="user.password">
              <div slot-scope="ProviderProps">
                <label for="password" class="page-font inline-block text-gray-800 text-sm sm:text-base mb-2">パスワード</label>
                <input id="password" type="password" v-model="user.password" class="w-full bg-gray-50 text-gray-800 border focus:ring ring-indigo-300 rounded outline-none transition duration-100 px-3 py-2" />
                <span class="page-font text-red-500 text-center">{{
                  ProviderProps.errors[0]
                }}</span>
              </div>
            </ValidationProvider>

            <ValidationProvider name="パスワード（確認用）" rules="required|min:5|confirmed:user.password">
              <div slot-scope="ProviderProps">
                <label for="password_confirmation" class="page-font inline-block text-gray-800 text-sm sm:text-base mb-2">パスワード（確認用）</label>
                <input id="password_confirmation" type="password" v-model="user.password_confirmation" class="w-full bg-gray-50 text-gray-800 border focus:ring ring-indigo-300 rounded outline-none transition duration-100 px-3 py-2" />
                <span class="page-font text-red-500 text-center">{{
                  ProviderProps.errors[0]
                }}</span>
              </div>
            </ValidationProvider>

            <button
              type="button"
              class="page-font block bg-yellow-700 hover:bg-yellow-800 disabled:bg-gray-300 active:bg-yellow-900 focus-visible:ring ring-gray-300 text-white text-sm md:text-base font-semibold text-center rounded-full outline-none transition duration-100 px-8 py-3"
              :disabled="ObserverProps.invalid || !ObserverProps.validated"
              @click="register"
            >
              登録
            </button>
            <span class="page-font text-red-500 text-center">{{ errorMessage }}</span>
            <div class="flex justify-center items-center relative">
              <span class="h-px bg-gray-300 absolute inset-x-0"></span>
              <span class="page-font bg-purple-100 text-gray-400 text-sm relative px-4">or</span>
            </div>
            <TwitterLoginButton />
          </div>
        </form>
      </ValidationObserver>
    </div>
  </div>
</template>

<script>
import axios from "../../plugins/axios";
import { mapActions } from "vuex"
import TwitterLoginButton from "../../components/TwitterLoginButton.vue";
export default {
  name: "RegisterIndex",
  components: {
    TwitterLoginButton,
  },
  data() {
    return {
      user: {
        name: "",
        email: "",
        password: "",
        password_confirmation: "",
      },
      errorMessage: "",
    };
  },
  methods: {
    ...mapActions("users", [
      "createUser",
    ]),
    async register() {
      try {
        await
          this.createUser(this.user)
          this.$store.dispatch("setFlash", {
            type: "success",
            message: "登録しました。",
          });
          this.$router.push({ name: 'LoginIndex' });
      } catch (error) {
        console.log(error.response);
        this.errorMessage = error.response.data.errors.detail;
        this.$store.dispatch("setFlash", {
          type: "error",
          message: "登録できませんでした。",
        })
      }
    },
    twitterLogin() {
      axios.get("oauth/twitter").then(res => {
        const url = res.data
        window.location.href = url
      })
    }
  }
}
</script>
