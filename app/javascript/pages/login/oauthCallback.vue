<template>
  <div>

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
      this.$store.dispatch("loginUser", userResponse.data);
      this.$store.dispatch("setFlash", {
        type: "success",
        message: "ログインしました",
      });
    } catch (error) {
      console.log(error)
      this.$store.dispatch("setFlash", {
        type: "error",
        message: "ログインに失敗しました。",
      });
    }
    this.$router.push({ name: "TopIndex" });
  },
};
</script>
