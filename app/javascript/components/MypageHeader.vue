<template>
  <div class="w-full lg:block bg-gray-50 border rounded-lg shadow-sm sticky top-20 z-10">
    <div class="max-w-auto gap-8 p-4 pb-1">
      <div class="grid grid-cols-3">
        <div class="icon mr-5 flex justify-center items-center">
            <img :src="authUser.icon_url" class="rounded-full icon-image "  width="150px" />
        </div>
        <div class="flex flex-col bg-gray-100 rounded-lg gap-2 md:p-5">
          <p class="font-semibold mb-4 text-2xl">{{ user.name }}</p>
          <p class="font-semibold mb-1">推し：</p>
          <ul v-for="mygenreFavoriteCharacter in mygenreFavoriteCharacters" class="bg-white border shadow-sm rounded p-2">
            <li>{{ mygenreFavoriteCharacter.character.name }}</li>
          </ul>
        </div>
      </div>
    </div>
    <div class="flex flex-col border-t border-b"></div>
      <div class="max-w-full gap-4 p-4 mx-auto">
        <div class="justify-between grid grid-cols-2 gap-8">
          <div class="flex-row justify-start gap-2.5 ml-8  flex justify-center items-center">
            <router-link :to="{ name: 'MypageNew' }" button class="btn bg-indigo-800 text-white btn-outline mr-5">ジャンルを追加</router-link>
            <div class="flex flex-col gap-2">
              <div v-for="mygenreList in mygenreLists" :key=" mygenreList.id" class="bg-white border shadow-sm rounded p-2">
                <p>{{ mygenreList.mygenre.genre.name }}</p>
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
      myGenres: [],
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
  },
  methods: {
    fetchFavoriteCharacters() {
      this.$axios.get("mygenres")
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
