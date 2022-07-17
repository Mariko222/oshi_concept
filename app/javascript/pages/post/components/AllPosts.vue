<template>
  <div>
    <h2 class="text-gray-800 text-2xl lg:text-3xl font-bold mt-5 mb-5">概念</h2>
    <div class="w-full">
      <div class="flex flex-wrap justify-between gap-4 mb-6">
        <div class="columns-2 md:columns-3 lg:columns-4">
          <div v-for="tweetUrl in tweetUrls">
            <Tweet :id="tweetUrl" class="mb-4"></Tweet>
          </div>
        </div>
      </div>

      <div class="flex flex-wrap justify-between gap-4 mb-6">
        <div class="grid sm:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5 gap-4 md:gap-6 xl:gap-8">
          <div v-for="webpage in webpages">
            <div class="bg-white border rounded-lg overflow-hidden">
              <a :href="webpage.url" class="group h-48 md:h-64 block bg-gray-100 overflow-hidden relative">
                <img src="../../../../../public/img/webpage.jpg" v-if="!webpage.image" loading="lazy" alt="NO_IMAGE" class="w-full h-full object-cover object-center absolute inset-0 group-hover:scale-110 transition duration-200" />
                <img :src="webpage.image" loading="lazy" alt="NO_IMAGE" class="w-full h-full object-cover object-center absolute inset-0 group-hover:scale-110 transition duration-200" />
              </a>
              <div class="flex flex-col flex-1 p-4 sm:p-6">
                <h2 class="text-gray-800 text-lg font-semibold mb-2">
                  <a :href="webpage.url" class="hover:text-indigo-500 active:text-indigo-600 transition duration-100">{{webpage.title}}</a>
                </h2>
              </div>
            </div>
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
      webpages: [],
      tweetUrls: [],
      tweetUrl: ''
    }
  },
  created() {
    this.fetchPosts()
  },
  mounted() {
    this.fetchPosts();
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
        .catch(err => console.log(err.status));
    },
  },
}
</script>
