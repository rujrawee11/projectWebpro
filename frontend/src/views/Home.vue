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
  justify-content: center;
  margin: 0 auto;

  /* box-shadow: inset 0 0 17px #158a97, inset 0 0 17px #158a97; */
}
.feed {
  background-color: #94dfff;
  padding: 1.5%;
  margin-bottom: 3%;
  width: 15%;
  text-align: center;
  font-weight: 900;
}
</style>
<template>
  <div class="container is-widescreen">
    <section class="hero">
      <div class="hero-body">
        <p class="title">NEWS</p>
        <div class="columns">
          <div class="column is-half">
            <input
              class="input"
              type="text"
              v-model="search"
              placeholder="Search blog(s)"
            />
          </div>
          <div class="column is-half">
            <button @click="getBlogs" class="button">Search</button>
          </div>
        </div>
      </div>
    </section>
    <section>
      <div v-if="isBlogOwner()" class="box">
        <nav
          class="navbar has-shadow is-info mb-4"
          role="navigation"
          aria-label="main navigation"
        >
          <div class="navbar-menu">
            <div class="navbar-start">
              <a class="navbar-item has-text-white"> <strong> POST </strong></a>
            </div>

            <div class="navbar-item has-text-white">
              <strong id="date" style="color:white">Date :</strong>
            </div>
          </div>
        </nav>
        <div class="level-left ">
          <label class="label mr-3">Title : </label>

          <input
            v-model="titleBlog"
            class="input column is-3 "
            type="text"
            placeholder=""
          />
        </div>

        <div class="field">
          <label class="label">Content</label>
          <div class="control">
            <textarea
              v-model="contentBlog"
              class="textarea"
              placeholder=""
            ></textarea>
          </div>
        </div>

        <div class="control mb-3">
          <label class="radio">
            <input v-model="statusBlog" type="radio" name="answer" value="01" />
            Private
          </label>
          <label class="radio">
            <input v-model="statusBlog" type="radio" name="answer" value="02" />
            Public
          </label>
        </div>

        <div class="field">
          <div class="control">
            <label class="checkbox">
              <input v-model="pinnedBlog" type="checkbox" />
              Pinned
            </label>
          </div>
        </div>
        <input
          class="mb-5"
          multiple
          type="file"
          accept="image/png, image/jpeg, image/webp"
          @change="selectImages"
        />
        <div v-if="images" class="columns is-multiline">
          <div
            v-for="(image, index) in images"
            :key="image.id"
            class="column is-one-quarter"
          >
            <div class="card">
              <div class="card-image">
                <figure class="image is-4by3">
                  <img :src="showSelectImage(image)" alt="Placeholder image" />
                </figure>
              </div>
              <footer class="card-footer">
                <a
                  @click="deleteSelectImage(index)"
                  class="card-footer-item has-text-danger"
                  >Delete</a
                >
              </footer>
            </div>
          </div>
        </div>
        <div class="field level-right">
          <button @click="submitBlog" class="button is-link">
            create post
          </button>

          <!-- <button @click="$router.go(-1)" class="button is-link is-light">
            Cancel
          </button> -->
        </div>
      </div>
    </section>

    <section class="section" id="app">
      <div class="feed">NEWS FEED</div>
      <div class="content">
        <div class="columns is-multiline">
          <div
            class="column is-8 cardd"
            v-for="(blog, index) in blogs"
            :key="blog.id"
          >
            <div class="card ">
              <nav
                class="navbar has-shadow has-text-white is-info"
                role="navigation"
                aria-label="main navigation"
              >
                <div class="navbar-menu">
                  <div class="navbar-start">
                    <a class="navbar-item has-text-white">
                      Date : {{ blog.create_date.slice(0, 10) }}
                    </a>
                  </div>
                </div>
                <div
                  v-if="isBlogOwner(blog)"
                  class="navbar-item has-dropdown has-text-white is-hoverable"
                >
                  <a class="navbar-link has-text-white "> </a>
                  <div class="navbar-dropdown">
                    <a
                      v-if="isBlogOwner(blog)"
                      class="navbar-item"
                      @click="
                        $router.push({
                          name: 'update-blog',
                          params: { id: blog.id }
                        })
                      "
                      >edit post</a
                    >

                    <a
                      v-if="isBlogOwner(blog)"
                      class="navbar-item"
                      @click="deleteBlog(blog, index)"
                      >delete post</a
                    >
                  </div>
                </div>
              </nav>

              <div class="card-image pt-5 backgroundLogincolorBox">
                <figure class="image">
                  <img
                    style="height: 250px"
                    :src="imagePath(blog.file_path)"
                    alt="Placeholder image"
                  />
                </figure>
              </div>
              <div class="card-content backgroundLogincolorBox">
                <div class="title">{{ blog.title }}</div>
                <div class="content" style="height: 100px">
                  {{ shortContent(blog.content) }}
                </div>
              </div>
              <footer class="card-footer">
                <a class="card-footer-item" @click="addLike(blog.id)">
                  <span class="icon-text">
                    <span class="icon">
                      <i class="far fa-heart"></i>
                    </span>
                    <span>Like ({{ blog.like }})</span>
                  </span>
                </a>
                <router-link
                  class="card-footer-item"
                  :to="`/blogs/detail/${blog.id}`"
                  >Read more...</router-link
                >

                <!-- <a
                  v-if="isBlogOwner(blog)"
                  class="card-footer-item"
                  @click="
                    $router.push({
                      name: 'update-blog',
                      params: { id: blog.id }
                    })
                  "
                >
                  <span class="icon-text">
                    <span>Edit</span>
                  </span>
                </a> -->
              </footer>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script>
