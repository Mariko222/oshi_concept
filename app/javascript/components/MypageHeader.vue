<template>
  <div class="w-full h-48 bg-violet-300 sticky top-20 z-10">
    <div class="max-w-auto h-auto p-4 pb-1">
      <div class="grid grid-cols-3">
        <div class="icon sm:-pt-6 lg:-mt-12 pb-5 flex jflex flex-col flex justify-center items-center">
          <img alt="icon" v-if="!authUser.icon_url" class="icon-image lg:mt-12 rounded-full" src="../../../public/img/default_icon.jpg">
          <img :src="authUser.icon_url" v-if="authUser.icon_url" class="rounded-full icon-image lg:mt-12"/>
          <router-link :to="{ name: 'MypageEdit' }" class="nav-link">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-indigo-800" viewBox="0 0 20 20" fill="currentColor">
              <path d="M17.414 2.586a2 2 0 00-2.828 0L7 10.172V13h2.828l7.586-7.586a2 2 0 000-2.828z" />
              <path fill-rule="evenodd" d="M2 6a2 2 0 012-2h4a1 1 0 010 2H4v10h10v-4a1 1 0 112 0v4a2 2 0 01-2 2H4a2 2 0 01-2-2V6z" clip-rule="evenodd" />
            </svg>
          </router-link>
          <ul class="justify-center items-center md:flex">
            <li>
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
            </li>
          </ul>
        </div>
        <div>
          <div class="bg-violet-200 h-full -mt-3 mr-1 px-2 py-3 rounded-lg">
            <p class="page-font mb-1 text-xs lg:text-base"><span class="page-font">{{ authUser.name }}</span>の推し：</p>
            <router-link :to="{ name: 'MygenresEdit' }" class="nav-link">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-indigo-800" viewBox="0 0 20 20" fill="currentColor">
                <path d="M17.414 2.586a2 2 0 00-2.828 0L7 10.172V13h2.828l7.586-7.586a2 2 0 000-2.828z" />
                <path fill-rule="evenodd" d="M2 6a2 2 0 012-2h4a1 1 0 010 2H4v10h10v-4a1 1 0 112 0v4a2 2 0 01-2 2H4a2 2 0 01-2-2V6z" clip-rule="evenodd" />
              </svg>
            </router-link>
            <div class="flex flex-wrap justify-between">
              <p class="page-font text-xs lg:text-base" v-if="mygenreCharacters.length === 0">登録したジャンルを選んでください。</p>
              <ul v-for="mygenreCharacter in mygenreCharacters" class="rounded p-2">
                <li class="page-font text-xs lg:text-xl">{{ mygenreCharacter.character.name }}</li>
              </ul>
            </div>
          </div>
        </div>
        <div class="flex flex-col my-auto items-center">
          <div class="flex">
            <p class="page-font text-xs lg:text-base mb-3 -mt-6"><span class="page-font text-xs lg:text-base">{{ authUser.name }}</span>のジャンルリスト:</p>
            <router-link :to="{ name: 'MypageNew' }" class="nav-link">
              <button
                class="w-5 h-5 bg-purple-700 rounded-full hover:bg-purple-800 active:shadow-lg mouse shadow transition ease-in duration-200 focus:outline-none">
                <svg viewBox="0 0 20 30" enable-background="new 0 0 20 20" class="w-5 h-5 inline-block">
                  <path fill="#FFFFFF" d="M16,10c0,0.553-0.048,1-0.601,1H11v4.399C11,15.951,10.553,16,10,16c-0.553,0-1-0.049-1-0.601V11H4.601
                                          C4.049,11,4,10.553,4,10c0-0.553,0.049-1,0.601-1H9V4.601C9,4.048,9.447,4,10,4c0.553,0,1,0.048,1,0.601V9h4.399
                                          C15.952,9,16,9.447,16,10z" />
                </svg>
              </button>
            </router-link>
          </div>
          <p class="page-font text-xs lg:text-base" v-if="mygenres.length === 0">ジャンルを追加してください</p>
          <div class="flex flex-col flex justify-between items-center">
            <div v-for="mygenre in mygenres" :key="mygenre.id">
              <button class="page-font text-white text-xs lg:text-base bg-indigo-500 border rounded-full p-2" @click="fetchBoth(mygenre)">{{ mygenre.genre.name }}</button>
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
      mygenreFavoriteCharacters: [],
      mygenreCharacters:[],
      myCharacters: [],
      user: ""
    }
  },
  computed: {
    ...mapGetters("users", ["authUser"]),
    ...mapGetters("mygenre", ["mygenre"]),
    ...mapState("mygenre", ["mygenre"])
  },
  created() {
    this.fetchFavoriteCharacters();
    this.fetchUser();
    this.fetchMygenres();
    this.displayCharacter();
    this.fetchBoth(this.mygenre)
  },
  mounted() {
    this.fetchFavoriteCharacters();
    this.fetchUser();
  },
  methods: {
    ...mapMutations([
      "loadMygenre"
    ]),
    fetchFavoriteCharacters() {
      this.$axios.get("mypage")
        .then(res => {
          this.mygenreFavoriteCharacters = res.data
          this.mygenreLists = this.mygenreFavoriteCharacters.filter((item, index, self) => {
            return self.findIndex(i =>
              i['mygenre_id'] === item['mygenre_id']
            ) === index
          })
        })
        .catch(err => console.log(err.status));
    },
    fetchMygenres() {
      this.$axios.get("mygenres")
        .then(res => {
          this.mygenres = res.data
        })
        .catch(err => console.log(err.status));
    },
    fetchUser() {
      this.$axios.get("sessions")
        .then(res => {
          this.user = res.data
        })
        .catch(err => console.log(err.status));
    },
    fetchBoth: function (mygenre) {
      this.loadMygenre(mygenre);
      this.displayCharacter(mygenre);
      this.handleMygenrePosts(mygenre);
    },
    displayCharacter(mygenre) {
      this.$axios.get("mypage")
        .then(res => {
          this.mygenreFavoriteCharacters = res.data
          this.mygenreCharacters = this.mygenreFavoriteCharacters.filter(c =>{
            return c.mygenre['id'] === mygenre.id
          })
        })
        .catch(err => console.log(err.status));
    },
    handleMygenrePosts(mygenre) {
      this.mygenre = mygenre
      this.$emit('mygenre-posts', this.mygenre)
    }
  }
}
</script>

<style scoped>

</style>
