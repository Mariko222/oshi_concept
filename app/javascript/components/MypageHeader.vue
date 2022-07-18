<template>
  <div class="w-full lg:block bg-gray-50 border rounded-lg shadow-sm sticky top-20 z-10">
    <div class="max-w-auto gap-8 p-4 pb-1">
      <div class="grid grid-cols-3">
        <div class="icon mr-5 flex jflex flex-col flex justify-center items-center">
            <img :src="authUser.icon_url" class="rounded-full icon-image "  width="150px" />
            <p class="font-semibold mt-8 text-2xl">{{ user.name }}</p>
        </div>
        <div class="flex flex-col bg-gray-100 rounded-lg gap-2 md:p-5 mb-3">
          <p class="font-semibold mb-1">推し：</p>
          <ul v-for="mygenreFavoriteCharacter in mygenreFavoriteCharacters" class="bg-white border shadow-sm rounded p-2">
            <li>{{ mygenreFavoriteCharacter.character.name }}</li>
          </ul>
        </div>
        <div class="border-l-2 ml-5 mb-3 border-gray-300 ...">
          <div class="flex jflex flex-col gap-2.5 flex justify-center items-center">
              <router-link :to="{ name: 'MypageNew' }" button class="btn bg-indigo-800 text-white btn-outline mr-5">ジャンルを追加</router-link>
              <div class="flex flex-col gap-2">
                <div v-for="mygenre in mygenres" :key=" mygenre.id" class="bg-white border shadow-sm rounded p-2">
                  <p>{{ mygenre.name }}</p>
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
.icon img {
  width:  150px;
  height: 150px;
  border-radius: 50%;
  background-position: center center;
  object-fit:cover;
}
</style>
