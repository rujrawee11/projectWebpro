<style>
.createButton {
  background-color: #94dfff;
}

.LoginCardTitle {
  font-size: 1.5em;
}

.backgroundLogincolorBox {
  background-color: #c9ebef;
}

.cardd {
  display: flex;
  justify-content: center;
  margin: 0 auto;
  /* box-shadow: inset 0 0 17px #158a97, inset 0 0 17px #158a97; */
}
</style>
<template>
  <div class="column is-3 cardd">
    <div class="card backgroundLogincolorBox">
      <header class="card-header">
        <p class="card-header-title is-centered LoginCardTitle">
          Log-in
        </p>
      </header>
      <div class="card-content">
        <p
          v-if="error"
          class="
            px-3
            py-2
            mb-3
            has-text-danger-dark has-background-danger-light
          "
        >
          {{ error }}
        </p>

        <div class="field">
          <label class="label">Username</label>
          <div
            class="control has-icons-left
                                            has-icons-right"
          >
            <input
              class="input"
              v-model="username"
              name="username"
              type="text"
              placeholder="Username"
              required
            />
            <span class="icon is-small is-left">
              <i class="fas fa-user"></i>
            </span>
            <span
              class="icon is-small
                                                is-right"
            >
              <!-- <i class="fas fa-check"></i> -->
            </span>
          </div>
          <p class="help is-success">This username is available</p>
        </div>
        <div class="field">
          <label class="label">Password</label>
          <p class="control has-icons-left">
            <input
              class="input"
              v-model="password"
              name="password"
              type="password"
              placeholder="Password"
              required
            />
            <span class="icon is-small is-left">
              <i class="fas fa-lock"></i>
            </span>
          </p>
        </div>
        <div class="field has-text-right">
          <div class="control">
            <label class="checkbox">
              <input type="checkbox" name="member" />
              Forget Password?
            </label>
          </div>
          <div class="field has-text-centered">
            <p class="control">
              <button @click="submit" class="button createButton">
                Login
              </button>
            </p>
          </div>

          <div class="field has-text-centered">
            <p class="control">
              <button class="button createButton">
                <router-link style="color:black" to="/user/signup">
                  create an account
                </router-link>
              </button>
            </p>
          </div>
        </div>

        <!-- <div class="column is-4">
        <h1 class="title">Log in</h1>

        <p
          v-if="error"
          class="
            px-3
            py-2
            mb-3
            has-text-danger-dark has-background-danger-light
          "
        >
          {{ error }}
        </p> -->

        <!-- Login form -->
        <!-- <div class="field">
          <label class="label">Username</label>
          <div class="control has-icons-left">
            <input v-model="username" class="input" type="text" />
            <span class="icon is-small is-left">
              <i class="fas fa-user"></i>
            </span>
          </div>
        </div> -->

        <!-- <div class="field">
          <label class="label">Password</label>
          <div class="control has-icons-left has-icons-right">
            <input v-model="password" class="input" type="password" />
            <span class="icon is-small is-left">
              <i class="fas fa-lock"></i>
            </span>
            <span class="icon is-small is-right">
              <i class="fas fa-check"></i>
            </span>
          </div>
        </div> -->

        <!-- <button class="button is-primary is-fullwidth" @click="submit">
          Login
        </button>

        <p class="my-3">
          Don't have an account yet? <a href="/signup.html">Sign up</a>
        </p> -->
      </div>
    </div>
  </div>
</template>

<script>
import axios from "@/plugins/axios";
export default {
  data() {
    return {
      username: "",
      password: "",
      error: ""
    };
  },
  methods: {
    submit() {
      const data = {
        username: this.username,
        password: this.password
      };

      axios
        .post("http://localhost:5000/user/login/", data)
        .then(res => {
          const token = res.data.token;
          localStorage.setItem("token", token);
          this.$emit("auth-change");
          this.$router.push({ path: "/" });
        })
        .catch(error => {
          this.error = error.response.data;
          console.log(error.response.data);
        });
    }
  }
};
</script>
