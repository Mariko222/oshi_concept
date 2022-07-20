<template>
  <div>
    <h2 class="page-font text-gray-800 text-2xl lg:text-3xl font-bold mt-5 mb-5">ファッション</h2>
    <div class="w-full">
      <div class="flex flex-wrap justify-between gap-4 mb-6">
        <div class="columns-2 md:columns-3 lg:columns-4">
          <div v-for="fashionTweet in fashionTweets">
            <div class="card bg-violet-400 px-2 py-2 -ml-2 mb-3">
              <Tweet :id="fashionTweet.tweet_url"></Tweet>
                <button type="button" @click="handleDeleteTweet(fashionTweet)">
                  <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-right" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z" />
                  </svg>
                </button>
            </div>
          </div>
        </div>
      </div>

      <div class="flex flex-wrap justify-between gap-4 mb-6">
        <div class="grid sm:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5 gap-4 md:gap-6 xl:gap-8">
          <div v-for="fashionWebpage in fashionWebpages">
            <div class="card bg-violet-400 px-2 py-2 -ml-2 mb-3">
              <div class="bg-white border rounded-lg overflow-hidden">
                <a :href="fashionWebpage.url" class="group h-48 md:h-64 block bg-gray-100 overflow-hidden relative">
                  <img src="../../../../../public/img/webpage.jpg" v-if="!fashionWebpage.image" loading="lazy" alt="NO_IMAGE" class="w-full h-full object-cover object-center absolute inset-0 group-hover:scale-110 transition duration-200" />
                  <img :src="fashionWebpage.image" loading="lazy" class="w-full h-full object-cover object-center absolute inset-0 group-hover:scale-110 transition duration-200" />
                </a>
                <div class="flex flex-col flex-1 p-4 sm:p-6">
                  <h2 class="text-gray-800 text-lg font-semibold mb-2">
                    <a :href="fashionWebpage.url" class="hover:text-indigo-500 active:text-indigo-600 transition duration-100">{{fashionWebpage.title}}</a>
                  </h2>
                </div>
              </div>
              <button type="button" @click="handleDeleteWebpage(fashionWebpage)" class="mt-2">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-right" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                  <path stroke-linecap="round" stroke-linejoin="round" d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z" />
                </svg>
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters } from "vuex"
import axios from "../../../plugins/axios";
import { Tweet } from 'vue-tweet-embed'

export default {
  components: {
    Tweet
  },
  data() {
    return {
      fashionWebpages: [],
      fashionTweets: [],
      fashionTweet: ''
    }
  },
  created() {
    this.fetchFashionPosts()
  },
  mounted() {
    this.fetchFashionPosts();
  },
  methods: {
    fetchFashionPosts() {
      this.$axios.get("posts")
        .then(res => {
          this.posts = res.data
          this.fashionPosts = this.posts.filter(p =>{
            return p.category === "fashion"
          })
          this.fashionWebpages = this.fashionPosts.filter(p =>{
            return p.type === "webpage"
          })
          this.fashionTweets = this.fashionPosts.filter(p =>{
            return p.type === "twitter"
          })
        })
        .catch(err => console.log(err.status));
    },
    handleDeleteTweet(fashionTweet) {
      this.post = fashionTweet
      this.$emit('delete-post', this.post)
    },
    handleDeleteWebpage(fashionWebpage) {
      this.post = fashionWebpage
      this.$emit('delete-post', this.post)
    },
  },
}
</script>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Yusei+Magic&display=swap');
.page-font {
  font-family: 'Yusei Magic', sans-serif;
}
</style>
