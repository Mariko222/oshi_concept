<template>
  <div>
    <MypageHeader v-if="authUser" class="mb-auto" />
    <div class="container mx-auto">
      <div class="bg-white py-6 sm:py-8 lg:py-12">
        <h2 class="text-gray-800 text-2xl lg:text-3xl font-bold mb-5">概念</h2>
        <div class="w-full">
          <div class="flex flex-wrap justify-between gap-4 mb-6">
            <div class="columns-2 md:columns-3 lg:columns-4">
              <div v-for="tweetUrl in tweetUrls">
                <Tweet :id="tweetUrl" class="mb-4"></Tweet>
              </div>
            </div>
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
