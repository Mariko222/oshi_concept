<template>
  <div class="top-bg container mx-auto">
    <div class="pb-6 sm:pb-8 lg:pb-12">
      <div class="max-w-screen-2xl px-4 md:px-8 mx-auto">
        <section class="flex flex-col items-center">
          <div class="max-w-xl flex flex-col items-center text-center pt-8 lg:pt-32 pb-0 sm:pb-16 lg:pb-32">
            <p class="page-font text-black-800 lg:text-6xl text-3xl font-bold mb-8 md:mb-12">推し<span class="page-font text-indigo-500 lg:text-6xl text-3xl font-bold">概念</span>集めてみた</p>
            <p class="page-font text-purple-500 text-xl mb-4 md:mb-6">TwitterやWEBページでいいなと思う情報を見つけて保存しても、いざ欲しいとき他の情報に埋もれてしまって探すのに苦労した経験はありませんか？</p>
            <div class="bg-gray-100 rounded-lg shadow-lg grid  gap-8 lg:gap-12 mt-10 mb-6">
              <div class="h-100 md:h-auto overflow-hidden rounded-lg">
                <img img src="../../../../public/img/post_show.jpg" loading="lazy" alt="mypage-top" class="pl-2 pr-2 mt-5" />
              </div>
              <div class="text-center pb-12">
                <p class="page-font text-gray-800 mb-4">“推し概念集めてみた”を使うと、</p>
                <p class="page-font text-gray-800 ml-3">ジャンルごとに推しっぽいと思ったツイートやWEBページを保存して<br>自分が”概念”と感じたものを好きなだけ集めて<br>オリジナルのマイページを作成できます</p>
              </div>
            </div>
            <div class="bg-gray-100 rounded-lg shadow-lg grid  gap-8 lg:gap-12 mt-10 mb-6">
              <p class="page-font text-xl mt-5 text-purple-500">使い方は簡単！</p>
              <div class="h-100 md:h-auto overflow-hidden rounded-lg">
                <img img src="../../../../public/img/how_to_use.jpg" loading="lazy" alt="mypage-top" class="pl-2 pr-2 mt-5" />
              </div>
              <div class="text-center">
                <p class="page-font text-gray-800 mb-4">STEP1:マイページ名とアイコンを登録</p>
                <p class="page-font text-gray-800 mb-4 ml-3">STEP2:ジャンルと推しを登録</p>
                <p class="page-font text-gray-800 mb-4 ml-3">STEP3:推しっぽいものを見つけたらURLを投稿</p>
              </div>

            </div>
            <div class="text-purple-500 xl:text-lg leading-relaxed mb-8 md:mb-12">
              <p class="page-font text-xl mb-8">このピアス推しっぽい</p>
              <p class="page-font text-xl mb-8">このカフェ推しのイメージ</p>
              <p class="page-font text-xl mb-8">このポーチの色味推しじゃん！</p>
              <p class="page-font text-xl mb-8">などなど自分が ”概念”と感じたものはどんどん投稿して自分だけの推し概念集めてみよう</p>
            </div>
            <svg xmlns="http://www.w3.org/2000/svg" class="animate-bounce h-20 w-10 text-indigo-500" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
              <path stroke-linecap="round" stroke-linejoin="round" d="M19 13l-7 7-7-7m14-8l-7 7-7-7" />
            </svg>
          </div>
        </section>

        <div class="mb-4 sm:mb-10">
          <div v-if="!authUser" class="w-full flex flex-col sm:flex-row sm:justify-center gap-2.5">
            <router-link :to="{ name: 'LoginIndex' }" button class="page-font rounded-full text-white bg-purple-500 hover:bg-purple-400 active:bg-purple-600 btn btn-outline">ログイン</router-link>
            <router-link :to="{ name: 'RegisterIndex' }" button class="page-font rounded-full text-white bg-purple-500 hover:bg-purple-400 active:bg-purple-600 btn btn-outline">新規作成</router-link>
            <button class="page-font rounded-full text-white bg-purple-500 hover:bg-purple-400 active:bg-purple-600 btn btn-outline">ゲストログイン</button>
          </div>
          <div v-else class="w-full flex flex-col sm:flex-row sm:justify-center gap-2.5">
            <router-link :to="{ name: 'PostIndex' }" button class="page-font rounded-full text-white bg-purple-500 hover:bg-purple-400 active:bg-purple-600 btn btn-outline">マイページへ</router-link>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters } from "vuex"

export default {
  name: "TopIndexr",
  computed: {
    ...mapGetters("users", ["authUser"])
  }
}
</script>

<style scoped>

</style>
