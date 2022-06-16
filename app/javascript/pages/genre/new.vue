<template>
  <div class="bg-white py-6 sm:py-8 lg:py-12">
    <div class="max-w-screen-2xl px-4 md:px-8 mx-auto">
      <h2 class="text-gray-800 text-2xl lg:text-3xl font-bold text-center mb-4 md:mb-8">ジャンルを追加</h2>

      <form class="max-w-lg border rounded-lg mx-auto">
        <div class="flex flex-col gap-4 p-4 md:p-8">

          <div>
            <label for="genre_name" class="inline-block text-gray-800 text-sm sm:text-base mb-2">ジャンル：</label>
            <select id="genre_name" v-model="genre.name" class="input-form-basic-block">
              <option disabled value="">ジャンルを選択</option>
              <option>A</option>
              <option>B</option>
              <option>C</option>
            </select>
            <span>{{ genre.name }}</span>
          </div>

          <div>
            <label for="character.name" class="inline-block text-gray-800 text-sm sm:text-base mb-2">推し（複数選択可）：</label>
            <button
            type="button"
            @click="handleOpenChoiceCharactersModal"
            class="block bg-gray-800 hover:bg-gray-700 active:bg-gray-600 focus-visible:ring ring-gray-300 text-white text-sm md:text-base font-semibold text-center rounded-lg outline-none transition duration-100 px-8 py-3"
            >
              推しを選択
            </button>
            <span>{{ selectedPokeLists }}</span>
          </div>

          <button
            type="button"
            class="block bg-gray-800 hover:bg-gray-700 active:bg-gray-600 focus-visible:ring ring-gray-300 text-white text-sm md:text-base font-semibold text-center rounded-lg outline-none transition duration-100 px-8 py-3"
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
    />
  </div>
</template>

<script>
import ChoiceCharactersModal from './components/ChoiceCharactersModal'
export default {
  name: "GenreNew",
  components: {
    ChoiceCharactersModal
  },
  data() {
    return {
      isVisibleChoiceCharactersModal: false,
      genre: {
        genre_name: ""
      },
      character: {
        name: ""
      },
      selectedPokeLists: ""
    };
  },
  methods: {
    handleOpenChoiceCharactersModal() {
      this.isVisibleChoiceCharactersModal = true;
    },
    handleCloseChoiceCharactersModal() {
      this.isVisibleChoiceCharactersModal = false;
    },
    displayCharacters(selectedPokes){
      this.selectedPokeLists = selectedPokes
      this.handleCloseChoiceCharactersModal();
    }
  }
}
</script>
