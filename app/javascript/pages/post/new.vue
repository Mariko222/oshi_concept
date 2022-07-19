<template>
  <div>
    <MypageHeader v-if="authUser" class="mb-auto" />
    <div class="container mx-auto">
      <div class="bg-purple-100 py-6 sm:py-8 lg:py-12">
        <div class="max-w-screen-2xl px-4 md:px-8 mx-auto">
          <h2 class="text-gray-800 text-2xl lg:text-3xl page-font text-center mb-4 md:mb-8">概念を追加</h2>
          <ValidationObserver v-slot="ObserverProps">
            <form class="bg-white max-w-lg border rounded-lg mx-auto">
              <div class="flex flex-col gap-4 p-4 md:p-8">
                <ValidationProvider name="ジャンル" rules="required" :skip-if-empty="false">
                  <div slot-scope="ProviderProps">
                    <label for="genre_name" class="page-font inline-block text-gray-800 text-sm sm:text-base mb-2">ジャンル：</label>
                    <select id="genre_id" name="genre" v-model="post.mygenre_id" class="page-font input-form-basic-block" >
                      <option disabled value="">ジャンルを選択</option>
                      <option v-for="mygenre in mygenres" :value="mygenre.id">{{ mygenre.name }}</option>
                    </select>
                    <p class="text-red-500">{{
                      ProviderProps.errors[0]
                    }}</p>
                  </div>
                </ValidationProvider>

                <ValidationProvider name="カテゴリ" rules="required" :skip-if-empty="false">
                  <div slot-scope="ProviderProps">
                    <label for="category" class="page-font inline-block text-gray-800 text-sm sm:text-base mb-2">カテゴリ：</label>
                    <select id="category" name="category" v-model="post.category" class="page-font input-form-basic-block">
                      <option disabled value="">カテゴリを選択</option>
                      <option value="fashion">
                        ファッション
                      </option>
                      <option value="item">
                        雑貨
                      </option>
                      <option value="place">
                        場所（お店や建物）
                      </option>
                    </select>
                    <p class="text-red-500">{{
                      ProviderProps.errors[0]
                    }}</p>
                  </div>
                </ValidationProvider>

                <ValidationProvider name="埋め込みタイプ" rules="required" :skip-if-empty="false">
                  <div slot-scope="ProviderProps">
                    <label for="type" class="page-font inline-block text-gray-800 text-sm sm:text-base mb-2">埋め込みタイプ：</label>
                    <select id="type" name="type" v-model="post.type" class="page-font input-form-basic-block">
                      <option disabled value="">埋め込みタイプを選択</option>
                      <option value="twitter">
                        Twitter
                      </option>
                      <option value="webpage">
                        WEBページ
                      </option>
                    </select>
                    <p class="text-red-500">{{
                      ProviderProps.errors[0]
                    }}</p>
                  </div>
                </ValidationProvider>

                <ValidationProvider name="URL" rules="required|url|max:300">
                  <div slot-scope="ProviderProps">
                    <label for="url" class="page-font inline-block text-gray-800 text-sm sm:text-base mb-2">URL:</label>
                    <input id="url" type="text" v-model="post.url" class="w-full bg-gray-50 text-gray-800 border focus:ring ring-indigo-300 rounded outline-none transition duration-100 px-3 py-2" />
                    <p class="text-red-500">{{
                      ProviderProps.errors[0]
                    }}</p>
                  </div>
                </ValidationProvider>

                <button
                  type="button"
                  class="page-font bg-gray-800 hover:bg-gray-700 disabled:bg-gray-400 active:bg-gray-600 text-white font-semibold text-center rounded-lg outline-none transition duration-100 py-3 mx-20"
                  :disabled="ObserverProps.invalid || !ObserverProps.validated"
                  @click="handleCreatePost"
                >
                  登録
                </button>
                <span class="text-red-500 text-center">{{ errorMessage }}</span>
              </div>
            </form>
          </ValidationObserver>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import MypageHeader from "../../components/MypageHeader"
import { mapGetters } from "vuex"
import axios from "../../plugins/axios";
export default {
  name: "PostNew",
  components: {
    MypageHeader
  },
  data() {
    return {
      post: {
        category: '',
        type: '',
        url: '',
        mygenre_id: ''
      },
      mygenres: [],
      errorMessage: ""
    }
  },
  created() {
    this.fetchMygenres();
  },
  computed: {
    ...mapGetters("users", ["authUser"])
  },
  methods: {
    fetchMygenres() {
      this.$axios.get("mygenres")
        .then(res => {
          this.mygenres = res.data
        })
        .catch(err => console.log(err.status));
    },
    handleCreatePost() {
      this.$axios.post("posts", this.post)
      .then(res => {
        this.$store.dispatch("setFlash", {
          type: "success",
          message: "概念投稿しました。",
        })
        this.$router.push({ name: 'MypageIndex' });
      })
      .catch((error) => {
        console.log(error);
        this.errorMessage = error.response.data.errors.detail;
        this.$store.dispatch("setFlash", {
          type: "error",
          message: "概念投稿できませんでした。",
        })
      })
    }
  },
}
</script>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Yusei+Magic&display=swap');
.page-font {
  font-family: 'Yusei Magic', sans-serif;
}
</style>
