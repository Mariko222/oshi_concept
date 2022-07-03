<template>
  <div class="bg-white py-6 sm:py-8 lg:py-12">
    <div class="max-w-screen-2xl px-4 md:px-8 mx-auto">
      <h2 class="text-gray-800 text-2xl lg:text-3xl font-bold text-center mb-4 md:mb-8">ジャンルを追加</h2>

      <form class="max-w-lg border rounded-lg mx-auto">
        <div class="flex flex-col gap-4 p-4 md:p-8">
          <div>
            <label for="genre_name" class="inline-block text-gray-800 text-sm sm:text-base mb-2">ジャンル：</label>
            <select id="genre_id" name="genre" v-model="selectedGenre" class="input-form-basic-block" @change="fetchCharacters(selectedGenre)" >
              <option disabled value="">ジャンルを選択</option>
              <option v-for="genre in genres" :value="genre.id">{{ genre.name }}</option>
            </select>
          </div>
          <div>
            <label for="character.name" class="inline-block text-gray-800 text-sm sm:text-base mb-2">推し（複数選択可）：</label>
            <span>{{ selectedCharacterNames }}</span>
            <button
            type="button"
            @click="handleOpenChoiceCharactersModal"
            class="block bg-indigo-800 hover:bg-indigo-700 active:bg-indigo-600 focus-visible:ring ring-indigo-300 text-white text-sm md:text-base  text-center rounded-lg outline-none transition duration-100 px-1 py-1"
            >
              推しを選択
            </button>
          </div>

          <button
            type="button"
            class="block bg-gray-800 hover:bg-gray-700 active:bg-gray-600 focus-visible:ring ring-gray-300 text-white text-sm md:text-base font-semibold text-center rounded-lg outline-none transition duration-100 px-8 py-3"
            @click="register"
          >
            登録
          </button>
          <div class="flex justify-center items-center relative">
            <span class="h-px bg-gray-300 absolute inset-x-0"></span>
          </div>
        </div>
      </form>
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
      genres: [],
      genre: {
      },
      selectedGenre: '',
      characters: [],
      character: {
      },
      selectedCharacters: [],
      selectedCharacterNames:[]
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
      try {
        await this.fetchGenres()
        const params = {
          genre_id: this.selectedGenre,
          character_ids: this.selectedCharacters,
        }
        this.$axios.post("mygenres", params)
        this.$router.push({ name: 'MypageIndex' });
      } catch (err) {
        console.log(err);
      }
    },
  }
}
</script>
