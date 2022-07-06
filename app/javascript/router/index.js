import Vue from "vue";
import VueRouter from "vue-router";
import store from '../store'

import TopIndex from "../pages/top/index";
import RegisterIndex from "../pages/register/index";
import LoginIndex from "../pages/login/index";
import MypageIndex from "../pages/mypage/index";
import MypageNew from "../pages/mypage/new";
import MypageEdit from "../pages/mypage/edit";
import MygenresEdit from "../pages/mygenres/edit";
import PostIndex from "../pages/post/index";
import PostNew from "../pages/post/new";

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
      name: "MypageIndex",
      meta: { requiredAuth: true }
    },
    {
      path: '/mypage/new',
      component: MypageNew,
      name: "MypageNew",
      meta: { requiredAuth: true },
    },
    {
      path: '/mypage/edit',
      component: MypageEdit,
      name: "MypageEdit",
      meta: { requiredAuth: true },
    },
    {
      path: '/mygenres/edit',
      component: MygenresEdit,
      name: "MygenresEdit",
      meta: { requiredAuth: true },
    },
    {
      path: '/post',
      component: PostIndex,
      name: "PostIndex",
      meta: { requiredAuth: true },
    },
    {
      path: '/post/new',
      component: PostNew,
      name: "PostNew",
      meta: { requiredAuth: true },
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
