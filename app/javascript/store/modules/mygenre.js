const state = {
  mygenre: {}
}

const getters = {
  mygenre: state => state.mygenre
}

const mutations = {
  loadMygenre: (state, mygenre) => {
    state.mygenre = mygenre
  }
}

export default {
  state,
  getters,
  mutations,
  namespaced: true
};
