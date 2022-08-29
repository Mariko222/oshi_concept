<template>
  <div class="container mx-auto">
    <div class="max-w-screen-2x">
      <section class="flex flex-col items-center">
        <div class="max-w-xl items-center text-center">
          <div class="flex justify-center">
            <div class="animate-ping h-2 w-2 bg-purple-800 rounded-full"></div>
            <div class="animate-ping h-2 w-2 bg-purple-800 rounded-full mx-4"></div>
            <div class="animate-ping h-2 w-2 bg-purple-800 rounded-full"></div>
          </div>
        </div>
      </section>
    </div>
  </div>
</template>

<script>

import axios from "../../plugins/axios";
export default {
  async mounted() {
    try {
      const userResponse = await axios.post("oauth/callback", {
        provider: "twitter",
        oauth_token: this.$route.query.oauth_token,
        oauth_verifier: this.$route.query.oauth_verifier,
      });
      this.$store.dispatch("users/loginUser", userResponse.data);
      this.$router.push({ name: "TopIndex" });
      this.$store.dispatch("setFlash", {
        type: "success",
        message: "ログインしました",
      });
    } catch (error) {
      this.$store.dispatch("setFlash", {
        type: "error",
        message: "ログインに失敗しました。",
      });
    }
  }
};
</script>
