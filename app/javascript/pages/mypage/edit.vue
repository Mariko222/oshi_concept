<template>
  <div class="bg-white py-6 sm:py-8 lg:py-12">
    <div class="max-w-screen-2xl px-4 md:px-8 mx-auto">
      <h2 class="text-gray-800 text-2xl lg:text-3xl font-bold text-center mb-4 md:mb-8">マイページ編集</h2>

      <form class="max-w-lg border rounded-lg mx-auto">
        <div class="flex flex-col gap-4 p-4 md:p-8">
          <div>
            <label for="name" class="inline-block text-gray-800 text-sm sm:text-base mb-2">ユーザーネーム：</label>
            <input id="name" type="text" v-model="user.name" class="w-full bg-gray-50 text-gray-800 border focus:ring ring-indigo-300 rounded outline-none transition duration-100 px-3 py-2" />
          </div>
          <div>
            <label for="mygenre_name" class="inline-block text-gray-800 text-sm sm:text-base mb-2">ジャンル：</label>
            <select id="mygenre_id" name="mygenre" v-model="selectedGenre" class="input-form-basic-block" @change="fetchCharacters(selectedGenre)" >
              <option disabled value="">ジャンルを選択</option>
              <option v-for="mygenreList in mygenreLists" :value="mygenreList.id">{{ mygenreList.mygenre.genre.name }}</option>
            </select>
          </div>
          <div>
            <label for="character.name" class="inline-block text-gray-800 text-sm sm:text-base mb-2">推し（複数選択可）：</label>
            <template v-if="!isEdit && isSelected">
              <div v-for="mygenreFavoriteCharacter in mygenreFavoriteCharacters">
                <p>{{ mygenreFavoriteCharacter.character.name }}</p>
              </div>
            </template>
            <template v-else>
              <span>{{ selectedCharacterNames }}</span>
            </template>
            <button
            type="button"
            @click="handleOpenChoiceCharactersModal"
            class="block bg-indigo-800 hover:bg-indigo-700 active:bg-indigo-600 focus-visible:ring ring-indigo-300 text-white text-sm md:text-base  text-center rounded-lg outline-none transition duration-100 px-1 py-1"
            >
              推しを選択
            </button>
          </div>
          <div>
            <label for="mypage_name" class="inline-block text-gray-800 text-sm sm:text-base mb-2">マイページ名：</label>
            <input id="mypage_name" type="text" v-model="user.mypage_name" class="w-full bg-gray-50 text-gray-800 border focus:ring ring-indigo-300 rounded outline-none transition duration-100 px-3 py-2" />
          </div>
          <div>
            <label
              for="avatar"
              class="d-block"
            >アイコン：</label>
            <img
              :src="user.avatar_url"
              class="my-3"
              width="150px"
            >
            <input
              id="avatar"
              type="file"
              class="form-control-file"
              @change="handleChange"
            >
          </div>
          <div>
            <label
              for="avatar"
              class="d-block"
            >マイページの背景画像：</label>
            <img
              :src="user.avatar_url"
              class="my-3"
              width="150px"
            >
            <input
              id="avatar"
              type="file"
              class="form-control-file"
              @change="handleChange"
            >
            <div class="flex justify-center items-center relative">
              <span class="h-px bg-gray-300 absolute inset-x-0"></span>
            </div>
          </div>
          <button
            type="button"
            class="block bg-gray-800 hover:bg-gray-700 active:bg-gray-600 focus-visible:ring ring-gray-300 text-white text-sm md:text-base font-semibold text-center rounded-lg outline-none transition duration-100 px-8 py-3"
            @click="update"
          >
            登録
          </button>
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
import { mapGetters, mapActions } from "vuex"
export default {
  name: "MypageEdit",
  components: {
    ChoiceCharactersModal
  },
  data() {
    return {
      isVisibleChoiceCharactersModal: false,
      isEdit: false,
      isSelected: false,
      myGenres: [],
      mygenreFavoriteCharacters: [],
      mygenreLists:[],
      mygenreList: "",
      selectedGenre: '',
      characters: [],
      character: {
      },
      selectedCharacters: [],
      selectedCharacterNames: [],
      user: {
        name: "",
        mypage_name: "",
        icon_url: "",
        background_image_url: ""
      },
      uploadIcon: "",
      uploadBackgroundImage: ""
    }
  },
  computed: {
    ...mapGetters("users", ["authUser"]),
  },
  created() {
    this.fetchFavoriteCharacters();
    this.user = Object.assign({}, this.authUser)
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
      this.isEdit = true;
    },

    fetchCharacters(selectedGenre) {
      this.$axios.get("characters", {
        params:{ id:selectedGenre }
      })
        .then(res => {
          this.characters = res.data;
          this.isSelected = true;
        })
        .catch(err => console.log(err.status));
    },
    ...mapActions("users", ["updateUser"]),
    async handleChange(event) {
      const { valid } = await this.$refs.provider.validate(event)
      if (valid) this.uploadAvatar = event.target.files[0]
    },
    update() {
      const formData = new FormData()
      formData.append("user[name]", this.user.name)
      formData.append("user[mypage_name]", this.user.mypage_name)
      formData.append("mygenre[genre_id]", this.selectedGenre)
      formData.append("mygenreFavoriteCharacters[character_ids]", this.selectedCharacters)
      if (this.uploadIcon) formData.append("user[icon]", this.uploadIcon)
      if (this.uploadBackgroundImage) formData.append("user[background_image]", this.uploadBackgroundImage)

      try {
        this.updateUser(formData)
        this.$router.push({ name: "MypageIndex" })
      } catch (error) {
        console.log(error);
      }
    },
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
