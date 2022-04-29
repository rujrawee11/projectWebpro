<style>
@import url("https://fonts.googleapis.com/css2?family=Kanit:wght@300&display=swap");

.navbar {
  margin-top: 0px;
  padding: 5px;
  font-family: "Kanit", sans-serif;
}

#app {
  font-family: "Kanit", sans-serif;
}

.hero {
  font-family: "Kanit", sans-serif;
}
</style>
<template>
  <div id="app">
    <!-- nav bar -->
    <nav
      class="navbar has-shadow is-info"
      role="navigation"
      aria-label="main navigation"
    >
      <div class="navbar-brand">
        <router-link to="/" class="navbar-item is-size-4">
          <img
            src="https://www.img.in.th/images/a2bbd4fd4b270f2bf3a67dd2132fdd77.png"
            alt="a2bbd4fd4b270f2bf3a67dd2132fdd77.png"
            border="0"
          />
        </router-link>

        <a
          role="button"
          class="navbar-burger"
          aria-label="menu"
          aria-expanded="false"
          data-target="navbarBasicExample"
        >
          <span aria-hidden="true"></span>
          <span aria-hidden="true"></span>
          <span aria-hidden="true"></span>
        </a>
      </div>

      <div class="navbar-menu">
        <div class="navbar-start">
          <a class="navbar-item has-text-white" href="../../"> Home </a>

          <div class="navbar-item has-dropdown is-hoverable">
            <a class="navbar-link has-text-white" href="../../"> Room </a>
            <div class="navbar-dropdown">
              <a class="navbar-item"> check room price </a>
              <a class="navbar-item"> check room status </a>
            </div>
          </div>

          <div class="navbar-item has-dropdown is-hoverable">
            <a class="navbar-link has-text-white" href="../../"> Contract </a>

            <div class="navbar-dropdown">
              <a class="navbar-item"> lease contract </a>
              <a class="navbar-item" href=""> cancle contract </a>
            </div>
          </div>

          <div class="navbar-item has-dropdown is-hoverable is-info">
            <a class="navbar-link has-text-white" href="../../"> Invoice </a>

            <div class="navbar-dropdown">
              <a class="navbar-item"> manage invoice </a>
              <a class="navbar-item"> record meters </a>
            </div>
          </div>
          <router-link class="navbar-item has-text-white" :to="`/parcel`">
            Parcel
          </router-link>
        </div>

        <div class="navbar-end">
          <div v-if="user" class="navbar-item">
            <router-link to="/blogs/create" class="button is-primary">
              <strong>New Blog</strong>
            </router-link>
          </div>

          <div v-if="user" class="navbar-item has-dropdown is-hoverable">
            <a class="navbar-link">
              <figure class="image is-24x24 my-auto">
                <img
                  class="is-rounded"
                  :src="`https://bulma.io/images/placeholders/128x128.png`"
                />
              </figure>
              <span class="pl-3"
                >{{ user.first_name }} {{ user.last_name }}</span
              >
            </a>
            <div class="navbar-dropdown">
              <router-link class="navbar-item" :to="`/manage`"
                >manage account</router-link
              >
              <router-link to="/user/logout"
                ><a @click="logout" class="navbar-item">Log out</a></router-link
              >
            </div>
          </div>

          <div v-if="!user" class="navbar-item">
            <router-link to="/user/login">
              <strong>Login</strong>
            </router-link>
          </div>
          <div v-if="!user" class="navbar-item">
            <router-link to="/user/signup">
              <strong>Signup</strong>
            </router-link>
          </div>
        </div>
      </div>
    </nav>

    <router-view
      :key="$route.fullPath"
      @auth-change="onAuthChange"
      :user="user"
    />
  </div>
</template>

<script>
import axios from "@/plugins/axios";
export default {
  data() {
    return {
      user: null,
      username: "",
      password: ""
    };
  },
  mounted() {
    this.onAuthChange();
  },
  methods: {
    onAuthChange() {
      const token = localStorage.getItem("token");
      if (token) {
        this.getUser();
      }
    },
    getUser() {
      axios.get("/user/me").then(res => {
        this.user = res.data;
      });
    },
    logout() {
      localStorage.clear();
      this.$router.push({ path: "/signup" });
      console.log("log out");
      this.username = "";
      this.password = "";
    }
  }
};
</script>
