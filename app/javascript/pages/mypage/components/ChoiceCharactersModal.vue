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
            class="btn-close box-content my-auto p-1 text-white hover:text-white active:text-white border-none rounded-none opacity-50 focus:shadow-none focus:outline-none focus:opacity-100 hover:text-black hover:opacity-75 hover:no-underline md:text-4xl text-lg"
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
          class="modal-footer flex justify-end mb-2"
        >
          <button
            type="button"
            class="page-font bg-purple-500 hover:bg-purple-600 disabled:bg-purple-400 active:bg-purple-400 focus-visible:ring ring-purple-300 text-white text-center rounded-full outline-none transition duration-100 px-4 py-2 mx-3"
            @click="handleChoiceCharacters"
            :disabled="!selectedCharacters"
          >
            追加
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

</style>
