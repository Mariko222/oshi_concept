<template>
  <div>
    <h2 class="text-gray-800 text-2xl lg:text-3xl font-bold mt-5 mb-5">ファッション</h2>
    <div class="w-full">
      <div class="flex flex-wrap justify-between gap-4 mb-6">
        <div class="columns-2 md:columns-3 lg:columns-4">
          <div v-for="fashionTweetUrl in fashionTweetUrls">
            <Tweet :id="fashionTweetUrl" class="mb-4"></Tweet>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "../../../plugins/axios";
import { Tweet } from 'vue-tweet-embed'

export default {
  components: {
    Tweet
  },
  data() {
    return {
      fashionTweets: [],
      fasionWebpages: [],
      fashionTweetUrls: [],
      fashionTweetUrl: ''
    }
  },
  created() {
    this.fetchFashionPosts()
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
          this.fashionTweetUrls = this.fashionTweets.map(t =>{
            this.u = t.url.split('/')
            this.i = this.u[this.u.length - 1]
            return this.i.substr(0, this.i.indexOf('?'))
          })
        })
        .catch(err => console.log(err.status));
    },
  },
}
</script>
