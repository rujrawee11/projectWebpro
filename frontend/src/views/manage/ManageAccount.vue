<template>
  <div class="container is-widescreen">
    <section class="section">
      <div class="columns">
        <div class="column is-2">
          <span class="is-inline-flex">
            <figure class="image is-32x32 my-auto mb-5">
              <img
                class="is-rounded"
                :src="`https://bulma.io/images/placeholders/128x128.png`"
              />
            </figure>
            <p class="mt-1">
              <strong style="width: 300px; margin-left: 10px">
                &nbsp; {{ blogs.first_name }}</strong
              >
            </p>
          </span>
        </div>
        <!-- <div class="decoration" style="height: 100; width: 1px; background-color: rgb(138, 135, 135); display:block;"></div> -->
        <div class="column">
          <div class="tabs is-boxed" style="margin-bottom: 0%">
            <ul>
              <li class="tab is-active" v-on:click="tab($event, 'profile')">
                <a>
                  <span class="icon is-small"
                    ><i class="fas fa-user" aria-hidden="true"></i
                  ></span>
                  <span>Profile</span>
                </a>
              </li>
              <li class="tab" v-on:click="tab($event, 'account')">
                <a>
                  <span class="icon is-small"
                    ><i class="fas fa-envelope" aria-hidden="true"></i
                  ></span>
                  <span>Account</span>
                </a>
              </li>
            </ul>
          </div>

          <article
            :class="['panel is-primary', 'content-tab']"
            id="profile"
            style="background-color: #c9ebef"
          >
            <div class="panel-block mr-6 ml-6 pb-5">
              <div class="columns">
                <div class="column is-12">
                  <label class="label" style="width: 100px">Name :</label>
                  <input
                    class="input is-rounded"
                    type="text"
                    :class="{ 'is-danger': error.firstName }"
                    name="name"
                    v-model="name"
                    placeholder="name"
                  />
                  <p style="color: red">{{ error.firstName }}</p>
                </div>
                <div class="column is-12">
                  <label class="label" style="width: 100px">Surname :</label>

                  <input
                    class="input is-rounded"
                    type="text"
                    :class="{ 'is-danger': error.surName }"
                    name="surname"
                    v-model="surname"
                    placeholder="surname"
                  />
                  <p style="color: red">{{ error.surName }}</p>
                </div>
              </div>
            </div>

            <div class="panel-block mx-6 pb-5">
              <p class="control">
                <label class="label" style="width: 100px">Adress :</label>
                <textarea
                  class="textarea is-primary is-rounded"
                  v-model="address"
                  name="address"
                  placeholder="address"
                ></textarea>
              </p>
            </div>

            <div class="panel-block mr-6 ml-6 pb-5">
              <div class="columns">
                <div class="column is-12">
                  <label class="label" style="width: 100px">Tel1 :</label>
                  <input
                    class="input is-rounded"
                    type="text"
                    :class="{ 'is-danger': error.phone1 }"
                    name="tel1"
                    v-model="tel1"
                    placeholder="Telephone Number"
                  />
                  <p style="color: red">{{ error.phone1 }}</p>
                </div>
                <div class="column is-12">
                  <label class="label" style="width: 100px">Tel2 :</label>

                  <input
                    class="input is-rounded"
                    type="text"
                    v-model="tel2"
                    name="tel2"
                    placeholder="Telephone Number"
                  />
                </div>
              </div>
            </div>
            <button
              class="button is-rounded is-right"
              @click="showProfileModal = true"
              style="
                background-color: #fcadb0;
                font-weight: bold;
                float: right;
                margin-top: 30px;
              "
            >
              Update Profile
            </button>
          </article>

          <article
            :class="['panel is-primary', 'content-tab']"
            id="account"
            style="background-color: #c9ebef; display: none"
          >
            <div class="panel-block mr-6 ml-6 pb-5 pt-5">
              <p class="control">
                <label class="label" style="width: 100px">Email :</label>
                <input
                  class="input is-rounded"
                  type="emial"
                  name="email"
                  v-model="email"
                  placeholder="email"
                />
                <button
                  class="button is-rounded is-right"
                  type="submit"
                  @click="showEmailModal = true"
                  style="
                    background-color: #fcadb0;
                    font-weight: bold;
                    margin-top: 11px;
                  "
                >
                  Update Email
                </button>
              </p>
            </div>

            <div class="panel-block mx-6 pb-5">
              <p class="control">
                <label class="label" style="width: 100px">Password :</label>
                <input
                  class="input is-rounded"
                  type="password"
                  name="password"
                  v-model="password"
                  placeholder="*******"
                />
                <button
                  class="button is-rounded is-right"
                  type="submit"
                  style="
                    background-color: #fcadb0;
                    font-weight: bold;
                    margin-top: 11px;
                  "
                >
                  Edit Password
                </button>
              </p>
            </div>
          </article>
        </div>
      </div>

      <div class="modal" :class="{ 'is-active': showProfileModal }">
        <div class="modal-background"></div>
        <div class="modal-card">
          <header class="modal-card-head has-background-info">
            <p class="modal-card-title has-text-centered has-text-white">
              ยืนยัน
            </p>
          </header>
          <section class="modal-card-body has-text-centered">
            ยืนยันการแก้ไขข้อมูล
          </section>
          <footer class="modal-card-foot">
            <button class="button is-danger" @click="saveEditProfile">
              Confirm
            </button>
            <button class="button" @click="cancleProfile">
              Cancel
            </button>
          </footer>
        </div>
      </div>

      <div class="modal" :class="{ 'is-active': showEmailModal }">
        <div class="modal-background"></div>
        <div class="modal-card">
          <header class="modal-card-head has-background-info">
            <p class="modal-card-title has-text-centered has-text-white">
              ยืนยัน
            </p>
          </header>
          <section class="modal-card-body has-text-centered">
            ยืนยันการแก้ไขข้อมูล
          </section>
          <footer class="modal-card-foot">
            <button class="button is-danger" @click="saveEditEmail">
              Confirm
            </button>
            <button class="button" @click="cancleEmail">Cancel</button>
          </footer>
        </div>
      </div>
    </section>
  </div>
