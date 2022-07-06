<template>
  <div class="container mx-auto">
    <MypageHeader v-if="authUser" class="mb-auto" />
    <div class="bg-white py-6 sm:py-8 lg:py-12">
      <div class="max-w-screen-2xl px-4 md:px-8 mx-auto">
        <div class="flex justify-between items-end gap-4 mb-6">
          <h2 class="text-gray-800 text-2xl lg:text-3xl font-bold">概念</h2>
        </div>
        <div v-for="tweetUrl in tweetUrls" class="flex items-end gap-2">
          <Tweet :id="tweetUrl"></Tweet>
        </div>
        <div class="grid sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-x-4 md:gap-x-6 gap-y-8">
          <div>
            <a href="#" class="group h-80 block bg-gray-100 rounded-lg overflow-hidden relative mb-2 lg:mb-3">
            </a>
          </div>
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

export default {
  components: {
    MypageHeader,
    Tweet
  },
  data() {
    return {
      tweets: [],
      webpages: [],
      tweetUrls: [],
      tweetUrl: ''
    }
  },
  computed: {
    ...mapGetters("users", ["authUser"])
  },
  created() {
    this.fetchPosts()
  },
  methods: {
    fetchPosts() {
      this.$axios.get("posts")
        .then(res => {
          this.posts = res.data
          this.webpages = this.posts.filter(p =>{
            return p.type === "webpage"
          })
          this.tweets = this.posts.filter(p =>{
            return p.type === "twitter"
          })
          this.tweetUrls = this.tweets.map(t =>{
            this.u = t.url.split('/')
            this.i = this.u[this.u.length - 1]
            return this.i.substr(0, this.i.indexOf('?'))
          })
        })
        .catch(err => console.log(err.status));}
  },
}
</script>
