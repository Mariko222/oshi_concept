<template>
  <div class="bg-white py-6 sm:py-8 lg:py-12">
    <div class="max-w-screen-2xl px-4 md:px-8 mx-auto">
      <h2 class="text-gray-800 text-2xl lg:text-3xl font-bold text-center mb-4 md:mb-8">マイページ編集</h2>

      <form class="max-w-lg border rounded-lg mx-auto">
        <div class="flex flex-col gap-4 p-4 md:p-8">
          <div>
            <label for="name" class="inline-block text-gray-800 text-sm sm:text-base mb-2">ユーザーネーム：</label>
            <input id="name" type="text" v-model="user.name" class="w-full bg-gray-50 text-gray-800 border focus:ring ring-indigo-300 rounded outline-none transition duration-100 px-3 py-2" />
          </div>

          <div>
            <label for="mypage_name" class="inline-block text-gray-800 text-sm sm:text-base mb-2">マイページ名：</label>
            <input id="mypage_name" type="text" v-model="user.mypage_name" class="w-full bg-gray-50 text-gray-800 border focus:ring ring-indigo-300 rounded outline-none transition duration-100 px-3 py-2" />
          </div>
          <div>
            <label
              for="icon"
              class="d-block"
            >アイコン：</label>
            <img
              :src="user.icon_url"
              class="rounded-full my-3"
              width="150px"
            >
            <input
              id="icon"
              type="file"
              class="form-control-file"
              @change="handleChange"
            >
          </div>
          <button
            type="button"
            class="block bg-gray-800 hover:bg-gray-700 active:bg-gray-600 focus-visible:ring ring-gray-300 text-white text-sm md:text-base font-semibold text-center rounded-lg outline-none transition duration-100 px-8 py-3"
            @click="update"
          >
            登録
          </button>
        </div>
      </form>
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
      uploadIcon: ""
    }
  },
  computed: {
    ...mapGetters("users", ["authUser"]),
  },
  created() {
    this.user = Object.assign({}, this.authUser)
  },
  methods: {
    ...mapActions("users", ["updateUser"]),
    async handleChange(event) {
      this.uploadIcon = event.target.files[0]
    },
    update() {
      const formData = new FormData()
      formData.append("user[name]", this.user.name)
      formData.append("user[mypage_name]", this.user.mypage_name)
      if (this.uploadIcon) formData.append("user[icon]", this.uploadIcon)

      try {
        this.updateUser(formData)
        this.$router.push({ name: "MypageIndex" })
      } catch (error) {
        console.log(error);
      }
    },
  }
}
</script>