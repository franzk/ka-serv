<template>
  <div>{{ something }}</div>
</template>

<script setup lang="ts">
import api from '@/config/axios'
import { ref } from 'vue'

const something = ref('Loading...')

api
  .get('/something')
  .then((response) => (something.value = response.data))
  .catch((error) => (something.value = 'Error fetching data:' + error))
</script>

<style scoped lang="scss">
div {
  flex: 1;
  justify-content: center;
  overflow-wrap: break-word;
}
</style>