import axios from "@/plugins/axios";
// @ is an alias to /src
export default {
  name: "Home",
  props: ["user"],
  data() {
    return {
      search: "",
      blogs: [],
      error: null,
      images: [], // array of image
      titleBlog: "",
      contentBlog: "",
      pinnedBlog: false,
      statusBlog: "01"
    };
  },
  mounted() {
    this.getBlogs();
  },
  methods: {
    getBlogs() {
      axios
        .get("http://localhost:5000", {
          params: {
            search: this.search
          }
        })
        .then(response => {
          this.blogs = response.data;
          this.bloggroup = response.data;
        })
        .catch(err => {
          console.log(err);
        });
    },
    imagePath(file_path) {
      if (file_path) {
        return "http://localhost:5000/" + file_path;
      } else {
        return "https://bulma.io/images/placeholders/640x360.png";
      }
    },
    shortContent(content) {
      if (content.length > 200) {
        return content.substring(0, 197) + "...";
      }
      return content;
    },
    addLike(blogId) {
      axios
        .put(`http://localhost:5000/blogs/addlike/${blogId}`)
        .then(response => {
          let selectedBlog = this.blogs.filter(e => e.id === blogId)[0];
          selectedBlog.like = response.data.like;
        })
        .catch(err => {
          console.log(err);
        });
    },
    deleteBlog(blog, index) {
      const result = confirm(`Are you sure you want to delete`);
      if (result) {
        axios
          .delete(`http://localhost:5000/blogs/${blog.id}`)
          .then(response => {
            console.log(response);
            this.blogs.splice(index, 1);
          })
          .catch(error => {
            alert(error.response.data.message);
          });
      }
    },
    isBlogOwner(blog) {
      if (this.user.role === "employee" || this.user.role === "lessor") {
        return true;
      } else if (!this.user) {
        return false;
      }
      // return blog.create_by_id === this.user.id;
    },
    selectImages(event) {
      this.images = event.target.files;
    },
    showSelectImage(image) {
      // for preview only
      return URL.createObjectURL(image);
    },
    deleteSelectImage(index) {
      console.log(this.images);
      this.images = Array.from(this.images);
      this.images.splice(index, 1);
    },
    submitBlog() {
      let formData = new FormData();
      formData.append("title", this.titleBlog);
      formData.append("content", this.contentBlog);
      formData.append("pinned", this.pinnedBlog ? 1 : 0);
      formData.append("status", "01");
      this.images.forEach(image => {
        formData.append("myImage", image);
      });
      axios
        .post("http://localhost:5000/blogs", formData)
        .then(response => {
          // this.$router.push({ name: "home" });
          this.blog.push(response.data);
        })
        .catch(e => console.log("err"));
    }
  }
};

const myInterval = setInterval(myTimer, 1000);

function myTimer() {
  const date = new Date();
  document.getElementById("date").innerHTML =
    "DATE : " +
    date.toLocaleDateString() +
    "&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;TIME : " +
    date.toLocaleTimeString();
}
</script>
