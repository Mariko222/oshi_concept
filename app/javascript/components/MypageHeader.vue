<template>
  <div class="w-full lg:block bg-violet-300 border rounded-lg shadow-sm sticky top-20 z-10">
    <div class="max-w-auto gap-8 p-4 pb-1">
      <div class="grid grid-cols-3">
        <div class="icon mr-5 flex jflex flex-col flex justify-center items-center">
            <img :src="authUser.icon_url" class="rounded-full icon-image "/>
            <p class="page-font mt-5 mb-2 text-2xl">{{ user.name }}</p>
        </div>
        <div class="bg-violet-200 rounded-lg gap-2 md:p-5 mb-3">
          <p class="page-font mb-1">推し：</p>
          <div class="flex flex-wrap justify-between">
            <ul v-for="mygenreFavoriteCharacter in mygenreFavoriteCharacters" class="rounded p-2">
              <li class="page-font">{{ mygenreFavoriteCharacter.character.name }}</li>
            </ul>
          </div>
        </div>
        <div class="border-l-2 ml-5 mb-3 border-violet-500 ...">
          <div class="flex jflex flex-col gap-2.5 flex justify-between items-center">
            <div class="flex flex-col gap-2">
              <div v-for="mygenre in mygenres" :key=" mygenre.id" class="bg-violet-300">
                <p class="page-font bg-violet-200 border rounded p-2">{{ mygenre.name }}</p>
              </div>
            </div>
          </div>
            <ul class="flex flex-row justify-center items-center">
              <li>
                <router-link :to="{ name: 'MypageNew' }" class="page-font btn bg-rose-500 hover:bg-rose-400 active:bg-rose-600 rounded-lg transition duration-100 mt-8 mr-3">ジャンルを追加</router-link>
              </li>
              <li>
                <button
                  class="page-font flex justify-center bg-twitter hover:bg-sky-400 active:bg-sky-500 text-white font-semibold text-center rounded-lg outline-none transition duration-100 gap-2 mt-8 px-2 py-3"
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
                  Twitterで共有
                </button>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters } from "vuex"
import axios from "../plugins/axios";
export default {
  name: "MypageHeader",
  data() {
    return {
      mygenres: [],
      mygenreFavoriteCharacters: [],
      mygenreLists:[],
      user: ""
    }
  },
  computed: {
    ...mapGetters("users", ["authUser"])
  },
  created() {
    this.fetchFavoriteCharacters();
    this.fetchUser();
    this.fetchMygenres();
  },
  mounted() {
    this.fetchFavoriteCharacters();
    this.fetchUser();
    this.fetchMygenres();
  },
  methods: {
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
  }
}
</script>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Yusei+Magic&display=swap');
.page-font {
  font-family: 'Yusei Magic', sans-serif;
}
.icon img {
  width:  120px;
  height: 120px;
  border-radius: 50%;
  background-position: center center;
  object-fit:cover;
}
</style>
