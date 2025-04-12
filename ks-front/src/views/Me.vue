<template>
  <div>{{ me }}</div>
</template>

<script setup lang="ts">
import { useAuthStore } from '@/store/authStore'
import { ref } from 'vue'

const authStore = useAuthStore()

const me = ref(null)

console.log(import.meta.env.VITE_API_URL, authStore.token)

fetch(import.meta.env.VITE_API_URL + '/me', {
  method: 'GET',
  headers: {
    Authorization: 'Bearer ' + authStore.token,
  },
})
  .then((response) => response.json().then((data) => (me.value = data)))
  .catch((error) => {
    me.value = 'Error fetching data:' + error
    console.error('Error:', error)
  })
</script>

<style scoped lang="scss">
p {
  flex: 1;
  display: flex;
  justify-content: center;
}
</style>
