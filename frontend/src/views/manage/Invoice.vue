<template>
  <div class="container is-widescreen">
    <section class="section">
      <div class="box is-fullwidth">
        <div class="columns">
          <div class="column is-2">
            <div
              class="box is-centered"
              style="background-color: #97b9ca; width: 150px; height: 120px"
            >
              <figure class="image is-64x64 my-auto ml-5 mr-3">
                <img
                  src="https://www.img.in.th/images/e44ec3a34de3558d4b0fdab7af698364.png"
                />
              </figure>
              <p class="has-text-centered" style="font-weight: bold">บิล</p>
            </div>
          </div>

          <div class="column is-10">
            <div class="colummns">
              <div class="column p-4" style="background-color: #fab15c; color: white">
                ห้อง XX ชื่อเดือน/ปี
                <button
              class="delete is-pulled-right"
              aria-label="close"
              @click="showInvoice"
            >
            </button>
              </div>
              
            </div>
            <div class="columns">
              <div class="column is-6">
                <div
                  class="box ml-1 mt-5 p-5"
                  style="border: solid 2px #e0e0de"
                >
                  <div class="field mb-5">
                    <label class="label">รายละเอียดหัวบิล</label>
                    <label class="label">ชื่อนามสกุล</label>
                    <label class="label">โทร XXXXXXXXXXXx</label>
                  </div>

                  <button class="button is-info">แก้ไขหัวบิล</button>
                </div>
              </div>
              <div class="column is-6">
                <div
                  class="box ml-4 mb-2 mt-5 mr-2 pl-3 pr-3 pb-1 pt-3"
                  style="border: solid 2px #e0e0de"
                >
                  <div class="level mb-2">
                    <label class="label">สถานะบิล</label>
                    <label class="label">XXX</label>
                  </div>
                </div>
                <div
                  class="card ml-4 mt-0 mr-2 pl-3 pr-3 pb-0 pt-3"
                  style="border: solid 2px #e0e0de"
                >
                  <header class="card-header">
                    <p class="card-header-title">บิลจะถูกส่งไปให้ผู้เช่า</p>
                  </header>
                  <div class="card-content">
                    <div class="content">XXXXXXXX</div>
                  </div>
                </div>
              </div>
            </div>

            <div class="box is-12" style="border: solid 2px #e0e0de">
              <table class="table is-fullwidth has-text-left">
                <thead>
                  <tr
                    class="has-text-centered is-rounded"
                    style="border-bottom: solid 2px #e0e0de"
                  >
                    <th class="column-8 p-5">รายการ</th>
                    <th class="column-4 p-5">จำนวนเงิน(บาท)</th>
                  </tr>
                </thead>
                <tbody style="font-weight: bold">
                  <tr>
                    <td class="pt-3 pl-5 pt-2">
                      ค่าเช่าห้อง(Room rate) เลขห้อง เดือน ลำดับที่ของเดือน/ปี
                      <button
                        class="button is-small is-warning is-pulled-right"
                      >
                        แก้ไข
                      </button>
                    </td>
                    <td class="pt-3 pl-5">
                      <input
                        type="text"
                        class="input"
                        placeholder=""
                        disabled
                      />
                    </td>
                  </tr>
                  <tr>
                    <td class="pt-3 pl-5">
                      ค่าน้ำ(Water rate) เดือน ลำดับที่ของเดือน/ปี (0 - 0 =
                      ยูนิต)
                    </td>
                    <td class="pt-3 pl-5">
                      <input
                        type="text"
                        class="input"
                        placeholder=""
                        disabled
                      />
                    </td>
                  </tr>
                  <tr>
                    <td class="pt-3 pl-5">
                      ค่าไฟฟ้า(Electrical rate) เดือน ลำดับที่ของเดือน/ปี (9000
                      - 8333 = 667 ยูนิต)
                    </td>
                    <td class="pt-3 pl-5">
                      <input
                        type="text"
                        class="input"
                        placeholder=""
                        disabled
                      />
                    </td>
                  </tr>
                  <tr>
                    <td class="pt-3 pl-5">
                      ค่าส่วนกลาง(dorm free)
                      <button class="button is-small is-danger is-pulled-right">
                        แก้ไข
                      </button>
                    </td>
                    <td class="pt-3 pl-5">
                      <input
                        type="text"
                        class="input"
                        placeholder=""
                        disabled
                      />
                    </td>
                  </tr>
                  <tr>
                    <td class="pt-3 pl-5">เงินรวมก่อนภาษี</td>
                    <td class="pt-3 pl-5">
                      <input
                        type="text"
                        class="input"
                        placeholder=""
                        disabled
                      />
                    </td>
                  </tr>
                  <tr>
                    <td class="pt-3 pl-5">ภาษีมูลค่าเพิ่ม 7 %</td>
                    <td class="pt-3 pl-5">
                      <input
                        type="text"
                        class="input"
                        placeholder=""
                        disabled
                      />
                    </td>
                  </tr>
                  <tr>
                    <td class="pt-3 pl-5">รวมสุทธิ</td>
                    <td class="pt-3 pl-5">
                      <input
                        type="text"
                        class="input"
                        placeholder=""
                        disabled
                      />
                    </td>
                  </tr>
                </tbody>
              </table>
            </div>

            <div class="columns">
              <div class="column has-text-right">
                <button class="button is-success mt-3">เพิ่มส่วนลด</button>
                <button class="button is-warning mt-3 ml-3">เพิ่มรายการ</button>
              </div>
            </div>
            <div class="box" style="border: solid 2px #e0e0de">
              <div class="level">
                <label class="label" style="width: 100px">หมายเหตุ : </label>
                <input type="text" class="input" placeholder="" />
              </div>
            </div>
            <div class="columns">
              <div class="column has-text-right">
                <button
                  class="button is-primary is-normal mt-3"
                  style="width: 10%"
                >
                  <span class="icon mr-3">
                    <i class="fas fa-envelope-open-text"></i> </span
                  >ส่งบิล
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script>
import axios from "@/plugins/axios";

export default {
  name: "invoice",
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
  created() {},
  watch: {},
  methods: {
    showInvoice() {
      this.$router.push({name: 'manageinvoice'});
    }
  },
};
</script>