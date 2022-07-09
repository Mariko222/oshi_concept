<template>
  <div>
    <h2 class="text-gray-800 text-2xl lg:text-3xl font-bold mt-5 mb-5">場所（お店や建物）</h2>
    <div class="w-full">
      <div class="flex flex-wrap justify-between gap-4 mb-6">
        <div class="columns-2 md:columns-3 lg:columns-4">
          <div v-for="placeTweetUrl in placeTweetUrls">
            <Tweet :id="placeTweetUrl" class="mb-4"></Tweet>
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
      placeTweets: [],
      placeWebpages: [],
      placeTweetUrls: [],
      placeTweetUrl: ''
    }
  },
  created() {
    this.fetchplacePosts()
  },
  methods: {
    fetchplacePosts() {
      this.$axios.get("posts")
        .then(res => {
          this.posts = res.data
          this.placePosts = this.posts.filter(p =>{
            return p.category === "place"
          })
          this.placeWebpages = this.placePosts.filter(p =>{
            return p.type === "webpage"
          })
          this.placeTweets = this.placePosts.filter(p =>{
            return p.type === "twitter"
          })
          this.placeTweetUrls = this.placeTweets.map(t =>{
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
