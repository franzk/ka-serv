<template>
  <header class="app-header">
    <h2>KA Serv !!</h2>
    <nav>
      <ul>
        <li><router-link to="/">Home</router-link></li>
        <li><router-link to="/me">Me</router-link></li>
        <li><button @click="logout">Logout</button></li>
      </ul>
    </nav>
  </header>
</template>

<script setup lang="ts">
import { useAuthStore } from '@/store/authStore'

const authStore = useAuthStore()

const logout = () => {
  authStore.logout()
}
</script>

<style scoped lang="scss">
.app-header {
  background-color: #333;
  padding: 1em;
  color: white;
  border-bottom: 1px solid white;
  width: 100%;
}

nav ul {
  list-style: none;
  display: flex;
  margin: 0;
}

nav ul li {
  flex: 1;
}

nav ul li a {
  color: white;
  text-decoration: none;
}

button {
  // padding: 10px 20px;
  font-size: 1em;
  color: #fff;
  background-color: #444;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  transition: background-color 0.3s;
}

button:hover {
  background-color: #666;
}
</style>
