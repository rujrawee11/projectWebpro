import Vue from 'vue'
import VueRouter from 'vue-router'

Vue.use(VueRouter)

const routes = [
  {
    path: '/',
    name: 'home',
    component: () => import('../views/Home.vue')
  },
  {
    path: '/blogs/detail/:id',
    name: 'detail',
    component: () => import('../views/blogs/DetailBlog.vue')
  },
  {
    path: '/blogs/create',
    name: 'create-blog',
    meta: { login: true },
    component: () => import('../views/blogs/CreateBlog.vue')
  },
  {
    path: '/blogs/update/:id',
    name: 'update-blog',
    meta: { login: true },
    component: () => import('../views/blogs/UpdateBlog.vue')
  },
  {
    path: '/user/signup',
    name: 'signup',
    meta: { guess: true },
    component: () => import('../views/Signup.vue')
  },
  {
    path: '/user/login',
    name: 'login',
    meta: { guess: true },
    component: () => import('../views/Login.vue')
  },
  {
    path: '/user/logout',
    name: 'logout',
    meta: { login: true },
    component: () => import('../views/Login.vue')
  },
  {
    path: '/manage',
    name: 'manage',
    component: () => import('../views/manage/ManageAccount.vue')
  },
  {
    path: '/parcel',
    name: 'parcel',
    component: () => import('../views/parcel/Parcel.vue')
  },
  {
    path: '/Manageinvoice',
    name: 'manageinvoice',
    component: () => import('../views/manage/ManageInvoice.vue')
  },
  {
    path: '/invoice',
    name: 'invoice',
    component: () => import('../views/manage/Invoice.vue')
  },
]

const router = new VueRouter({ routes })

router.beforeEach((to, from, next) => {
  const isLoggedIn = !!localStorage.getItem('token')
  if (to.meta.guess && isLoggedIn) {
    alert("You've already logged in")
    comsole.log('login')
    next({ path: '/' })
  }
  if (to.meta.login && !isLoggedIn) {
    alert('Please login first!')
    next({ path: '/user/login' })
  }



  next()
})

export default router
