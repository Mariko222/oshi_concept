<template>
  <div class="w-full lg:block bg-gray-50 border rounded-lg shadow-sm sticky top-20 z-10">
    <div class="max-w-auto gap-8 p-8">
      <div class="grid grid-cols-2">
        <div class="avatar pl-8">
          <div class="rounded-full bg-gray-500">
            <img src="" />
          </div>
        </div>
        <ul class="flex flex-col bg-gray-100 rounded-lg gap-4 p-4 md:p-8">
          <li class="font-semibold mb-1">ユーザーネーム</li>
          <li class="font-semibold mb-1">推し：</li>
          <div v-for="mygenreFavoriteCharacter in mygenreFavoriteCharacters" class="bg-white border shadow-sm rounded p-2">
            <p>{{ mygenreFavoriteCharacter.character.name }}</p>
          </div>
        </ul>
      </div>
    </div>
    <div class="flex flex-col border-t border-b my-5"></div>
      <div class="max-w-full gap-4 p-4 mx-auto">
        <div class="justify-between grid grid-cols-2 gap-8">
          <div class="flex-row justify-start gap-2.5 ml-8">
            <router-link :to="{ name: 'MypageNew' }" button class="btn bg-indigo-800 text-white btn-outline mr-5">ジャンルを追加</router-link>
            <div v-for="mygenreList in mygenreLists" :key=" mygenreList.id" class="bg-white border shadow-sm rounded p-2">
              <p>{{ mygenreList.mygenre.genre.name }}</p>
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
      mygenreLists:[]
    }
  },
  created() {
    this.fetchFavoriteCharacters();
    this.duplicate();
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
  }
}
</script>
