<template>
  <div class="bg-purple-100 py-6 sm:py-8 lg:py-12">
    <div class="max-w-screen-2xl px-4 md:px-8 mx-auto">
      <h2 class="text-gray-800 text-2xl lg:text-3xl page-font text-center mb-4 md:mb-8">パスワードリセット</h2>
      <ValidationObserver v-slot="ObserverProps">
        <form class="max-w-lg border rounded-lg mx-auto">
          <div class="flex flex-col gap-4 p-4 md:p-8">

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
              @click="changePassword"
            >
              パスワードを変更する
            </button>
          </div>
        </form>
      </ValidationObserver>
    </div>
  </div>
</template>

<script>
import { mapGetters } from "vuex"
import { extend, ValidationProvider, ValidationObserver } from "vee-validate";
import { required } from "vee-validate/dist/rules";
import axios from "../../plugins/axios";
required.message = "必須項目です。入力してください。";

extend("required", required);

export default {
  name: "ResetPasswordEdit",
  data() {
    return {
      user: {
        password: "",
        password_confirmation: "",
      },
    };
  },
  components: {
    ValidationProvider,
    ValidationObserver,
  },
  methods: {
    async changePassword() {
      await axios.patch(`password_resets/${this.$route.query.token}`, {
        user: this.user,
      });
      this.$router.push({ name: "TopIndex" });
      this.$store.dispatch("setFlash", {
          type: "success",
          message: "パスワードを変更しました。",
      })
    },
  },
};
</script>
