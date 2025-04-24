<template>
  <header class="app-header">
    <h2 @click="goHome">KA</h2>
    <div class="user-info">
      <span class="user-name"
        ><RouterLink to="/me">👤 {{ authStore.me?.name }}</RouterLink></span
      >
      <span class="logout-button">
        <button @click="logout">Logout</button>
      </span>
    </div>
  </header>
</template>

<script setup lang="ts">
import { useAuthStore } from '@/store/authStore'
import { useRouter } from 'vue-router'

const authStore = useAuthStore()

const logout = () => {
  authStore.logout()
}

const router = useRouter()
const goHome = () => {
  router.push('/')
}
</script>

<style scoped lang="scss">
.app-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  background-color: #1e1e2f;
  padding: 1rem 2rem;
  border-bottom: 1px solid #2a2a3b;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);
  color: #f1f1f1;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.app-header h2 {
  cursor: pointer;
  font-size: 1.4rem;
  color: #66d9ef;
  transition: color 0.2s ease;
}

.app-header h2:hover {
  color: #a6e3e9;
}

.user-info {
  display: flex;
  align-items: center;
  gap: 1rem;
  background: #2a2a3b;
  padding: 0.5rem 1rem;
  border-radius: 8px;
}

.user-name a {
  color: #dcdcdc;
  text-decoration: none;
  font-weight: 500;
  transition:
    color 0.2s ease,
    text-shadow 0.2s ease;
}

.user-name a:hover {
  color: #ffffff;
  text-shadow: 0 0 4px #66d9ef;
}

.logout-button button {
  background-color: #ff5c5c;
  color: #fff;
  border: none;
  padding: 0.4rem 0.8rem;
  border-radius: 6px;
  font-weight: bold;
  cursor: pointer;
  transition: background-color 0.2s ease;
}

.logout-button button:hover {
  background-color: #ff1e1e;
}
</style>
