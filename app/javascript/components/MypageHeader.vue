<template>
  <div class="w-full h-52 bg-yellow-900 sticky top-20 z-10">
    <hr />
    <div class="max-w-auto h-auto p-4 pb-1">
      <div class="grid grid-cols-3">
        <div class="icon sm:-pt-6 lg:-mt-12 pb-5 flex flex-col justify-center items-center -ml-8">
          <div v-if="!user.icon_url">
            <img alt="icon" class="icon-image lg:mt-12 ring-white ring-2 rounded-full" src="../../../public/img/default_icon.jpg">
          </div>
          <div v-else>
            <img :src="user.icon_url" class="rounded-full icon-image ring-white ring-2 lg:mt-12"/>
          </div>
          <router-link v-if="loginUser" :to="{ name: 'MypageEdit' }" class="nav-link">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-white mt-1" viewBox="0 0 20 20" fill="currentColor">
              <path d="M17.414 2.586a2 2 0 00-2.828 0L7 10.172V13h2.828l7.586-7.586a2 2 0 000-2.828z" />
              <path fill-rule="evenodd" d="M2 6a2 2 0 012-2h4a1 1 0 010 2H4v10h10v-4a1 1 0 112 0v4a2 2 0 01-2 2H4a2 2 0 01-2-2V6z" clip-rule="evenodd" />
            </svg>
          </router-link>
          <ul class="justify-center items-center md:flex">
            <li>
              <ShareNetwork
                :url="'https://www.oshi-concept.com/mypage/'+ user.uuid"
                :title="user.name + 'の推し概念集めてみた【' + user.mypage_name + '】を公開'"
                description="推しの概念を集めたマイページを公開"
                network="twitter"
                hashtags="推し概念集めてみた"
              >
                <div>
                  <button
                    class="page-font text-xs flex justify-center bg-twitter hover:bg-sky-400 active:bg-sky-500 text-white font-semibold text-center border rounded-full transition duration-100 gap-2 mt-3 px-2 py-2"
                  >
                    <svg class="w-5 h-5 shrink-0" width="24" height="24" viewBox="328 355 335 276" fill="none" xmlns="http://www.w3.org/2000/svg">
                      <path d="
                        M 630, 425
                        A 195, 195 0 0 1 331, 600
                        A 142, 142 0 0 0 428, 570
                        A  70,  70 0 0 1 370, 523
                        A  70,  70 0 0 0 401, 521
                        A  70,  70 0 0 1 344, 455
                        A  70,  70 0 0 0 372, 460
                        A  70,  70 0 0 1 354, 370
                        A 195, 195 0 0 0 495, 442
                        A  67,  67 0 0 1 611, 380
                        A 117, 117 0 0 0 654, 363
                        A  65,  65 0 0 1 623, 401
                        A 117, 117 0 0 0 662, 390
                        A  65,  65 0 0 1 630, 425
                        Z"
                        fill="white" />
                    </svg>
                    共有する
                  </button>
                </div>
              </ShareNetwork>
            </li>
          </ul>
        </div>
        <div class="flex flex-col my-auto -ml-4 pr-2 items-center">
          <p class="page-font text-xs lg:text-base text-white mb-3 -mt-6">選択したジャンル:</p>
          <p v-if="mygenre" class="page-font text-bold text-sm lg:text-xl text-white">{{genre}}</p>
          <div class="flex">
            <router-link v-if="loginUser" :to="{ name: 'MypageNew' }" class="nav-link mt-6">
              <button class="page-font bg-indigo-500 text-white active:bg-indigo-600 uppercase text-xs lg:text-base px-1 py-1 rounded shadow hover:shadow-lg outline ease-linear transition-all duration-150" type="button">
                ジャンルを追加
              </button>
            </router-link>
          </div>
          <div v-if="showModal" class="overflow-x-hidden overflow-y-auto fixed inset-0 z-50 outline-none focus:outline-none justify-center items-center flex">
            <div class="relative w-auto my-6 mx-auto max-w-sm">
              <!--content-->
              <div class="border-0 rounded-lg shadow-lg relative flex flex-col w-full bg-purple-100 outline-none focus:outline-none">
                <!--header-->
                <div
                  class="modal-header flex flex-shrink-0 items-center p-2 justify-between border-b border-gray-200 rounded-t-md bg-gray-700"
                >
                  <p class="page-font text-white">
                    {{ user.name }}</span>のジャンルリスト:
                  </p>
                  <button
                    type="button"
                    class="btn-close box-content my-auto p-1 text-white hover:text-white active:text-white border-none rounded-none opacity-50 focus:shadow-none focus:outline-none focus:opacity-100 hover:opacity-75 hover:no-underline md:text-4xl text-lg"
                    @click="toggleModal"
                  >
                    ×
                  </button>
                </div>
                <!--body-->
                <div class="relative p-6 flex-auto">
                  <div class="flex flex-col justify-between items-center">
                    <p class="page-font text-xs lg:text-xl mr-3 -mt-1" v-if="mygenres.length === 0">追加済みのジャンルがありません。</p>
                    <div class="w-full my-1" v-for="(mygenre, index) in mygenres" :key="mygenre.id">
                      <button
                        class="page-font text-white text-sm lg:text-base bg-purple-600 hover:bg-purple-900 border rounded-full p-2"
                        @click="fetchBoth(mygenre)"
                        v-bind:class="{'active': isActive === index}" v-on:click="isSelect(index)"
                      >{{ mygenre.genre.name }}</button>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div v-if="showModal" class="opacity-25 fixed inset-0 z-40 bg-black"></div>
        </div>
        <div class="ring-white ring-1 h-max -mr-3 lg:mr-3 px-2 py-3 rounded-lg">
          <div class="flex justify-between">
            <p class="page-font mb-1 text-xs lg:text-base text-white"><span class="page-font">{{ user.name }}</span>の推し：</p>
            <button class="page-font bg-purple-500 text-white active:bg-purple-600 uppercase text-xs lg:text-base px-1 py-1 rounded shadow hover:shadow-lg outline ease-linear transition-all duration-150" type="button" v-on:click="toggleModal()">
              ジャンルを選択
            </button>
          </div>
          <hr class="my-2" />
          <div class="flex flex-col justify-between">
            <p class="text-center page-font text-xs lg:text-base text-white" v-if="mygenreCharacters.length === 0">ジャンルを選択してください。</p>
            <ul v-for="mygenreCharacter in mygenreCharacters" class="rounded">
              <li class="page-font text-xs lg:text-base text-white">{{ mygenreCharacter.character.name }}</li>
            </ul>
            <router-link v-if="loginUser" :to="{ name: 'MygenresEdit' }" class="nav-link flex justify-end">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-white" viewBox="0 0 20 20" fill="currentColor">
                <path d="M17.414 2.586a2 2 0 00-2.828 0L7 10.172V13h2.828l7.586-7.586a2 2 0 000-2.828z" />
                <path fill-rule="evenodd" d="M2 6a2 2 0 012-2h4a1 1 0 010 2H4v10h10v-4a1 1 0 112 0v4a2 2 0 01-2 2H4a2 2 0 01-2-2V6z" clip-rule="evenodd" />
              </svg>
            </router-link>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapState, mapGetters } from "vuex"
