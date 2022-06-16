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
          class="modal-header flex flex-shrink-0 items-center p-2 justify-between border-b border-gray-200 rounded-t-md bg-indigo-400"
        >
          <h5
            class="md:text-3xl text-xl font-medium leading-normal text-gray-800"
          >
            推しを選択
          </h5>
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
            <div v-for="(poke, i) in pokes" :key="i">
              <input
                :id="'poke' + i"
                type="checkbox"
                :value="poke"
                v-model="selectedPokes"
              >
              <label :for="'poke' + i">{{poke}}</label>
            </div>
          </section>
          <span>{{ selectedPokes }}</span>
        </div>
        <div
          class="modal-footer flex justify-between border-gray-200 bg-indigo-400"
        >
          <button
            type="button"
            class="bg-gray-800 hover:bg-gray-700 active:bg-gray-600 focus-visible:ring ring-gray-300 text-white text-center rounded-lg outline-none transition duration-100 px-4 py-2"
            @click="handleChoiceCharacters"
          >
            追加
          </button>
          <button
            type="button"
            class="bg-indigo-800 hover:bg-indigo-700 active:bg-indigo-600 focus-visible:ring ring-indigo-300 text-white text-center rounded-lg outline-none transition duration-100 px-4 py-2"
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
      pokes: [
        'AAA', 'BBB', 'CCC', 'DDD', 'EEE', 'FFF', 'GGG'
      ],
      selectedPokes: []
    }
  },
  methods: {
    handleCloseModal() {
      this.$emit('close-modal')
    },
    handleChoiceCharacters() {
      this.$emit('choice-characters', this.selectedPokes)
    }
  }
}
</script>

<style scoped>
  .modal {
  display: block;
}
</style>
