<template>
  <div>
    <div class="mt-5">
      <div v-if="fashionTweets.length == 0  && fashionWebpages.length == 0">
        <p class="page-font">ファッションカテゴリの投稿がありません</p>
      </div>
      <div class="flex flex-wrap justify-between mb-6">
        <div class="w-full grid sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
          <div v-for="fashionTweet in fashionTweets">
            <div class="card bg-neutral px-2 py-2 mx-12 my-3 lg:mx-3 lg:my-3">
              <Tweet :id="fashionTweet.tweet_url"><div class="animate-spin h-10 w-10 border-4 border-blue-500 rounded-full border-t-transparent"></div></Tweet>
                <button type="button" v-if="loginUser" @click="handleDeleteTweet(fashionTweet)">
                  <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-right text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z" />
                  </svg>
                </button>
            </div>
          </div>
        </div>
      </div>

      <div class="flex flex-wrap justify-between mb-6">
        <div class="grid sm:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5">
          <div v-for="fashionWebpage in fashionWebpages">
            <div class="card bg-neutral px-2 py-2 m-3">
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
              <button type="button" v-if="loginUser" @click="handleDeleteWebpage(fashionWebpage)" class="mt-2">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-right text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
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
      fashionPosts: [],
      fashionWebpages: [],
      fashionTweets: [],
      fashionTweet: '',
      loginUser: ""
    }
  },
  props: {
    mygenre: {
      type: Object,
      required: true
    }
  },
  created() {
    this.fetchFashionBoth()
    this.fetchUser()
  },
  computed: {
    ...mapGetters("users", ["authUser"])
  },
  methods: {
    fetchFashionBoth: function (mygenre) {
      this.fashionTweets = [];
      this.fashionWebpages = [];
      this.fetchFashionTweets(mygenre);
      this.fetchFashionWebpages(mygenre);
    },
    fetchFashionTweets(mygenre) {
      this.$axios.get("posts", {
        params: this.$route.params
      })
        .then(res => {
          this.posts = res.data
          this.fashionPosts = this.posts.filter(p =>{
            return p.category === "fashion"
          })
          this.mygenreFashionPosts = this.fashionPosts.filter(p =>{
            return p.mygenre_id === this.mygenre['id']
          })
          this.fashionTweets = this.mygenreFashionPosts.filter(p =>{
            return p.type === "twitter"
          })
        })
        .catch(err => console.log(err.status));
    },
    fetchFashionWebpages(mygenre) {
      this.$axios.get("posts", {
        params: this.$route.params
      })
        .then(res => {
          this.posts = res.data
          this.fashionPosts = this.posts.filter(p =>{
            return p.category === "fashion"
          })
          this.mygenreFashionWabpages = this.fashionPosts.filter(p =>{
            return p.mygenre_id === this.mygenre['id']
          })
          this.fashionWebpages = this.mygenreFashionWabpages.filter(p =>{
            return p.type === "webpage"
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
