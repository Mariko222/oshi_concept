<template>
  <div class="bg-white py-6 sm:py-8 lg:py-12">
    <div class="max-w-screen-2xl px-4 md:px-8 mx-auto">
      <h2 class="text-gray-800 text-2xl lg:text-3xl font-bold text-center mb-4 md:mb-8">推しを変更</h2>

      <form class="max-w-lg border rounded-lg mx-auto">
        <div class="flex flex-col gap-4 p-4 md:p-8">
          <div>
            <label for="genre_name" class="inline-block text-gray-800 text-sm sm:text-base mb-2">ジャンル：</label>
            <select id="genre_id" name="genre" v-model="selectedGenre" class="input-form-basic-block" @change="fetchCharacters(selectedGenre)" >
              <option disabled value="">ジャンルを選択</option>
              <option v-for="mygenre in mygenres" :value="mygenre.id">{{ mygenre.name }}</option>
            </select>
          </div>
          <div>
            <div v-if="isSelected">
              <p class="font-semibold mb-1">推し：</p>
              <ul v-for="mygenreFavoriteCharacter in mygenreFavoriteCharacters" :value="mygenreFavoriteCharacter.id" class="mx-auto flex justify-between bg-white border shadow-sm rounded p-2">
                <li>{{ mygenreFavoriteCharacter.character.name }}
                </li>
                <button type="button" @click="handleDeleteCharacter(mygenreFavoriteCharacter)">
                  <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-right" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z" />
                  </svg>
                </button>
              </ul>
            </div>
            <label for="character.name" class="inline-block text-gray-800 text-sm sm:text-base mb-2">推し（複数選択可）：</label>
            <span>{{ selectedCharacterNames }}</span>
            <button
            type="button"
            @click="handleOpenChoiceCharactersModal"
            class="block bg-indigo-800 hover:bg-indigo-700 active:bg-indigo-600 focus-visible:ring ring-indigo-300 text-white text-sm md:text-base  text-center rounded-lg outline-none transition duration-100 px-1 py-1"
            >
              推しを追加
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
      mygenreLists: []
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
    ...mapActions("users", ["updateCharacter"]),
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
      this.$axios.get("mygenres")
        .then(res => {
          this.mygenres = res.data
        })
        .catch(err => console.log(err.status));
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
    async handleDeleteCharacter(mygenreFavoriteCharacter) {
      try {
        await
        axios.delete(`mygenres/${mygenreFavoriteCharacter.id}`)
        this.$router.push({ name: 'MypageIndex' });
      } catch (err) {
        console.log(err);
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
        this.$router.push({ name: 'MypageIndex' });
      } catch (err) {
        console.log(err);
      }
    },
  }
}
</script>
