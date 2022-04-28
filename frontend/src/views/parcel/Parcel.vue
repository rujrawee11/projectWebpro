<template>
  <div class="container is-widescreen">
    <section class="section">
      <div class="hero">
        <div class="columns is-centered">
          <span
            v-if="isEmpOwner()"
            class="icon is-large"
            style="margin-top: 6px; margin-left: 1%"
            @click="addList"
          >
            <i class="fas fa-plus-circle fa-2x mr-2"></i>
          </span>

          <div class="column is-two-fifths">
            <div class="field is-grouped">
              <p class="control is-expanded has-icons-right">
                <input
                  class="input is-rounded"
                  type="text"
                  width="112"
                  v-model="search"
                  placeholder="ค้นหาห้องพัก..."
                />
                <span class="icon is-small is-right">
                  <i class="fas fa-search"></i>
                </span>
              </p>
              <button @click="getBlogDetail" class="button">Search</button>
            </div>
          </div>
        </div>
      </div>

      <div class="modal" :class="{ 'is-active': showAddModal }">
        <div class="modal-background"></div>
        <div class="modal-card">
          <header class="modal-card-head has-background-info">
            <p class="modal-card-title has-text-centered has-text-white">
              เพิ่มรายการพัสดุ
            </p>
            <button
              class="delete"
              aria-label="close"
              @click="showAddModal = false"
            ></button>
          </header>

          <section class="modal-card-body">
            <div class="columns mr-6">
              <div class="column">
                <div class="field is-horizontal">
                  <div class="field-label is-normal">
                    <label class="label" style="width: 100px"
                      >ชื่อผู้รับ :</label
                    >
                  </div>
                  <div class="field-body">
                    <div class="field">
                      <div class="control">
                        <input
                          class="input"
                          type="text"
                          :class="{ 'is-danger': error.pName }"
                          name="p_name"
                          v-model="addListName"
                          placeholder="Recipient Name"
                        />
                        <span style="color: red">{{ error.pName }}</span>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div class="columns mr-6">
              <div class="column is-6">
                <div class="field is-horizontal">
                  <div class="field-label is-normal">
                    <label class="label" style="width: 100px">เลขห้อง :</label>
                  </div>

                  <div class="field-body">
                    <div class="field">
                      <div class="control">
                        <input
                          class="input"
                          type="text"
                          :class="{ 'is-danger': error.room_number }"
                          name="room_number"
                          v-model="addListRoom"
                          placeholder="Room Number"
                        />
                        <span style="color: red">{{ error.room_number }}</span>
                      </div>
                    </div>
                  </div>
                </div>
              </div>

              <div class="column is-6">
                <div class="field is-horizontal">
                  <div class="field-label is-normal">
                    <label class="label" style="width: 100px"
                      >บริษัทขนส่ง :</label
                    >
                  </div>
                  <div class="field-body">
                    <div class="field">
                      <div class="control">
                        <input
                          class="input"
                          type="text"
                          :class="{ 'is-danger': error.transport_name }"
                          v-model="addListTransport"
                          name="transport_name"
                          placeholder="Transport Name"
                        />
                        <span style="color: red">{{
                          error.transport_name
                        }}</span>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div class="columns mr-6">
              <div class="column is-6">
                <div class="field is-horizontal">
                  <div class="field-label is-normal">
                    <label class="label" style="width: 100px"
                      >วันที่พัสดุมาถึง :
                    </label>
                  </div>
                  <div class="field-body">
                    <div class="field">
                      <div class="control">
                        <input
                          style="min-width: 100px"
                          class="input"
                          type="date"
                          :class="{ 'is-danger': error.duedate }"
                          name="sent_date"
                          v-model="duedate"
                          Due
                          date
                        />
                        <span style="color: red">{{ error.duedate }}</span>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </section>

          <footer
            class="modal-card-foot has-background-white"
            style="padding-left: 35%"
          >
            <button
              class="button is-danger"
              @click="confirmAddParcel"
              type="submit"
            >
              ยืนยัน
            </button>

            <button
              style="margin-left: 20px"
              class="button"
              @click="cancleAddModal"
            >
              ยกเลิก
            </button>
          </footer>
        </div>
      </div>

      <br />
      <div class="content mb-1" v-if="isTenantOwner()">
        <div class="field has-addons">
          <p class="control">
            <button
              :class="['button', showAllParcel == 1 ? 'is-info' : '']"
              @click="showMyParcel"
            >
              <span class="icon is-small">
                <i class="fas fa-user"></i>
              </span>
              <span>รายการพัสดุของฉัน</span>
            </button>
          </p>
          <p class="control">
            <button
              :class="['button', showAllParcel == -1 ? 'is-info' : '']"
              @click="showAllParcel = -1"
            >
              <span class="icon is-small">
                <i class="fas fa-bell"></i>
              </span>
              <span>รายการพัสดุทั้งหมด</span>
            </button>
          </p>
        </div>
      </div>

      <div :class="['content mt-2', showAllParcel == -1 ? '' : 'is-hidden']">
        <div class="p-4" style="background-color: #ff91a8; color: white">
          <article class="media">
            <div class="media-content">
              <div class="content">
                <div class="columns" style="font-weight: bold">
                  <div class="column">ลำดับ</div>
                  <div class="column">ชื่อผู้รับ</div>
                  <div class="column">เลขห้อง</div>
                  <div class="column">บริษัทขนส่ง</div>
                  <div class="column">วันที่พัสดุมาถึง</div>
                  <div class="column">วันที่รับพัสดุ</div>
                  <div class="column">สถานะการรับพัสดุ</div>
                  <div class="column" v-if="isEmpOwner()"></div>
                </div>
              </div>
            </div>
          </article>
        </div>

        <div
          v-for="(parcel, index) in blogs"
          :class="[
            'card mt-3 p-4',
            parcel.status == 'not_received'
              ? 'has-background-danger-light'
              : '',
          ]"
          style="border: solid 1px #ff91a8"
          :key="parcel.id"
        >
          <div class="columns">
            <div class="column pt-3">{{ index + 1 }}</div>
            <div class="column pt-3">{{ parcel.p_name }}</div>
            <div class="column pt-3">{{ parcel.room_number }}</div>
            <div class="column pt-3">{{ parcel.transport_name }}</div>
            <div class="column pt-3">{{ parcel.sent_date.slice(0, 10) }}</div>
            <div class="column pt-3" v-if="parcel.receive_date != null">
              {{ parcel.receive_date.slice(0, 10) }}
            </div>
            <div
              class="column pt-3"
              v-if="parcel.receive_date == null || parcel.receive_date == ''"
            >
              -
            </div>
            <div class="column pt-3">{{ parcel.status }}</div>

            <div class="column pt-3" v-if="isEmpOwner(parcel)">
              <div class="level-centered pr-1">
                <span class="icon is-small" @click="editTask(parcel, index)">
                  <i class="fas fa-edit"></i>
                </span>
                <span
                  class="icon is-small ml-5"
                  @click="deleteTask(parcel, index)"
                >
                  <i class="fas fa-trash-alt"></i>
                </span>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div :class="['content mt-2', showAllParcel == 1 ? '' : 'is-hidden']">
        <div class="p-4" style="background-color: #d4abeb; color: white">
          <article class="media">
            <div class="media-content">
              <div class="content">
                <div class="columns" style="font-weight: bold">
                  <div class="column">ลำดับ</div>
                  <div class="column">ชื่อผู้รับ</div>
                  <div class="column">เลขห้อง</div>
                  <div class="column">บริษัทขนส่ง</div>
                  <div class="column">วันที่พัสดุมาถึง</div>
                  <div class="column">วันที่รับพัสดุ</div>
                  <div class="column">สถานะการรับพัสดุ</div>
                  <div class="column"></div>
                </div>
              </div>
            </div>
          </article>
        </div>

        <div
          v-for="(parcel, index) in filterMyParcel"
          :class="[
            'card mt-3 p-4',
            parcel.status == 'not_received'
              ? 'has-background-danger-light'
              : '',
          ]"
          style="border: solid 1px #d4abeb"
          :key="parcel.id"
        >
          <div class="columns">
            <div class="column pt-3">{{ index + 1 }}</div>
            <div class="column pt-3">{{ parcel.p_name }}</div>
            <div class="column pt-3">{{ parcel.room_number }}</div>
            <div class="column pt-3">{{ parcel.transport_name }}</div>
            <div class="column pt-3">{{ parcel.sent_date.slice(0, 10) }}</div>
            <div class="column pt-3" v-if="parcel.receive_date != null">
              {{ parcel.receive_date.slice(0, 10) }}
            </div>
            <div
              class="column pt-3"
              v-if="parcel.receive_date == null || parcel.receive_date == ''"
            >
              -
            </div>
            <div class="column pt-3">{{ parcel.status }}</div>

            <div class="column pt-3" v-if="isTenantOwner(parcel)">
              <span
                v-if="parcel.status == 'not_received'"
                :class="['button is-small is-rounded', 'is-info']"
                @click.prevent="confirmParcel(parcel, index)"
                >ยืนยันรับพัสดุ</span
              >
              <span
                v-if="parcel.status == 'received'"
                :class="['button is-small is-rounded', 'is-enabled']"
                
                >รับพัสดุแล้ว</span
              >
            </div>
          </div>
        </div>
      </div>

      <div class="modal" :class="{ 'is-active': showEditModal }">
        <div class="modal-background"></div>
        <div class="modal-card">
          <header class="modal-card-head has-background-info">
            <p class="modal-card-title has-text-centered has-text-white">
              แก้ไขรายการพัสดุ
            </p>
            <button
              class="delete"
              aria-label="close"
              @click="showEditModal = false"
            ></button>
          </header>

          <section class="modal-card-body">
            <div class="columns mr-6">
              <div class="column">
                <div class="field is-horizontal">
                  <div class="field-label is-normal">
                    <label class="label" style="width: 100px"
                      >ชื่อผู้รับ :</label
                    >
                  </div>
                  <div class="field-body">
                    <div class="field">
                      <div class="control">
                        <input
                          class="input"
                          type="text"
                          :class="{ 'is-danger': error.pName }"
                          name="editP_name"
                          v-model="editP_name"
                          placeholder="Recipient Name"
                        />
                        <span style="color: red">{{ error.editP_name }}</span>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div class="columns mr-6">
              <div class="column is-6">
                <div class="field is-horizontal">
                  <div class="field-label is-normal">
                    <label class="label" style="width: 100px">เลขห้อง :</label>
                  </div>

                  <div class="field-body">
                    <div class="field">
                      <div class="control">
                        <input
                          class="input"
                          type="text"
                          :class="{ 'is-danger': error.editRoom_number }"
                          name="editRoom_number"
                          v-model="editRoom_number"
                          placeholder="Room Number"
                        />
                        <span style="color: red">{{
                          error.editRoom_number
                        }}</span>
                      </div>
                    </div>
                  </div>
                </div>
              </div>

              <div class="column is-6">
                <div class="field is-horizontal">
                  <div class="field-label is-normal">
                    <label class="label" style="width: 100px"
                      >บริษัทขนส่ง :</label
                    >
                  </div>
                  <div class="field-body">
                    <div class="field">
                      <div class="control">
                        <input
                          class="input"
                          type="text"
                          :class="{ 'is-danger': error.editTransport_name }"
                          v-model="editTransport"
                          name="editTransport_name"
                          placeholder="Transport Name"
                        />
                        <span style="color: red">{{
                          error.editTransport
                        }}</span>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div class="columns mr-6">
              <div class="column is-6">
                <div class="field is-horizontal">
                  <div class="field-label is-normal">
                    <label class="label" style="width: 100px"
                      >วันที่พัสดุมาถึง :
                    </label>
                  </div>
                  <div class="field-body">
                    <div class="field">
                      <div class="control">
                        <input
                          style="min-width: 100px"
                          class="input"
                          type="date"
                          name="editSent_date"
                          v-model="editSent_date"
                          Due
                          date
                        />
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </section>

          <footer
            class="modal-card-foot has-background-white"
            style="padding-left: 35%"
          >
            <button
              class="button is-danger"
              type="submit"
              @click="saveEditParcel"
            >
              ยืนยัน
            </button>

            <button class="button" @click="showEditModal = false">
              ยกเลิก
            </button>
          </footer>
        </div>
      </div>

      <div class="modal" :class="{ 'is-active': showDeleteModal }">
        <div class="modal-background"></div>
        <div class="modal-card">
          <header class="modal-card-head has-background-info">
            <p class="modal-card-title has-text-centered has-text-white">
              Delete Parcel
            </p>
            <button
              class="delete"
              aria-label="close"
              @click="showDeleteModal = false"
            ></button>
          </header>

          <section class="modal-card-body">
            คุณแน่ใจนะ! ว่าต้องการลบรายการพัสดุที่ {{ deleteIndex }} ?
          </section>
          <footer class="modal-card-foot" style="padding-left: 35%">
            <button
              class="button is-danger"
              type="submit"
              @click="deleteParcel"
            >
              Confirm
            </button>

            <button class="button" @click="showDeleteModal = false">
              Cancel
            </button>
          </footer>
        </div>
      </div>

      <div class="modal" :class="{ 'is-active': showConfirmModal }">
        <div class="modal-background"></div>
        <div class="modal-card">
          <header class="modal-card-head has-background-info">
            <p class="modal-card-title has-text-centered has-text-white">
              Confirm Parcel
            </p>
            <button
             class="delete"
              aria-label="close"
              @click="showConfirmModal = false"
            ></button>
          </header>

          <section class="modal-card-body">
             ยืนยันได้รับพัสดุเรียบร้อยแล้ว
          </section>
          <footer class="modal-card-foot" style="padding-left: 35%">
            <button
              
              class="button is-danger"
              type="submit"
              @click="confirmParcelTenant"
            >
              Confirm
            </button>

            <button class="button" @click="showConfirmModal = false">
              Cancel
            </button>
          </footer>
        </div>
      </div>
    </section>
  </div>
