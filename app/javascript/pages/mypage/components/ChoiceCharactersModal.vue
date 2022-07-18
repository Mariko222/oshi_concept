<template>
  <div
    class="fixed w-full h-full top-0 left-0 outline-none overflow-x-hidden overflow-y-auto rounded-md flex justify-center bg-black bg-opacity-50 z-1000"
    @click.self="handleCloseModal"
  >
    <div class="w-3/4 h-3/4 pointer-events-none rounded-md my-16">
      <div
        class="border-none shadow-lg relative flex flex-col w-full pointer-events-auto bg-white bg-clip-padding rounded-md outline-none text-current"
      >
        <div
          class="modal-header flex flex-shrink-0 items-center p-2 justify-between border-b border-gray-200 rounded-t-md bg-gray-700"
        >
          <p class="page-font text-white">
            推しを選択
          </p>
          <button
            type="button"
            class="btn-close box-content my-auto p-1 text-black border-none rounded-none opacity-50 focus:shadow-none focus:outline-none focus:opacity-100 hover:text-black hover:opacity-75 hover:no-underline md:text-4xl text-lg"
            @click="handleCloseModal"
          >
            ×
          </button>
        </div>
        <div class="modal-body relative p-4">
          <hr class="my-2" />
          <section>
            <div v-for="(character, i) in characters" :key="i">
              <input
                :id="'character' + i"
                type="checkbox"
                :value="character.id"
                name="mygenre[character_id]"
                v-model="selectedCharacters"
              >
              <label :for="'character' + i" class="page-font">{{character.name}}</label>
            </div>
          </section>
          <hr class="my-2" />
        </div>
        <div
          class="modal-footer flex justify-end border-gray-200 bg-gray-700"
        >
          <button
            type="button"
            class="page-font bg-red-500 hover:bg-red-600 disabled:bg-red-400 active:bg-red-400 focus-visible:ring ring-red-300 text-black-600 text-center rounded-lg outline-none transition duration-100 px-4 py-2 mx-3"
            @click="handleChoiceCharacters"
            :disabled="!selectedCharacters"
          >
            追加
          </button>
          <button
            type="button"
            class="page-font bg-indigo-800 hover:bg-indigo-700 active:bg-indigo-600 focus-visible:ring ring-indigo-300 text-white text-center rounded-lg outline-none transition duration-100 px-4 py-2 mx-3"
            @click="handleCloseModal"
          >
            閉じる
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'ChoiceCharactersModal',
  data() {
    return {
      character: {
      },
      selectedCharacters: []
    }
  },
  props: {
    characters: {
      type: Array,
      required: true
    }
  },
  computed: {
    selectedCharactersLists: function () {
      return this.selectedCharacters;
    }
  },
  methods: {
    handleCloseModal() {
      this.$emit('close-modal')
    },
    handleChoiceCharacters() {
      this.$emit('choice-characters', this.selectedCharactersLists)
    }
  }
}
</script>

<style scoped>
  .modal {
  display: block;
}
</style>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Yusei+Magic&display=swap');
.page-font {
  font-family: 'Yusei Magic', sans-serif;
}
</style>
