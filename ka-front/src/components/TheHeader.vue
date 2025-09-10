<template>
  <header class="app-header">
    <h2 @click="goHome">
      <img src="@/assets/images/ka-logo.svg" alt="KA Logo" />
    </h2>
    <div class="user-actions">
      <RouterLink to="/me">
        <div class="user-name">
          <span class="user-icon"><UserIcon /></span>
          <span>{{ authStore.me?.name }}</span>
        </div>
      </RouterLink>

      <span class="logout-button">
        <button @click="logout">Logout</button>
      </span>
    </div>
  </header>
</template>

<script setup lang="ts">
import UserIcon from '@/assets/images/UserIcon.vue'
import { useAuthStore } from '@/store/authStore'
import { useRouter } from 'vue-router'

// logout
const authStore = useAuthStore()
const logout = () => {
  authStore.logout()
}

// home
const router = useRouter()
const goHome = () => {
  router.push('/')
}
</script>

<style scoped lang="scss">
$header-background-color: #1a222d;
$header-border-color: #2a3647;

.app-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  background-color: $header-background-color;
  padding: $spacing-m $spacing-xl;
  border-bottom: $border-width-s solid $header-border-color;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);
  color: $color-primary;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
  font-size: 0.875rem;
}

h2 {
  cursor: pointer;
  transition: color 0.2s ease;
  margin: 0;

  img {
    height: 1.5rem;
    vertical-align: middle;
  }
}

.user-actions {
  display: flex;
  align-items: center;
  gap: $spacing-l;

  a {
    text-decoration: none;
    font-weight: 300;
    transition: color 0.3s ease;

    &:hover {
      color: $color-accent;
    }
  }
}

.user-name {
  display: flex;
  align-items: center;
  gap: $spacing-s;

  .user-icon {
    display: flex;
    align-items: center;

    svg {
      height: 1.5rem;
      width: 1.5rem;
    }
  }
}

.logout-button button {
  background-color: transparent;
  color: $color-primary;
  border: $border-width-s solid $color-primary;
  border-radius: 0;
  padding: $spacing-s $spacing-m;
  font-size: inherit;
  font-weight: 300;
  letter-spacing: 0.0625rem;
  cursor: pointer;
  transition: all 0.3s ease;

  &:hover {
    background-color: rgba(255, 255, 255, 0.1);
    border-color: $color-accent;
    color: $color-accent;
  }
}
</style>
