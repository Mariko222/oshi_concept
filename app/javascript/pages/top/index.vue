<template>
  <div class="container mx-auto">
    <div class="bg-purple-100 pb-6 sm:pb-8 lg:pb-12">
      <div class="max-w-screen-2xl px-4 md:px-8 mx-auto">
        <section class="flex flex-col items-center">
          <div class="max-w-xl flex flex-col items-center text-center pt-8 lg:pt-32 pb-0 sm:pb-16 lg:pb-32">
            <h1 class="page-font text-black-800 text-4xl sm:text-5xl md:text-6xl font-bold mb-8 md:mb-12">推し概念集めてみた</h1>
            <p class="page-font text-purple-500 text-xl mb-4 md:mb-6">いいなと思う情報を見つけて保存しておいても、いざ欲しい時に探すのに苦労した経験はありませんか？</p>
            <div class="bg-gray-100 rounded-lg shadow-lg grid md:grid-cols-2 gap-8 lg:gap-12 mt-10 mb-10">
              <div>
                <div class="h-80 md:h-auto overflow-hidden rounded-lg">
                  <img img src="../../../../public/img/mypage.jpg" loading="lazy" alt="mypage-top" class="pl-2 pr-2 my-10" />
                </div>
              </div>
              <div class="text-center md:pt-10 pr-8">
                <h2 class="page-font text-gray-800 mb-4">“推し概念集めてみた”を使うと、</h2>
                <p class="page-font text-gray-800 mb-4 ml-3">ジャンルと推しを選んで概念ツイートやサイトのURLを保存して、自分が”概念”と思ったものをひたすら集めてオリジナルのマイページを作成できる</p>
              </div>
            </div>
            <div class="text-gray-500 xl:text-lg leading-relaxed mb-8 md:mb-12">
              <p class="page-font text-xl mb-8">このピアス推しっぽい</p>
              <p class="page-font text-xl mb-8">このカフェ推しのイメージ</p>
              <p class="page-font text-xl mb-8">このポーチの色味推しじゃん！</p>
              <p class="page-font text-xl mb-8">などなど自分が ”概念”と感じたものはどんどん投稿して自分だけの推し概念集めてみよう</p>
            </div>
            <svg xmlns="http://www.w3.org/2000/svg" class="h-20 w-10 text-purple-500" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
              <path stroke-linecap="round" stroke-linejoin="round" d="M19 13l-7 7-7-7m14-8l-7 7-7-7" />
            </svg>
          </div>
        </section>

        <div class="mb-4 sm:mb-10">
          <div class="w-full flex flex-col sm:flex-row sm:justify-center gap-2.5">
            <router-link :to="{ name: 'LoginIndex' }" button class="page-font rounded-full text-white bg-purple-500 hover:bg-purple-400 active:bg-purple-600 btn btn-outline">ログイン</router-link>
            <router-link :to="{ name: 'RegisterIndex' }" button class="page-font rounded-full text-white bg-purple-500 hover:bg-purple-400 active:bg-purple-600 btn btn-outline">新規作成</router-link>
            <button class="page-font rounded-full text-white bg-purple-500 hover:bg-purple-400 active:bg-purple-600 btn btn-outline">ゲストログイン</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>

</style>
