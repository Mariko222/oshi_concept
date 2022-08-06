<template>
  <div class="navbar bg-yellow-900 h-20 mx-auto flex justify-between items-center text-neutral-content sticky top-0 z-20">
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
        <div v-if="authUser" class="dropdown dropdown-end">
          <router-link to="#" class="nav-link page-font" @click.native="handleLogout">ログアウト</router-link>
        </div>
        <div v-else>
          <router-link :to="{ name: 'LoginIndex' }">ログイン</router-link>
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
