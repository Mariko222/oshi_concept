<template>
  <div class="navbar bg-neutral h-20 mx-auto flex justify-between items-center text-neutral-content sticky top-0 z-20">
    <div class="navbar-start">
      <p class="page-font"><router-link :to="{ name: 'TopIndex' }">推し概念集めてみた</router-link></p>
    </div>
    <template v-if="authUser">
      <div class="navbar-center">
        <p class="page-font text-2xl"><router-link :to="{ name: 'PostIndex' }">{{ authUser.mypage_name }}</router-link></p>
      </div>
    </template>
    <div class="navbar-end">
      <div class="flex-none">
        <div class="dropdown dropdown-end">
          <button class="btn btn-square btn-ghost">
            <svg class="h-6 w-6 fill-current" viewBox="0 0 24 24">
              <path d="M24 6h-24v-4h24v4zm0 4h-24v4h24v-4zm0 8h-24v4h24v-4z"/>
            </svg>
          </button>
          <ul tabindex="0" class="dropdown-content menu p-2 drop-shadow-md bg-base-200 box w-52 text-neutral">
            <template v-if="!authUser">
              <li class="page-font"><router-link :to="{ name: 'LoginIndex' }">ログイン</router-link></li>
              <li class="page-font"><router-link :to="{ name: 'RegisterIndex' }">新規登録</router-link></li>
              <li class="page-font"><a>ゲストログイン</a></li>
            </template>
            <template v-else>
              <li class="page-font">
                <router-link :to="{ name: 'MypageEdit' }" class="nav-link">マイページ編集</router-link>
              </li>
              <li class="page-font">
                <router-link :to="{ name: 'MygenresEdit' }" class="nav-link">推しを変更</router-link>
              </li>
              <li class="page-font">
                <router-link :to="{ name: 'PostNew' }" class="nav-link">概念を追加</router-link>
              </li>
              <li class="page-font">
                <router-link to="#" class="nav-link" @click.native="handleLogout">ログアウト</router-link>
              </li>
            </template>
          </ul>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters, mapActions } from "vuex"

export default {
  name: "TheHeader",
  computed: {
    ...mapGetters("users", ["authUser"])
  },
  methods: {
    ...mapActions("users", ["logoutUser"]),
    async handleLogout() {
      try {
        await this.logoutUser()
        this.$store.dispatch("setFlash", {
          type: "success",
          message: "ログアウトしました。",
        });
        this.$router.push({name: 'TopIndex'})
      } catch (error) {
        console.log(error);
        this.errorMessage = error.response.data.errors.detail;
        this.$store.dispatch("setFlash", {
          type: "error",
          message: "ログアウトできませんでした。",
        })
      }
    }
  }
}
</script>

<style scoped>

</style>
