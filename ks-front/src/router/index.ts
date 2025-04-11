import { createRouter, createWebHistory } from 'vue-router'
import Something from '@/views/Something.vue'
import Me from '@/views/Me.vue'

const routes: Array<RouteRecordRaw> = [
  { path: '/', component: Something, name: 'something' },
  { path: '/me', component: Me, name: 'me' },
]

const router = createRouter({
  history: createWebHistory(),
  routes,
})

router.beforeEach(async (to, from, next) => {
  next()
})

export default router