import axios from "../plugins/axios";
import { createNamespacedHelpers } from 'vuex';
const { mapMutations } = createNamespacedHelpers('mygenre')
export default {
  name: "MypageHeader",
  data() {
    return {
      mygenres: [],
      genre: "",
      mygenreCharacters:[],
      user: "",
      isActive: '',
      loginUser: "",
      showModal: false,
    }
  },
  computed: {
    ...mapGetters("users", ["authUser"]),
    ...mapGetters("mygenre", ["mygenre"]),
    ...mapState("mygenre", ["mygenre"])
  },
  created() {
    this.fetchMygenres();
    this.displayCharacter();
    this.fetchBoth(this.mygenre)
    this.fetchUser();
    this.isSelect();
  },
  methods: {
    ...mapMutations([
      "loadMygenre"
    ]),
    fetchMygenres() {
      this.$axios.get("mygenres", {
        params: this.$route.params
      })
        .then(res => {
          this.mygenres = res.data
        })
        .catch(err => console.log(err.status));
    },
    fetchBoth: function (mygenre) {
      this.loadMygenre(mygenre);
      this.displayCharacter(mygenre);
      this.handleMygenrePosts(mygenre);
    },
    displayCharacter(mygenre) {
      this.$axios.get("mypage", {
        params: this.$route.params
      })
      .then(res => {
        this.mygenreFavoriteCharacters = res.data
        this.mygenreCharacters = this.mygenreFavoriteCharacters.filter(c =>{
          return c.mygenre['id'] === mygenre.id
        })
      })
      .catch(err => console.log(err.status));
    },
    handleMygenrePosts(mygenre) {
      this.$emit('mygenre-posts', this.mygenre)
    },
    isSelect: function (index) {
      this.isActive = index;
      this.genre = this.mygenre.genre.name
      this.showModal = false
    },
    fetchUser() {
      this.$axios.get("users", {
        params: this.$route.params
      })
      .then(res => {
        this.user = res.data
        if (this.user.uuid === this.authUser.uuid) {
          this.loginUser = this.user
        }
      })
      .catch(err => console.log(err.status));
    },
    toggleModal() {
      this.showModal = !this.showModal;
    }
  },
}
</script>

<style scoped>

</style>
