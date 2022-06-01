<template>
  <div>
    <body class="flex flex-col min-h-screen">
      <router-view />
      <TheFooter class="mt-auto" />
    </body>
  </div>
</template>

<script>
import TheFooter from "components/TheFooter"
export default {
  components: {
    TheFooter
  }
}
</script>
