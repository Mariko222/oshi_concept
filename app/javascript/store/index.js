import Vue from 'vue'
import Vuex from 'vuex'

import users from './modules/users'
import flash from './modules/flash'
import mygenre from './modules/mygenre'

Vue.use(Vuex)

export default new Vuex.Store({
  modules: {
    users,
    flash,
    mygenre
  }
})
