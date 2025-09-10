<template>
  <div class="something-view">
    <SimpleCard class="something-card">
      <p>{{ something?.date }}</p>
      <p>{{ something?.message }}</p>
      <p v-if="error">{{ error }}</p>
    </SimpleCard>
  </div>
</template>

<script setup lang="ts">
import SimpleCard from '@/components/SimpleCard.vue'
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
.something-view {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: $spacing-xl;
}
.something-card {
  max-width: 400px;
  p {
    display: flex;
    justify-content: center;
  }
}
</style>
