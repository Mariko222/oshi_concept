<template>
  <div>
    <MypageHeader class="-mt-16" @mygenre-posts="handleMygenre"/>
    <div class="container mx-auto mt-56">
      <router-link v-if="loginUser" :to="{ name: 'PostNew' }" class="btn px-2 py-1 bg-purple-100 text-indigo-500 border border-indigo-500 font-semibold hover:bg-indigo-200 rounded-full ">
        <span>投稿する</span>
        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-indigo-800" viewBox="0 0 20 20" fill="currentColor">
          <path d="M17.414 2.586a2 2 0 00-2.828 0L7 10.172V13h2.828l7.586-7.586a2 2 0 000-2.828z" />
          <path fill-rule="evenodd" d="M2 6a2 2 0 012-2h4a1 1 0 010 2H4v10h10v-4a1 1 0 112 0v4a2 2 0 01-2 2H4a2 2 0 01-2-2V6z" clip-rule="evenodd" />
        </svg>
      </router-link>
      <div class="bg-purple-100 py-6 sm:py-8 lg:py-12">
        <div class="md:flex">
          <div class="page-font btn m-1 bg-purple-500 hover:bg-purple-800 rounded-full" v-bind:class="{'active': isActive === '1'}" v-on:click="isSelect('1')" @click="all">ALL</div>
          <div class="page-font btn m-1 bg-purple-500 hover:bg-purple-800 rounded-full" v-bind:class="{'active': isActive === '2'}" v-on:click="isSelect('2')" @click="fashion">ファッション</div>
          <div class="page-font btn m-1 bg-purple-500 hover:bg-purple-800 rounded-full" v-bind:class="{'active': isActive === '3'}" v-on:click="isSelect('3')" @click="item">雑貨</div>
          <div class="page-font btn m-1 bg-purple-500 hover:bg-purple-800 rounded-full" v-bind:class="{'active': isActive === '4'}" v-on:click="isSelect('4')" @click="place">場所（お店や建物）</div>
        </div>
        <div v-if="isAll">
          <AllPosts @delete-post="handleDeletePost" :mygenre="mygenre" />
        </div>
        <div v-if="isFashion">
          <FashionPosts @delete-post="handleDeletePost" :mygenre="mygenre" />
        </div>
        <div v-if="isItem">
          <ItemPosts @delete-post="handleDeletePost" :mygenre="mygenre" />
        </div>
        <div v-if="isPlace">
          <PlacePosts @delete-post="handleDeletePost" :mygenre="mygenre" />
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import MypageHeader from "../../components/MypageHeader"
import { mapGetters } from "vuex"
import axios from "../../plugins/axios";
import { Tweet } from 'vue-tweet-embed'
import AllPosts from "./components/AllPosts"
import FashionPosts from "./components/FashionPosts"
import ItemPosts from "./components/ItemPosts"
import PlacePosts from "./components/PlacePosts"

export default {
  components: {
    MypageHeader,
    Tweet,
    AllPosts,
    FashionPosts,
    ItemPosts,
    PlacePosts
  },
  data() {
    return {
      isAll: false,
      isFashion: false,
      isItem: false,
      isPlace: false,
      mygenre: {},
      isActive: '',
      loginUser: ""
    }
  },
  created() {
    this.fetchUser()
  },
  computed: {
    ...mapGetters("users", ["authUser"])
  },
  methods: {
    all() {
      this.isAll = true
      this.isFashion = false
      this.isItem = false
      this.isPlace = false
    },
    fashion() {
      this.isAll = false
      this.isFashion = true
      this.isItem = false
      this.isPlace = false
    },
    item() {
      this.isAll = false
      this.isFashion = false
      this.isItem = true
      this.isPlace = false
    },
    place() {
      this.isAll = false
      this.isFashion = false
      this.isItem = false
      this.isPlace = true
    },
    handleMygenre(mygenre) {
      this.mygenre = mygenre
      this.isAll = false
    },
    handleDeletePost(post) {
      this.$axios.delete(`posts/${post.id}`)
      .then(res => {
        this.$router.go({path: this.$router.currentRoute.path, force: true})
        this.$store.dispatch("setFlash", {
          type: "success",
          message: "概念を削除しました。",
        })
      })
      .catch((error) => {
        console.log(error);
        this.errorMessage = error.response.data.errors.detail;
        this.$store.dispatch("setFlash", {
          type: "error",
          message: "概念削除できませんでした。",
        })
      })
    },
    isSelect: function (num) {
      this.isActive = num;
    },
    fetchUser() {
      this.$axios.get("users", {
        params: this.$route.params
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

<style scoped>

</style>
