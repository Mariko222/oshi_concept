<template>
  <footer class="footer flex justify-between items-center p-4 bg-yellow-900 text-neutral-content">
    <div class="page-font text-xs lg:text-base">
      <p>© 2022. Oshi-Concept</p>
    </div>
    <div class="text-xs lg:text-base grid-flow-col gap-4 md:place-self-center md:justify-self-end lg:justify-self-end">
      <router-link :to="{ name: 'TheTerms' }" class="page-font text-xs lg:text-base">利用規約</router-link>
      <router-link :to="{ name: 'ThePolicy' }" class="page-font text-xs lg:text-base">プライバシーポリシー</router-link>
      <a class="page-font" href="#">お問合わせ</a>
    </div>
  </footer>
</template>

<style scoped>

</style>
