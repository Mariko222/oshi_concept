<template>
  <div class="w-full h-48 bg-violet-300 sticky top-20 z-10">
    <div class="max-w-auto h-auto p-4 pb-1">
      <div class="grid grid-cols-3">
        <div class="icon sm:-pt-6 lg:-mt-12 pb-5 flex flex-col justify-center items-center">
          <div v-if="!user.icon_url">
            <img alt="icon" class="icon-image lg:mt-12 rounded-full" src="../../../public/img/default_icon.jpg">
          </div>
          <div v-else>
            <img :src="user.icon_url" class="rounded-full icon-image lg:mt-12"/>
          </div>
          <router-link v-if="loginUser" :to="{ name: 'MypageEdit' }" class="nav-link">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-indigo-800" viewBox="0 0 20 20" fill="currentColor">
              <path d="M17.414 2.586a2 2 0 00-2.828 0L7 10.172V13h2.828l7.586-7.586a2 2 0 000-2.828z" />
              <path fill-rule="evenodd" d="M2 6a2 2 0 012-2h4a1 1 0 010 2H4v10h10v-4a1 1 0 112 0v4a2 2 0 01-2 2H4a2 2 0 01-2-2V6z" clip-rule="evenodd" />
            </svg>
          </router-link>
          <ul class="justify-center items-center md:flex">
            <li>
              <ShareNetwork
                :url="'https://www.oshi-concept.com/mypage/'+ user.uuid"
                :title="user.name + 'の推し概念集めてみた【' + user.mypage_name + '】を公開'"
                description="推しの概念を集めたマイページを公開"
                network="twitter"
                hashtags="推し概念集めてみた"
              >
                <div>
                  <button
                    class="page-font text-xs flex justify-center bg-twitter hover:bg-sky-400 active:bg-sky-500 text-white font-semibold text-center rounded-full transition duration-100 gap-2 mt-3 px-2 py-2"
                  >
                    <svg class="w-5 h-5 shrink-0" width="24" height="24" viewBox="328 355 335 276" fill="none" xmlns="http://www.w3.org/2000/svg">
                      <path d="
                        M 630, 425
                        A 195, 195 0 0 1 331, 600
                        A 142, 142 0 0 0 428, 570
                        A  70,  70 0 0 1 370, 523
                        A  70,  70 0 0 0 401, 521
                        A  70,  70 0 0 1 344, 455
                        A  70,  70 0 0 0 372, 460
                        A  70,  70 0 0 1 354, 370
                        A 195, 195 0 0 0 495, 442
                        A  67,  67 0 0 1 611, 380
                        A 117, 117 0 0 0 654, 363
                        A  65,  65 0 0 1 623, 401
                        A 117, 117 0 0 0 662, 390
                        A  65,  65 0 0 1 630, 425
                        Z"
                        fill="white" />
                    </svg>
                    共有する
                  </button>
                </div>
              </ShareNetwork>
            </li>
          </ul>
        </div>
        <div>
          <div class="bg-violet-200 h-full -mt-3 mr-1 px-2 py-3 rounded-lg">
            <p class="page-font mb-1 text-xs lg:text-base"><span class="page-font">{{ user.name }}</span>の推し：</p>
            <router-link v-if="loginUser" :to="{ name: 'MygenresEdit' }" class="nav-link">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-indigo-800" viewBox="0 0 20 20" fill="currentColor">
                <path d="M17.414 2.586a2 2 0 00-2.828 0L7 10.172V13h2.828l7.586-7.586a2 2 0 000-2.828z" />
                <path fill-rule="evenodd" d="M2 6a2 2 0 012-2h4a1 1 0 010 2H4v10h10v-4a1 1 0 112 0v4a2 2 0 01-2 2H4a2 2 0 01-2-2V6z" clip-rule="evenodd" />
              </svg>
            </router-link>
            <div class="flex flex-wrap justify-between">
              <p class="page-font text-xs lg:text-base" v-if="mygenreCharacters.length === 0">登録したジャンルを選んでください。</p>
              <ul v-for="mygenreCharacter in mygenreCharacters" class="rounded">
                <li class="page-font text-xs lg:text-xl">{{ mygenreCharacter.character.name }}</li>
              </ul>
            </div>
          </div>
        </div>
        <div class="flex flex-col my-auto items-center">
          <p class="page-font text-xs lg:text-base mb-3 -mt-6"><span class="page-font text-xs lg:text-base">{{ user.name }}</span>のジャンルリスト:</p>
          <div class="flex">
            <p class="page-font text-xs lg:text-base mr-3 -mt-1" v-if="mygenres.length === 0">ジャンルを追加してください</p>
            <router-link v-if="loginUser" :to="{ name: 'MypageNew' }" class="nav-link">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-indigo-800" viewBox="0 0 20 20" fill="currentColor">
                <path d="M17.414 2.586a2 2 0 00-2.828 0L7 10.172V13h2.828l7.586-7.586a2 2 0 000-2.828z" />
                <path fill-rule="evenodd" d="M2 6a2 2 0 012-2h4a1 1 0 010 2H4v10h10v-4a1 1 0 112 0v4a2 2 0 01-2 2H4a2 2 0 01-2-2V6z" clip-rule="evenodd" />
              </svg>
            </router-link>
          </div>
          <div class="flex flex-col justify-between items-center">
            <div v-for="(mygenre, index) in mygenres" :key="mygenre.id">
              <button
                class="page-font text-white text-xs lg:text-base bg-indigo-500 hover:bg-indigo-800 border rounded-full p-2"
                @click="fetchBoth(mygenre)"
                v-bind:class="{'active': isActive === index}" v-on:click="isSelect(index)"
              >{{ mygenre.genre.name }}</button>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapState, mapGetters } from "vuex"
import axios from "../plugins/axios";
import { createNamespacedHelpers } from 'vuex';
const { mapMutations } = createNamespacedHelpers('mygenre')
export default {
  name: "MypageHeader",
  data() {
    return {
      mygenres: [],
      mygenreCharacters:[],
      user: "",
      isActive: '',
      loginUser: ""
    }
  },
  computed: {
    ...mapGetters("users", ["authUser"]),
    ...mapGetters("mygenre", ["mygenre"]),
    ...mapState("mygenre", ["mygenre"])
  },
  created() {
    this.fetchMygenres();
    this.displayCharacter();
    this.fetchBoth(this.mygenre)
    this.fetchUser();
  },
  methods: {
    ...mapMutations([
      "loadMygenre"
    ]),
    fetchMygenres() {
      this.$axios.get("mygenres", {
        params: this.$route.params
      })
        .then(res => {
          this.mygenres = res.data
        })
        .catch(err => console.log(err.status));
    },
    fetchBoth: function (mygenre) {
      this.loadMygenre(mygenre);
      this.displayCharacter(mygenre);
      this.handleMygenrePosts(mygenre);
    },
    displayCharacter(mygenre) {
      this.$axios.get("mypage", {
        params: this.$route.params
      })
      .then(res => {
        this.mygenreFavoriteCharacters = res.data
        this.mygenreCharacters = this.mygenreFavoriteCharacters.filter(c =>{
          return c.mygenre['id'] === mygenre.id
        })
      })
      .catch(err => console.log(err.status));
    },
    handleMygenrePosts(mygenre) {
      this.$emit('mygenre-posts', this.mygenre)
    },
    isSelect: function (index) {
      this.isActive = index;
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
