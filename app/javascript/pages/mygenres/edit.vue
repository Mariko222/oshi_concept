<template>
  <div class="bg-purple-100 py-6 sm:py-8 lg:py-12">
    <div class="max-w-screen-2xl px-4 md:px-8 mx-auto">
      <h2 class="text-gray-800 text-2xl lg:text-3xl page-font text-center mb-4 md:mb-8">推しを変更</h2>
      <ValidationObserver v-slot="ObserverProps">
        <form class="bg-white max-w-lg border rounded-lg mx-auto">
          <div class="flex flex-col gap-4 p-4 md:p-8">
            <ValidationProvider name="ジャンル" rules="required" :skip-if-empty="false">
              <div slot-scope="ProviderProps">
              <label for="genre_name" class="page-font inline-block text-gray-800 text-sm sm:text-base mb-2">ジャンル：</label>
              <select id="genre_id" name="genre" v-model="selectedGenre" class="page-font input-form-basic-block" @change="fetchBoth(selectedGenre)" >
                <option disabled value="">ジャンルを選択</option>
                <option v-for="mygenre in mygenres" :value="mygenre.id">{{ mygenre.name }}</option>
              </select>
              <p class="page-font text-red-500">{{
                  ProviderProps.errors[0]
                }}</p>
              </div>
            </ValidationProvider>
            <div>
              <div v-if="isSelected">
                <p class="page-font font-semibold mb-1">推し：</p>
                <ul v-for="mygenreCharacter in mygenreCharacters" :value="mygenreCharacter.id" class="mx-auto flex justify-between bg-white border shadow-sm rounded p-2">
                  <li class="page-font">{{ mygenreCharacter.character.name }}
                  </li>
                  <button type="button" @click="handleDeleteCharacter(mygenreCharacter)">
                    <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-right" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                      <path stroke-linecap="round" stroke-linejoin="round" d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z" />
                    </svg>
                  </button>
                </ul>
              </div>
              <label for="character.name" class="page-font inline-block text-gray-800 text-sm sm:text-base mb-2">推し（複数選択可）：</label>
              <span class="page-font" v-if="!selectedCharacterNames.length == 0">{{ selectedCharacterNames }}</span>
              <button
              type="button"
              @click="handleOpenChoiceCharactersModal"
              :disabled="ObserverProps.invalid || !ObserverProps.validated"
              class="page-font block bg-indigo-800 hover:bg-indigo-700 disabled:bg-indigo-400 active:bg-indigo-600 text-white text-center rounded-lg outline-none transition duration-100 px-3 py-2"
              >
                推しを追加
              </button>
            </div>
            <button
              type="button"
              class="page-font bg-gray-800 hover:bg-gray-700 disabled:bg-gray-400 active:bg-gray-600 text-white font-semibold text-center rounded-lg outline-none transition duration-100 mx-20 py-3"
              :disabled="ObserverProps.invalid || !ObserverProps.validated"
              @click="register"
            >
              登録
            </button>
          </div>
        </form>
      </ValidationObserver>
    </div>
    <ChoiceCharactersModal
      v-if="isVisibleChoiceCharactersModal"
      @close-modal="handleCloseChoiceCharactersModal"
      @choice-characters="displayCharacters"
      :characters="characters"
      :character="character"
      :key="character.id"
    />
  </div>
</template>

<script>
import ChoiceCharactersModal from '../mypage/components/ChoiceCharactersModal'
import axios from "../../plugins/axios";
import { mapGetters, mapActions } from "vuex"
export default {
  name: "MygenresEdit",
  components: {
    ChoiceCharactersModal
  },
  data() {
    return {
      isVisibleChoiceCharactersModal: false,
      isSelected: false,
      genres: [],
      genre: {
      },
      mygenres: [],
      selectedGenre: '',
      characters: [],
      character: {
      },
      selectedCharacters: [],
      selectedCharacterNames:[],
      mygenreFavoriteCharacters: [],
      errorMessage: ""
    }
  },
  created() {
    this.fetchMygenres();
    this.fetchFavoriteCharacters();
    this.user = Object.assign({}, this.authUser)
  },
  mounted() {
    this.fetchFavoriteCharacters();
    this.fetchMygenres();
  },
  computed: {
    ...mapGetters("users", ["authUser"])
  },
  methods: {
    handleOpenChoiceCharactersModal() {
      this.isVisibleChoiceCharactersModal = true;
      this.selectedCharacterNames = []
    },
    handleCloseChoiceCharactersModal() {
      this.isVisibleChoiceCharactersModal = false;
    },
    displayCharacters(selectedCharacters){
      this.characters.forEach(c => {
        selectedCharacters.forEach(s => {
          if (c['id'] === s){
            this.selectedCharacterNames += `  ${c['name']}`
          }
        })
      })
      this.selectedCharacters = selectedCharacters
      this.handleCloseChoiceCharactersModal();
    },
    fetchMygenres() {
      this.$axios.get("mygenre_characters")
        .then(res => {
          this.mygenres = res.data
        })
        .catch(err => console.log(err.status));
    },
    fetchBoth: function (selectedGenre) {
      this.fetchCharacters(selectedGenre);
      this.fetchFavoriteCharacters(selectedGenre);
    },
    fetchCharacters(selectedGenre) {
      this.$axios.get("characters", {
        params:{ id:selectedGenre }
      })
        .then(res => {
          this.characters = res.data
          this.isSelected = true;
        })
        .catch(err => console.log(err.status));
    },
    fetchFavoriteCharacters(selectedGenre) {
      this.$axios.get("mypage")
        .then(res => {
          this.mygenreFavoriteCharacters = res.data
          this.mygenreLists = this.mygenreFavoriteCharacters.filter((item, index, self) => {
            return self.findIndex(i =>
              i['mygenre_id'] === item['mygenre_id']
            ) === index
          })
          this.mygenreCharacters = this.mygenreFavoriteCharacters.filter(c =>{
            return c.mygenre['genre_id'] === selectedGenre
          })
        })
        .catch(err => console.log(err.status));
    },
    async handleDeleteCharacter(mygenreCharacter) {
      try {
        await
        axios.delete(`mygenres/${mygenreCharacter.id}`)
        this.$store.dispatch("setFlash", {
          type: "success",
          message: "推しから削除しました。",
        });
        this.$router.push({ name: 'PostIndex' });
      } catch (error) {
        console.log(error);
        this.errorMessage = error.response.data.errors.detail;
        this.$store.dispatch("setFlash", {
          type: "error",
          message: "推しを削除できませんでした。",
        })
      }
    },
    async register() {
      try {
        await this.fetchMygenres()
        const params = {
          genre_id: this.selectedGenre,
          character_ids: this.selectedCharacters,
        }
        this.$axios.post("mygenres", params)
        this.$store.dispatch("setFlash", {
          type: "success",
          message: "推しを変更しました。",
        });
        this.$router.push({ name: 'PostIndex' });
      } catch (error) {
        console.log(error);
        this.errorMessage = error.response.data.errors.detail;
        this.$store.dispatch("setFlash", {
          type: "error",
          message: "推しを変更できませんでした。",
        })
      }
    },
  }
}
</script>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Yomogi&display=swap');
.page-font {
  font-family: 'Yomogi', cursive;
}
</style>
