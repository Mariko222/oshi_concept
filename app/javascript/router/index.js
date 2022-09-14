import Vue from "vue";
import VueRouter from "vue-router";
import store from '../store'

import TopIndex from "../pages/top/index";
import RegisterIndex from "../pages/register/index";
import LoginIndex from "../pages/login/index";
import MypageNew from "../pages/mypage/new";
import MypageEdit from "../pages/mypage/edit";
import MygenresEdit from "../pages/mygenres/edit";
import PostIndex from "../pages/post/index";
import PostNew from "../pages/post/new";
import oauthCallback from "../pages/login/oauthCallback.vue";
import TheTerms from "../pages/static/TheTerm.vue";
import ThePolicy from "../pages/static/ThePolicy.vue";
import ResetPasswordNew from "../pages/reset_password/ResetPasswordNew.vue";
import ResetPasswordEdit from "../pages/reset_password/ResetPasswordEdit.vue";



Vue.use(VueRouter)

const router = new VueRouter({
  mode: "history",
  scrollBehavior(to, from, savedPosition) {
    if (savedPosition) {
      return savedPosition
    } else {
      return {
        x: 0, y: 0
      }
    }
  },
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
      path: '/mypage/:uuid',
      component: PostIndex,
      name: "PostIndex",
      props: true
    },
    {
      path: '/post/new',
      component: PostNew,
      name: "PostNew",
      meta: { requiredAuth: true },
    },
    {
      path: "/oauth/callback",
      name: "oauthCallback",
      component: oauthCallback,
    },
    {
      path: "/terms",
      name: "TheTerms",
      component: TheTerms,
    },
    {
      path: "/policy",
      name: "ThePolicy",
      component: ThePolicy,
    },
    {
      path: "/password_resets",
      name: "ResetPasswordNew",
      component: ResetPasswordNew,
    },
    {
    path: "/password/edit",
    name: "ResetPasswordEdit",
    component: ResetPasswordEdit,
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
