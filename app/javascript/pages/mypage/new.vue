<template>
  <div class="mt-8 bg-purple-100 py-6 sm:py-8 lg:py-12">
    <div class="max-w-screen-2xl px-4 md:px-8 mx-auto">
      <h2 class="text-gray-800 text-2xl lg:text-3xl page-font text-center mb-4 md:mb-8">ジャンルを追加</h2>
      <ValidationObserver v-slot="ObserverProps">
        <form class="bg-white max-w-lg border rounded-lg mx-auto">
          <div class="flex flex-col gap-4 p-4 md:p-8">
            <ValidationProvider name="ジャンル" rules="required" :skip-if-empty="false">
              <div slot-scope="ProviderProps">
                <label for="genre_name" class="page-font inline-block text-gray-800 text-sm sm:text-base mb-2">ジャンル：</label>
                <select id="genre_id" name="genre" v-model="selectedGenre" class="page-font input-form-basic-block w-full" @change="fetchCharacters(selectedGenre)" >
                  <option disabled value="">ジャンルを選択</option>
                  <option v-for="genre in genres" :value="genre.id">{{ genre.name }}</option>
                </select>
                <p class="page-font text-red-500">{{
                  ProviderProps.errors[0]
                }}</p>
              </div>
            </ValidationProvider>

            <div>
              <label for="character.name" class="page-font inline-block text-gray-800 text-sm sm:text-base mb-2">推し（複数選択可）：</label>
              <span class="page-font" v-if="!selectedCharacterNames.length == 0">{{ selectedCharacterNames }}</span>
              <button
              type="button"
              @click="handleOpenChoiceCharactersModal"
              :disabled="ObserverProps.invalid || !ObserverProps.validated"
              class="page-font block bg-indigo-800 hover:bg-indigo-700 disabled:bg-indigo-400 active:bg-indigo-600 text-white text-center rounded-full outline-none transition duration-100 px-3 py-2"
              >
                推しを選択
              </button>
            </div>

            <button
              type="button"
              class="page-font bg-yellow-700 hover:bg-yellow-800 disabled:bg-gray-300 active:bg-yellow-900 text-white font-semibold text-center rounded-full outline-none transition duration-100 mx-20 py-3"
              :disabled="ObserverProps.invalid || !ObserverProps.validated || !isSelected"
              @click="register"
            >
              登録
            </button>
            <span class="page-font text-red-500 text-center">{{ errorMessage }}</span>
            <p class="page-font text-indigo-500 font-semibold mb-1">※推しは4人まで登録できます。</p>
          </div>
        </form>
      </ValidationObserver>
      <router-link :to="'/mypage/'+authUser.uuid" class="nav-link">
        <div class="relative inline-flex items-center justify-center mt-12 w-30 p-2 overflow-hidden font-medium transition duration-300 ease-out border-2 border-purple-500 rounded-full shadow-md group">
          <span class="absolute inset-0 flex items-center justify-center w-full h-full text-white duration-300 -translate-x-full bg-purple-500 group-hover:translate-x-0 ease">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
              <path stroke-linecap="round" stroke-linejoin="round" d="M11 19l-7-7 7-7m8 14l-7-7 7-7" />
            </svg>
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14 5l7 7m0 0l-7 7m7-7H3" />
          </span>
          <span class="page-font absolute flex items-center justify-center text-purple-500 transition-all duration-300 transform group-hover:translate-x-full ease">マイページへ</span>
          <span class="page-font relative invisible">マイページへ</span>
        </div>
      </router-link>
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
import { mapGetters } from "vuex"
import ChoiceCharactersModal from './components/ChoiceCharactersModal'
import axios from "../../plugins/axios";
export default {
  name: "MypageNew",
  components: {
    ChoiceCharactersModal
  },
  data() {
    return {
      user: {
        uuid: ""
      },
      isVisibleChoiceCharactersModal: false,
      isSelected: false,
      genres: [],
      genre: {
      },
      selectedGenre: '',
      characters: [],
      character: {
      },
      selectedCharacters: [],
      selectedCharacterNames:[],
      errorMessage: "",
    }
  },
  created() {
    this.fetchGenres();
    this.user = Object.assign({}, this.authUser)
  },
  computed: {
    ...mapGetters("users", ["authUser"]),
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
      this.isSelected = true
      this.handleCloseChoiceCharactersModal();
    },
    fetchGenres() {
      this.$axios.get("genres")
        .then(res => {
          this.genres = res.data
        })
        .catch(err => console.log(err.status));
    },
    fetchCharacters(selectedGenre) {
      this.$axios.get("characters", {
        params:{ id:selectedGenre }
      })
        .then(res => {
          this.characters = res.data
        })
        .catch(err => console.log(err.status));
    },
    async register() {
      await this.fetchGenres()
      const params = {
        genre_id: this.selectedGenre,
        character_ids: this.selectedCharacters,
      }
      this.$axios.post("mypage", params)
      .then(res => {
        this.$store.dispatch("setFlash", {
          type: "success",
          message: "ジャンルと推しを登録しました。",
        })
        this.$router.push('/mypage/'+this.user.uuid);
      })
      .catch((error) => {
        console.log(error);
        this.errorMessage = error.response.data.errors.detail;
        this.$store.dispatch("setFlash", {
          type: "error",
          message: "ジャンルと推しを登録できませんでした。",
        })
      })
    },
  }
}
</script>

<style scoped>

</style>