</template>

<script>
import axios from "@/plugins/axios";

export default {
  name: "manage",
  props: ["user"],
  data() {
    return {
      blogs: {},
      comments: [],
      images: [],
      error2: null,
      name: "",
      surname: "",
      address: "",
      tel1: "",
      tel2: "",
      error: {
        firstName: "",
        surName: "",
        phone1: "",
      },
      email: "",
      password: "",
      showProfileModal: false,
      showEmailModal: false,
    };
  },
  mounted() {
    this.getBlogDetail();
  },
  created() {
    /* this.name = this.blogs.first_name
    this.surname = this.blogs.last_name
    this.tel1 = this.blogs.mobile
    this.tel2 = this.blogs.phone2
    this.email = this.blogs.email
    this.password = this.blogs.password */
    //this.filteredTasks = this.tasks
  },
  watch: {
    name(newVal, oldVal) {
      if (newVal != "") {
        this.error.firstName = "";
      } else if (newVal == "") {
        this.error.firstName = "กรุณากรอกชื่อ";
        return;
      }
    },
    surname(newVal, oldVal) {
      if (newVal != "") {
        this.error.surName = "";
      } else if (newVal == "") {
        this.error.surName = "กรุณากรอกนามสกุล";
        return;
      }
    },
    tel1(newVal, oldVal) {
      if (newVal != "") {
        this.error.phone1 = "";
      } else if (newVal == "") {
        this.error.phone1 = "กรุณากรอกเบอร์โทรศัพท์";
        return;
      }
    },
  },
  methods: {
    getBlogDetail() {
      axios
        .get(`http://localhost:5000/manage`)
        .then((response) => {
          this.blogs = response.data.blog;
          this.name = this.blogs.first_name;
          this.surname = this.blogs.last_name;
          this.tel1 = this.blogs.mobile;
          this.tel2 = this.blogs.phone2;
          this.email = this.blogs.email;
          this.password = this.blogs.password;
        })
        .catch((error) => {
          this.error2 = error.response.data.message;
        });
    },
    saveEditProfile() {
      axios
        .put(`http://localhost:5000/updateProfile`, {
          name: this.name,
          surname: this.surname,
          tel1: this.tel1,
          tel2: this.tel2,
        })
        .then((response) => {
          this.name = response.data.name;
          this.surname = response.data.surname;
          this.tel1 = response.data.tel1;
          this.tel2 = response.data.tel2;
          this.showProfileModal = false;
        })
        .catch((error) => {
          this.error = error.message;
        });
    },
    cancleProfile() {
      this.showProfileModal = false;
      this.name = this.blogs.first_name;
      this.surname = this.blogs.last_name;
      this.tel1 = this.blogs.mobile;
      this.tel2 = this.blogs.phone2;
    },
    saveEditEmail() {
      axios
        .put(`http://localhost:5000/updateEmail`, {
          email: this.email,
        })
        .then((response) => {
          this.email = response.data.email;
          this.showEmailModal = false;
        })
        .catch((error) => {
          this.error = error.message;
        });
    },
    cancleEmail() {
      
      this.email = this.blogs.email;
      this.showEmailModal = false;
    },
    isBlogOwner(blog) {
      if (this.user.role === "admin") {
        return true;
      } else if (!this.user) {
        return false;
      }
      return blog.create_by_id === this.user.id;
    },
    isCommentOwner(comment) {
      if (this.user.role === "admin") {
        return true;
      } else if (!this.user) {
        return false;
      }
      return comment.comment_by_id === this.user.id;
    },
    tab: function (evt, tabName) {
      var i, x, tablinks;
      x = document.getElementsByClassName("content-tab");
      for (i = 0; i < x.length; i++) {
        x[i].style.display = "none";
      }
      tablinks = document.getElementsByClassName("tab");
      for (i = 0; i < x.length; i++) {
        tablinks[i].className = tablinks[i].className.replace(" is-active", "");
      }
      document.getElementById(tabName).style.display = "block";
      evt.currentTarget.className += " is-active";
    },
  },
};
</script>