<template>
  <div>
    <MypageHeader v-if="authUser" class="-mt-16" @mygenre-posts="handleMygenre"/>
    <div class="container mx-auto mt-56">
      <div class="bg-purple-100 py-6 sm:py-8 lg:py-12">
        <button class="page-font btn btn" v-bind:class="{'active': isActive === '1'}" v-on:click="isSelect('1')" @click="all">ALL</button>
        <button class="page-font btn btn" v-bind:class="{'active': isActive === '2'}" v-on:click="isSelect('2')" @click="fashion">ファッション</button>
        <button class="page-font btn btn" v-bind:class="{'active': isActive === '3'}" v-on:click="isSelect('3')" @click="item">雑貨</button>
        <button class="page-font btn btn" v-bind:class="{'active': isActive === '4'}" v-on:click="isSelect('4')" @click="place">場所（お店や建物）</button>
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
      isActive: ''
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
    }
  },
}
</script>

<style scoped>
.active {
  background-color: purple;
}
</style>
