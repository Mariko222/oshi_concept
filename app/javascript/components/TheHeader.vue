<template>
  <div class="navbar bg-yellow-900 h-20 mx-auto flex justify-between items-center text-neutral-content sticky top-0 z-20">
    <div class="navbar-start">
      <p class="page-font text-xs lg:text-base">
        <router-link :to="{ name: 'TopIndex' }">
          <img img src="../../../public/img/logo.jpg" loading="lazy" alt="mypage-top" class="h-20 w-20" />
        </router-link>
      </p>
    </div>
    <template v-if="authUser">
      <div class="navbar-center">
        <p class="page-font text-2xl">{{ authUser.mypage_name }}</p>
      </div>
    </template>
    <template v-if="!authUser && $route.name == 'PostIndex'">
      <div class="navbar-center">
        <p class="page-font text-2xl">{{ user.mypage_name }}</p>
      </div>
    </template>
    <div class="navbar-end">
      <div class="flex-none">
        <div v-if="authUser" class="dropdown dropdown-end">
          <router-link to="#" class="nav-link page-font text-xs lg:text-base" @click.native="handleLogout">ログアウト</router-link>
        </div>
        <div v-else>
          <router-link :to="{ name: 'LoginIndex' }" class="page-font text-xs lg:text-base">ログイン</router-link>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters, mapActions } from "vuex"
import axios from "../plugins/axios";
export default {
  name: "TheHeader",
  data() {
    return {
      user: {
        uuid: ""
      },
    }
  },
  computed: {
    ...mapGetters("users", ["authUser"])
  },
  created() {
    this.fetchShareUser();
  },
  methods: {
    ...mapActions("users", ["logoutUser"]),
    async handleLogout() {
      try {
        await this.logoutUser()
        this.user = ""
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
    },
    fetchShareUser() {
      const dir = location.href.split("/");
      const dir2 = dir[dir.length -1];
      this.$axios.get("users", {
        params:{ uuid:dir2 }
        })
      .then(res => {
        this.user = res.data
        console.log(res.data)
        if (this.user.uuid === this.authUser.uuid) {
          this.loginUser = this.user
        }
      })
      .catch(err => console.log(err.status));
    },
  },
}
</script>

<style scoped>

</style>
