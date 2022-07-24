<template>
  <div>
    <MypageHeader v-if="authUser" class="mb-auto" @mygenre-posts="handleMygenre"/>
    <div class="container mx-auto">
      <div class="bg-purple-100 py-6 sm:py-8 lg:py-12">
        <button class="page-font btn btn" @click="all">ALL</button>
        <button class="page-font btn btn-primary" @click="fashion">ファッション</button>
        <button class="page-font btn btn-secondary" @click="item">雑貨</button>
        <button class="page-font btn btn-accent" @click="place">場所（お店や建物）</button>
        <div v-if="isAll">
          <AllPosts @delete-post="handleDeletePost" :mygenre="mygenre" />
        </div>
        <div v-if="isFashion">
          <FashionPosts @delete-post="handleDeletePost"/>
        </div>
        <div v-if="isItem">
          <ItemPosts @delete-post="handleDeletePost"/>
        </div>
        <div v-if="isPlace">
          <PlacePosts @delete-post="handleDeletePost"/>
        </div>
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
      isAll: true,
      isFashion: false,
      isItem: false,
      isPlace: false,
      mygenre: {}
    }
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
    },
    handleDeletePost(post) {
      this.$axios.delete(`posts/${post.id}`)
      .then(res => {
        this.$store.dispatch("setFlash", {
          type: "success",
          message: "概念を削除しました。",
        })
        this.all()
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
  },
}
</script>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Yomogi&display=swap');
.page-font {
  font-family: 'Yomogi', cursive;
}
</style>