</template>

<script>
import axios from "@/plugins/axios";

export default {
  name: "parcel",
  props: ["user"],
  data() {
    return {
      blogs: {},
      comments: [],
      images: [],
      error2: null,
      addListName: "",
      addListRoom: "",
      addListTransport: "",
      duedate: null,
      showAddModal: false,
      showEditModal: false,
      editParcelId: "",
      editIndex: "",
      editP_name: "",
      editRoom_number: "",
      editTransport: "",
      editSent_date: null,
      search: "",
      showDeleteModal: false,
      deleteTaskId: null,
      deleteIndex: "",
      deleteParcelId: "",
      showConfirmModal: false,
      confirmTaskId: null,
      receive_date: "",
      error: {
        taskName: "",
        listName: "",
        editlistName: "",
        editTaskName: "",
        select: "",
        pName: "",
        room_number: "",
        transport_name: "",
        editP_name: "",
        editRoom_number: "",
        editTransport: "",
        duedate: "",
      },
      showAllParcel: -1,
      filterMyParcel: {},
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
        .get(`http://localhost:5000/parcel`, {
          params: {
            search: this.search,
          },
        })
        .then((response) => {
          this.blogs = response.data;
          this.filterMyParcel = response.data.filter(
            (e) => e.tenant_id === this.user.id
          );
          /* for (var i = 0; i < this.blogs.length; i++) {
            var date = response.data[i].sent_date;
            this.blogs[i].sent_date = date.toLocaleString();
          } */
        })
        .catch((error) => {
          this.error2 = error.response.data.message;
        });
    },
    addList() {
      this.showAddModal = true;
    },
    showMyParcel() {
      this.showAllParcel = 1;
    },
    editTask(parcel, index) {
      this.showEditModal = true;
      this.editIndex = index;
      this.editParcelId = parcel.parcel_id;
      this.editP_name = parcel.p_name;
      this.editRoom_number = parcel.room_number;
      this.editTransport = parcel.transport_name;
      this.editSent_date = parcel.sent_date.slice(0, 10);
    },
    deleteTask(parcel, index) {
      this.showDeleteModal = true;
      this.deleteIndex = index;
      this.deleteParcelId = parcel.parcel_id;
    },
    confirmParcel(parcel, index) {
      this.showConfirmModal = true;
      this.confirmTaskId = parcel.parcel_id;
      this.confirmTaskIndex = index;
    },
    confirmParcelTenant() {
      const timestamp = new Date().toISOString().substring(0, 10);
      axios
        .put(`http://localhost:5000/confirmParcel/${this.confirmTaskId}`, {
          receive_date: `${timestamp}`,
          status: "received",
        })
        .then((response) => {
          this.showConfirmModal = false;
          this.blogs[this.confirmTaskIndex].receive_date =
            response.data.receive_date;
          this.blogs[this.confirmTaskIndex].status = response.data.status;
          this.filterMyParcel[this.confirmTaskIndex].receive_date =
            response.data.receive_date;
          this.filterMyParcel[this.confirmTaskIndex].status =
            response.data.status;
        })
        .catch((error) => {
          this.error = error.message;
        });
    },
    isTenantOwner() {
      if (this.user.role === "tenant") {
        return true;
      } else if (!this.user) {
        return false;
      }
      //return parcel.create_by_id === this.user.id;
    },
    isEmpOwner() {
      if (this.user.role === "admin") {
        return true;
      } else if (!this.user) {
        return false;
      }
      //return parcel.create_by_id === this.user.id;
    },
    confirmAddParcel() {
      if (this.addListName != "") {
        this.error.pName = "";
      } else if (this.addListName == "") {
        this.error.pName = "กรุณากรอกชื่อผู้รับ";
        return;
      }

      if (this.addListRoom != "") {
        this.error.room_number = "";
      } else if (this.addListRoom == "") {
        this.error.room_number = "กรุณากรอกเลขห้อง";
        return;
      }

      if (this.addListTransport != "") {
        this.error.transport_name = "";
      } else if (this.addListTransport == "") {
        this.error.transport_name = "กรุณากรอกชื่อขนส่ง";
        return;
      }

      if (this.duedate != null) {
        this.error.duedate = "";
      } else if (this.duedate == null || this.duedate == "") {
        this.error.duedate = "กรุณากรอกเลือกวันที่พัสดุมาส่ง";
        return;
      }

      axios
        .post(`http://localhost:5000/addParcel`, {
          p_name: this.addListName,
          room_number: this.addListRoom,
          transport_name: this.addListTransport,
          sent_date: this.duedate,
        })
        .then((response) => {
          this.blogs.push(response.data);
          this.showAddModal = false;
          this.addListName = "";
          this.addListRoom = "";
          this.addListTransport = "";
          this.duedate = null;
        })
        .catch((error) => {
          this.error = error.message;
        });
    },
    cancleAddModal() {
      this.showAddModal = false;
      this.addListName = "";
      this.addListRoom = "";
      this.addListTransport = "";
      this.duedate = null;
      this.error.pName = "";
      this.error.transport_name = "";
      this.error.room_number = "";
      this.error.duedate = "";
    },
    saveEditParcel() {
      axios
        .put(`http://localhost:5000/updateParcel/${this.editParcelId}`, {
          p_name: this.editP_name,
          room_number: this.editRoom_number,
          transport_name: this.editTransport,
          sent_date: this.editSent_date,
        })
        .then((response) => {
          this.showEditModal = false;
          this.blogs[this.editIndex].p_name = response.data.p_name;
          this.blogs[this.editIndex].room_number = response.data.room_number;
          this.blogs[this.editIndex].transport_name =
            response.data.transport_name;
          this.blogs[this.editIndex].sent_date = response.data.sent_date;
        })
        .catch((error) => {
          this.error = error.message;
        });
    },
    deleteParcel() {
      //const result = confirm(`Are you sure you want to delete this comment`);

      axios
        .delete(`http://localhost:5000/parcel/${this.deleteParcelId}`)
        .then((response) => {
          this.blogs.splice(this.deleteIndex, 1);
          this.showDeleteModal = false;
        })
        .catch((error) => {
          this.error = error.message;
        });
    },
  },
  computed: {
    /*  filteredList() {
      return this.blogs.filter((post) => {
        return post.room_id.toLowerCase().includes(this.search.toLowerCase());
      });
    } */
  },
  watch: {
    newTaskName(newVal, oldVal) {
      if (newVal != "") {
        this.error.taskName = "";
      }
    },
    addListName(newVal, oldVal) {
      if (newVal != "") {
        this.error.pName = "";
      }
    },
    addListRoom(newVal, oldVal) {
      if (newVal != "") {
        this.error.room_number = "";
      }
    },
    addListTransport(newVal, oldVal) {
      if (newVal != "") {
        this.error.transport_name = "";
      }
    },
    duedate(newVal, oldVal) {
      if (newVal != null || newVal != "") {
        this.error.duedate = "";
      }
    },
  },
};
</script>