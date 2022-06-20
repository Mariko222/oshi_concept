<template>
  <div class="w-full lg:block bg-gray-50 border rounded-lg shadow-sm sticky top-20 z-10">
    <div class="max-w-auto gap-8 p-8">
      <div class="grid grid-cols-2">
        <div class="avatar pl-8">
          <div class="rounded-full bg-gray-500">
            <img src="" />
          </div>
        </div>
        <ul class="flex flex-col bg-gray-100 rounded-lg gap-4 p-4 md:p-8">
          <li class="font-semibold mb-1">ユーザーネーム</li>
          <li class="font-semibold mb-1">推しの名前：複数可</li>
        </ul>
      </div>
    </div>
    <div class="flex flex-col border-t border-b my-5"></div>
      <div class="max-w-full gap-4 p-4 mx-auto">
        <div class="justify-between grid grid-cols-2 gap-8">
          <div class="flex-row justify-start gap-2.5 ml-8">
            <router-link :to="{ name: 'MypageNew' }" button class="btn bg-indigo-800 text-white btn-outline mr-5">ジャンルを追加</router-link>
          </div>
        </div>
      </div>

  </div>
</template>
