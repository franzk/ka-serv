import { defineStore } from 'pinia'
import { ref } from 'vue'
import Keycloak from 'keycloak-js'
import keycloakConfig from '@/config/keycloak-config'

const keycloak = new Keycloak(keycloakConfig)

export const useAuthStore = defineStore('auth', () => {
  const isAuthenticated = ref<boolean>(false)
  const token = ref<string | null>(null)

  const initKeycloak = async () => {
    try {
      console.log('Initializing Keycloak...')
      const authenticated = await keycloak.init({
        onLoad: 'login-required',
        checkLoginIframe: false,
      })
      if (authenticated) {
        isAuthenticated.value = true
        token.value = keycloak.token || null
        setupTokenRefresh()
      } else {
        isAuthenticated.value = false
        token.value = null
      }
    } catch (error) {
      console.error('Failed to initialize Keycloak', error)
    }
  }

  const login = async () => {
    try {
      await keycloak.login()
    } catch (error) {
      console.error('Failed to login', error)
    }
  }

  const logout = async () => {
    try {
      await keycloak.logout()
      isAuthenticated.value = false
      token.value = null
    } catch (error) {
      console.error('Failed to logout', error)
    }
  }

  const checkAuthentication = () => {
    return isAuthenticated.value
  }

  const setupTokenRefresh = () => {
    setInterval(async () => {
      try {
        if (await keycloak.updateToken(30)) {
          token.value = keycloak.token || null
        }
      } catch (error) {
        console.error('Failed to refresh token', error)
        logout()
      }
    }, 60000)
  }

  return {
    isAuthenticated,
    token,
    initKeycloak,
    login,
    logout,
    checkAuthentication,
  }
})
