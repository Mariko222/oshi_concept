<template>
  <div class="bg-white py-6 sm:py-8 lg:py-12">
    <div class="max-w-screen-2xl px-4 md:px-8 mx-auto">
      <h2 class="text-gray-800 text-2xl lg:text-3xl font-bold text-center mb-4 md:mb-8">マイページ編集</h2>
      <ValidationObserver v-slot="ObserverProps">
        <form class="max-w-lg border rounded-lg mx-auto">
          <div class="flex flex-col gap-4 p-4 md:p-8">
            <ValidationProvider name="ユーザーネーム" rules="required|max:50">
              <div slot-scope="ProviderProps">
              <label for="name" class="inline-block text-gray-800 text-sm sm:text-base mb-2">ユーザーネーム：</label>
              <input id="name" type="text" v-model="user.name" class="w-full bg-gray-50 text-gray-800 border focus:ring ring-indigo-300 rounded outline-none transition duration-100 px-3 py-2" />
              <span class="text-red-500 text-center">{{
                  ProviderProps.errors[0]
                }}</span>
              </div>
            </ValidationProvider>

            <ValidationProvider name="マイページ名" rules="max:50">
              <div slot-scope="ProviderProps">
              <label for="mypage_name" class="inline-block text-gray-800 text-sm sm:text-base mb-2">マイページ名：</label>
              <input id="mypage_name" type="text" v-model="user.mypage_name" class="w-full bg-gray-50 text-gray-800 border focus:ring ring-indigo-300 rounded outline-none transition duration-100 px-3 py-2" />
              <span class="text-red-500 text-center">{{
                  ProviderProps.errors[0]
                }}</span>
              </div>
            </ValidationProvider>

            <ValidationProvider ref="provider" name="アイコン" rules="image">
              <div slot-scope="ProviderProps">
                <label
                  for="icon"
                  class="d-block"
                >アイコン：</label>
                <div class="icon" v-if="url">
                  <img :src="url"
                    class="my-3"
                  >
                </div>
                <div class="icon" v-else>
                  <img
                    :src="user.icon_url"
                    class="my-3"
                  >
                </div>
                <input
                  id="icon"
                  type="file"
                  ref="preview"
                  class="form-control-file"
                  @change="handleChange"
                >
                <p class="text-red-500 text-center">{{
                  ProviderProps.errors[0]
                }}</p>
              </div>
            </ValidationProvider>

            <button
              type="button"
              class="block bg-gray-800 hover:bg-gray-700 disabled:bg-gray-400 active:bg-gray-600 focus-visible:ring ring-gray-300 text-white text-sm md:text-base font-semibold text-center rounded-lg outline-none transition duration-100 px-8 py-3"
              :disabled="ObserverProps.invalid"
              @click="update"
            >
              登録
            </button>
            <span class="text-red-500 text-center">{{ errorMessage }}</span>
          </div>
        </form>
      </ValidationObserver>
    </div>
  </div>
</template>

<script>
import axios from "../../plugins/axios";
import { mapGetters, mapActions } from "vuex"
export default {
  name: "MypageEdit",
  data() {
    return {
      user: {
        name: "",
        mypage_name: "",
        icon_url: ""
      },
      url: "",
      uploadIcon: "",
      errorMessage: "",
    }
  },
  computed: {
    ...mapGetters("users", ["authUser"]),
  },
  mounted() {
    console.log(this.$refs.preview)
  },
  created() {
    this.user = Object.assign({}, this.authUser)
  },
  methods: {
    ...mapActions("users", ["updateUser"]),
    async handleChange(event) {
      const { valid } = await this.$refs.provider.validate(event)
      if (valid) this.uploadIcon = event.target.files[0]
      const file = this.$refs.preview.files[0];
      this.url = URL.createObjectURL(file)
    },
    update() {
      const formData = new FormData()
      formData.append("user[name]", this.user.name)
      formData.append("user[mypage_name]", this.user.mypage_name)
      if (this.uploadIcon) formData.append("user[icon]", this.uploadIcon)

      try {
        this.updateUser(formData)
        this.$store.dispatch("setFlash", {
          type: "success",
          message: "マイページ編集しました。",
        });
        this.$router.push({ name: "MypageIndex" })
      } catch (error) {
        console.log(error);
        this.errorMessage = error.response.data.errors.detail;
        this.$store.dispatch("setFlash", {
          type: "error",
          message: "マイページ編集できませんでした。",
        })
      }
    },
  }
}
</script>

<style scoped>
.icon img {
  width:  150px;
  height: 150px;
  border-radius: 50%;
  background-position: center center;
  object-fit:cover;
}
</style>
