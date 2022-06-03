<template>
  <div>
    <body class="flex flex-col min-h-screen">
      <TheHeader class="mb-auto" />
        <router-view />
      <TheFooter class="mt-auto" />
    </body>
  </div>
</template>

<script>
import TheHeader from "components/TheHeader"
import TheFooter from "components/TheFooter"
export default {
  components: {
    TheHeader,
    TheFooter
  }
}
</script>
