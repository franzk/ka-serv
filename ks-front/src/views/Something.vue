<template>
  <div class="something">
    <p>{{ something?.date }}</p>
    <p>{{ something?.message }}</p>
    <p v-if="error">{{ error }}</p>
  </div>
</template>

<script setup lang="ts">
import api from '@/config/axios'
import type { Something } from '@/domain/Something'
import { ref } from 'vue'

const something = ref<Something>()
const error = ref<string>()

api
  .get('/something')
  .then((response) => (something.value = response.data))
  .catch((error) => (error.value = 'Error fetching data:' + error))
</script>

<style scoped lang="scss">
.something {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  overflow-wrap: break-word;
}
</style>
