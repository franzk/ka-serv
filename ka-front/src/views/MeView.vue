<template>
  <div class="me-view">
    <SimpleCard class="profile-card">
      <h1 class="profile-title">Welcome back, {{ me?.name }}</h1>
      <div class="profile-details">
        <div class="detail">
          <span class="label">Name</span>
          <span class="value">{{ me?.name }}</span>
        </div>
        <div class="detail">
          <span class="label">Email</span>
          <span class="value">{{ me?.email }}</span>
        </div>
      </div>
    </SimpleCard>
  </div>
</template>


<script setup lang="ts">
import SimpleCard from '@/components/SimpleCard.vue';
import { useAuthStore } from '@/store/authStore'

const authStore = useAuthStore()
const me = authStore.me
</script>

<style scoped lang="scss">
.me-view {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 32px;
}

.profile-card {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 32px;
  gap: 24px;
}

.profile-title {
  font-size: 2rem;
  font-weight: 600;
  text-align: center;
  margin: 0 0 24px 0;
  color: #e6eef7;
  letter-spacing: 0.01em;
}

.profile-details {
  display: flex;
  flex-direction: column;
  gap: 24px;
  width: 100%;
}

.detail {
  display: flex;
  align-items: center;
  justify-content: space-between;

  padding: 14px 18px;
  border-radius: 12px;

  background: linear-gradient(
      180deg,
      rgba(255, 255, 255, 0.04),
      rgba(255, 255, 255, 0.02)
    ),
    #1f2430;
  border: 1px solid #2a3647;
  box-shadow: 0 6px 18px rgba(0, 0, 0, 0.35);

  transition: background 0.2s ease, transform 0.15s ease, box-shadow 0.15s ease;
}

.detail:hover {
  background: #242a36;
  transform: translateY(-1px);
  box-shadow: 0 12px 28px rgba(0, 0, 0, 0.4);
}

.detail .label {
  font-weight: 500;
  color: #a3b3c5;
}

.detail .value {
  font-weight: 600;
  color: #e6eef7;
}

</style>
