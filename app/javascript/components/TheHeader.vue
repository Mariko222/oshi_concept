<template>
  <div class="navbar bg-neutral mx-auto flex justify-between items-center text-neutral-content sticky top-0">
    <div class="navbar-start">
      <p>推し概念集めてみた</p>
    </div>
    <div class="navbar-end">
      <div class="flex-none">
        <div class="dropdown dropdown-end">
          <button class="btn btn-square btn-ghost">
            <svg class="h-6 w-6 fill-current" viewBox="0 0 24 24">
              <path d="M24 6h-24v-4h24v4zm0 4h-24v4h24v-4zm0 8h-24v4h24v-4z"/>
            </svg>
          </button>
          <ul tabindex="0" class="dropdown-content menu p-2 drop-shadow-md bg-base-200 box w-52 text-neutral">
            <template v-if="!authUser">
              <li><router-link :to="{ name: 'LoginIndex' }">ログイン</router-link></li>
              <li><router-link :to="{ name: 'RegisterIndex' }">新規登録</router-link></li>
              <li><a>ゲストログイン</a></li>
            </template>
            <template v-else>
              <li><a>マイページ編集</a></li>
              <li><a>概念を追加</a></li>
              <li><a>ログアウト</a></li>
            </template>
          </ul>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters, mapActions } from "vuex"

export default {
  name: "TheHeader",
  computed: {
    ...mapGetters("users", ["authUser"])
  }
}
</script>
