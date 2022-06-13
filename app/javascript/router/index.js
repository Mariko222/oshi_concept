import Vue from "vue";
import VueRouter from "vue-router";
import store from '../store'

import TopIndex from "../pages/top/index";
import RegisterIndex from "../pages/register/index";
import LoginIndex from "../pages/login/index";
import MypageIndex from "../pages/mypage/index";

Vue.use(VueRouter)

const router = new VueRouter({
  mode: "history",
  routes: [
    {
      path: "/",
      component: TopIndex,
      name: "TopIndex",

    },
    {
      path: '/register',
      component: RegisterIndex,
      name: "RegisterIndex"
    },
    {
      path: '/login',
      component: LoginIndex,
      name: "LoginIndex"
    },
    {
      path: '/mypage',
      component: MypageIndex,
      name: "MypageIndex"
    },
  ]
})

router.beforeEach((to, from, next) => {
  store.dispatch('users/fetchAuthUser')
    .then((authUser) => {
      if (to.matched.some(record => record.meta.requiredAuth) && !authUser) {
        next({ name: 'LoginIndex' });
      } else {
        next();
      }
    })
});

export default router
