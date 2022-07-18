<template>
  <div>
    <MypageHeader v-if="authUser" class="mb-auto" />
    <div class="container mx-auto">
      <div class="bg-purple-100 py-6 sm:py-8 lg:py-12">
        <button class="btn btn-primary" @click="fashion">ファッション</button>
        <button class="btn btn-secondary" @click="item">雑貨</button>
        <button class="btn btn-accent" @click="place">場所（お店や建物）</button>
        <div v-if="isAll">
          <AllPosts></AllPosts>
        </div>
        <div v-if="isFashion">
          <FashionPosts></FashionPosts>
        </div>
        <div v-if="isItem">
          <ItemPosts></ItemPosts>
        </div>
        <div v-if="isPlace">
          <PlacePosts></PlacePosts>
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
      isPlace: false
    }
  },
  computed: {
    ...mapGetters("users", ["authUser"])
  },
  methods: {
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
    }
  },
}
</script>
