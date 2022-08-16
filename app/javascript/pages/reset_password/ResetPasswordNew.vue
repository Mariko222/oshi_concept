<template>
  <div class="bg-purple-100 py-6 sm:py-8 lg:py-12">
    <div class="max-w-screen-2xl px-4 md:px-8 mx-auto">
      <h2 class="text-gray-800 text-2xl lg:text-3xl page-font text-center mb-4 md:mb-8">パスワードリセット</h2>
      <ValidationObserver v-slot="ObserverProps">
        <form class="max-w-lg border rounded-lg mx-auto">
          <div class="flex flex-col gap-4 p-4 md:p-8">

            <ValidationProvider name="メールアドレス" rules="required|email">
              <div slot-scope="ProviderProps">
                <label for="email" class="page-font inline-block text-gray-800 text-sm sm:text-base mb-2">メールアドレス</label>
                <input id="email" type="email" v-model="email" class="w-full bg-gray-50 text-gray-800 border focus:ring ring-indigo-300 rounded outline-none transition duration-100 px-3 py-2" />
                <span class="page-font text-red-500 text-center">{{
                    ProviderProps.errors[0]
                }}</span>
              </div>
            </ValidationProvider>

            <button
              type="button"
              class="page-font block bg-yellow-700 hover:bg-yellow-800 disabled:bg-gray-300 active:bg-yellow-900 focus-visible:ring ring-gray-300 text-white text-sm md:text-base font-semibold text-center rounded-full outline-none transition duration-100 px-8 py-3"
              :disabled="ObserverProps.invalid || !ObserverProps.validated"
              @click="passwordReset"
            >
              メールを送信する
            </button>
          </div>
        </form>
      </ValidationObserver>
    </div>
  </div>
</template>

<script>
import { extend, ValidationProvider, ValidationObserver } from "vee-validate";
import { required, email } from "vee-validate/dist/rules";
import axios from "../../plugins/axios";
required.message = "必須項目です。入力してください。";
email.message = "メールの形式ではありません";
extend("required", required);
extend("email", email);
export default {
  name: "ResetPasswordNew",
  data() {
    return {
      email: "",
    };
  },
  components: {
    ValidationProvider,
    ValidationObserver,
  },
  methods: {
    async passwordReset() {
      await axios.post("password_resets", {
        email: this.email,
      });
      this.$router.push({ name: "TopIndex" });
    },
  },
};
</script>
