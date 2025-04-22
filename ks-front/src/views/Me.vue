<template>
  <section class="profile-card">
    <h1 class="profile-title">🧑‍💻 Welcome back, {{ me?.name }}</h1>
    <div class="profile-details">
      <div class="detail">
        <span class="label">📛 Name</span>
        <span class="value">{{ me?.name }}</span>
      </div>
      <div class="detail">
        <span class="label">📧 Email</span>
        <span class="value">{{ me?.email }}</span>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
import { useAuthStore } from '@/store/authStore'

const authStore = useAuthStore()
const me = authStore.me
</script>

<style scoped lang="scss">
.profile-card {
  max-width: 700px;
  margin: 3rem auto;
  background: #1f1f2e;
  border-radius: 14px;
  padding: 2rem 2.5rem;
  box-shadow: 0 6px 20px rgba(0, 0, 0, 0.4);
  color: #e4e4e7;
  font-family: 'Inter', 'Segoe UI', sans-serif;
}

.profile-title {
  font-size: 1.8rem;
  font-weight: 600;
  margin-bottom: 2rem;
  color: #66d9ef;
}

.profile-details {
  display: flex;
  flex-direction: column;
  gap: 1.2rem;
}

.detail {
  display: flex;
  justify-content: space-between;
  background: #2a2a3b;
  padding: 1rem 1.2rem;
  border-radius: 10px;
  transition: background 0.2s ease;

  &:hover {
    background: #333344;
  }

  .label {
    font-weight: 500;
    color: #a1a1aa;
  }

  .value {
    font-weight: 600;
    color: #f4f4f5;
  }
}
</style>
