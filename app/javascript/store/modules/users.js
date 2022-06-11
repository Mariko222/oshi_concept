import axios from '../../plugins/axios'

const state = {
  authUser: null
}

const getters = {
  authUser: state => state.authUser
}

const mutations = {
  setUser: (state, user) => {
    state.authUser = user
  }
}

const actions = {
  async fetchAuthUser({ commit, state }) {
    if (!localStorage.auth_token) return null
    if (state.authUser) return state.authUser

    const userResponse = await axios.get('users/me')
      .catch((err) => {
        return null
      })
    if (!userResponse) return null

    const authUser = userResponse.data
    if (authUser) {
      commit('setUser', authUser)
      return authUser
    } else {
      commit('setUser', null)
      return null
    }
  }
}

export default {
  state,
  getters,
  actions,
  mutations,
  namespaced: true
};
