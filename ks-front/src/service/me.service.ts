import api from '@/config/axios'
import type { Me } from '@/domain/me'

export class MeService {
  static async getMe(): Promise<Me> {
    return api
      .get('/me')
      .then((response) => response.data)
      .catch((error) => 'Error fetching data:' + error)
  }
}
