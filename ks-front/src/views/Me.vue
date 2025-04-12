<template>
  <div>{{ me }}</div>
</template>

<script setup lang="ts">
import api from '@/config/axios'
import { ref } from 'vue'

const me = ref('Loading...')

api
  .get('/me')
  .then((response) => (me.value = response.data))
  .catch((error) => (me.value = 'Error fetching data:' + error))
</script>

<style scoped lang="scss">
div {
  flex: 1;
  justify-content: center;
  overflow-wrap: break-word;
}
</style>
