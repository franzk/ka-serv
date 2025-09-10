<template>
  <div class="card">
    <slot></slot>
  </div>
</template>

<script setup lang="ts">

</script>

<style scoped lang="scss">
$border-color: #ccc;
$color-card-background: #222;

.card {
  display: flex;
  flex-direction: column;
  /*background-color: $color-card-background;
  border: $border-width-s solid $border-color;
  border-radius: $border-radius-m;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  padding: $spacing-l;
  margin: $spacing-m 0;
  transition: box-shadow 0.2s ease;

  &:hover {
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
  }*/

  max-width: 560px;
  width: clamp(320px, 60vw, 560px);
  padding: 28px;
  border-radius: 18px;
  background: linear-gradient(180deg, rgba(255, 255, 255, 0.04), rgba(255, 255, 255, 0.02)), #121923;
  border: 1px solid #1f2a37;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.35);
  backdrop-filter: blur(6px);
  color: #e6eef7;
  font-family: ui-sans-serif, Inter, system-ui, -apple-system, Segoe UI, Roboto, "Helvetica Neue", Arial;

}
</style>
