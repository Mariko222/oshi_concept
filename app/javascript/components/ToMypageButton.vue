<template>
  <router-link :to="'/mypage/'+authUser.uuid" class="nav-link">
    <div class="relative inline-flex items-center justify-center mt-12 w-30 p-2 overflow-hidden font-medium transition duration-300 ease-out border-2 border-purple-500 rounded-full shadow-md group">
      <span class="absolute inset-0 flex items-center justify-center w-full h-full text-white duration-300 -translate-x-full bg-purple-500 group-hover:translate-x-0 ease">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
          <path stroke-linecap="round" stroke-linejoin="round" d="M11 19l-7-7 7-7m8 14l-7-7 7-7" />
        </svg>
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14 5l7 7m0 0l-7 7m7-7H3" />
      </span>
      <span class="page-font absolute flex items-center justify-center text-purple-500 transition-all duration-300 transform group-hover:translate-x-full ease">マイページへ</span>
      <span class="page-font relative invisible">マイページへ</span>
    </div>
  </router-link>
</template>

<script>
import { mapGetters, mapActions } from "vuex"
import axios from "../plugins/axios";
export default {
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
    fetchShareUser() {
      const dir = location.href.split("/");
      const dir2 = dir[dir.length -1];
      this.$axios.get("users", {
        params:{ uuid:dir2 }
        })
      .then(res => {
        this.user = res.data
        if (this.user.uuid === this.authUser.uuid) {
          this.loginUser = this.user
        }
      })
      .catch(err => console.log(err.status));
    },
  },
}
</script>
