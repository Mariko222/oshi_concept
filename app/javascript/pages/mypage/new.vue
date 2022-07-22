<template>
  <div class="bg-purple-100 py-6 sm:py-8 lg:py-12">
    <div class="max-w-screen-2xl px-4 md:px-8 mx-auto">
      <h2 class="text-gray-800 text-2xl lg:text-3xl page-font text-center mb-4 md:mb-8">ジャンルを追加</h2>
      <ValidationObserver v-slot="ObserverProps">
        <form class="bg-white max-w-lg border rounded-lg mx-auto">
          <div class="flex flex-col gap-4 p-4 md:p-8">
            <ValidationProvider name="ジャンル" rules="required" :skip-if-empty="false">
              <div slot-scope="ProviderProps">
                <label for="genre_name" class="page-font inline-block text-gray-800 text-sm sm:text-base mb-2">ジャンル：</label>
                <select id="genre_id" name="genre" v-model="selectedGenre" class="page-font input-form-basic-block" @change="fetchCharacters(selectedGenre)" >
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
              class="page-font block bg-indigo-800 hover:bg-indigo-700 disabled:bg-indigo-400 active:bg-indigo-600 text-white text-center rounded-lg outline-none transition duration-100 px-3 py-2"
              >
                推しを選択
              </button>
            </div>

            <button
              type="button"
              class="page-font bg-gray-800 hover:bg-gray-700 disabled:bg-gray-400 active:bg-gray-600 text-white font-semibold text-center rounded-lg outline-none transition duration-100 mx-20 py-3"
              :disabled="ObserverProps.invalid || !ObserverProps.validated || !isSelected"
              @click="register"
            >
              登録
            </button>
            <span class="page-font text-red-500 text-center">{{ errorMessage }}</span>
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
import ChoiceCharactersModal from './components/ChoiceCharactersModal'
import axios from "../../plugins/axios";
export default {
  name: "MypageNew",
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
        this.$router.push({ name: 'MypageIndex' });
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
@import url('https://fonts.googleapis.com/css2?family=Yomogi&display=swap');
.page-font {
  font-family: 'Yomogi', cursive;
}
</style>
