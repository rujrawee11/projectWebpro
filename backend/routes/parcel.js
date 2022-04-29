const express = require("express");
const path = require("path");
const pool = require("../config");
const fs = require("fs");
const multer = require("multer");
var bodyParser = require('body-parser');
const { isLoggedIn } = require('../middlewares')


router = express.Router();

const blogOwner = async (req, res, next) => {
  if (req.user.role === 'admin') {
    return next()
  }
  const [[blog]] = await pool.query('SELECT * FROM blogs WHERE id=?', [req.params.id])

  if (blog.create_by_id !== req.user.id) {
    return res.status(403).send('You do not have permission to perform this action')
  }

  next()
}

const parcelAdmin = async (req, res, next) => {
  if (req.user.role === 'admin') {
    return next()
  }

  next()
}

const parcelTenant = async (req, res, next) => {
  const [[parcel]] = await pool.query('SELECT * FROM parcel WHERE parcel_id=?', [req.params.parcelId])

  if (parcel.tenant_id !== req.user.id) {
    return res.status(403).send('You do not have permission to perform this action')
  }

  next()
}
// SET STORAGE
const storage = multer.diskStorage({
  destination: function (req, file, callback) {
    callback(null, "./static/uploads");
  },
  filename: function (req, file, callback) {
    callback(
      null,
      file.fieldname + "-" + Date.now() + path.extname(file.originalname)
    );
  },
});
const upload = multer({ storage: storage });

/* router.get("/manage", async function (req, res, next) {
  const [rows, fields] = await pool.query('SELECT * FROM users WHERE id = ?', [req.params.id])
  res.render("manage_account", { data: JSON.stringify(rows) })

}) */
  
router.get("/parcel", async function (req, res, next) {
  /* const conn = await pool.getConnection()
    await conn.beginTransaction();

    try {
        const [rows2, fields2] = await conn.query(
            'SELECT * FROM `parcel`'
        )
        await conn.commit()
        return res.json({blog: rows2, 
          error: null})
    } catch (err) {
        await conn.rollback();
        return res.status(500).json(err)
    } finally {
        console.log('finally')
        conn.release();
    } */

    try {
      const search = req.query.search || ''
      let sql = 'SELECT * FROM `parcel`'
      let cond = []
  
      if (search.length > 0) {
        sql = 'SELECT a.* FROM `parcel` AS a WHERE a.room_number LIKE ? OR a.p_name LIKE ?;'
        cond = [`%${search}%`, `%${search}%`]
      }
      const [rows, fields] = await pool.query(sql, cond);
      return res.json(rows);
    } catch (err) {
      return res.status(500).json(err)
    }

});

router.post("/addParcel", isLoggedIn, parcelAdmin, async function (req, res, next) {
  const p_name = req.body.p_name;
  const room_number = req.body.room_number;
  const transport_name = req.body.transport_name;
  const sent_date = req.body.sent_date;

  // Begin transaction
  const conn = await pool.getConnection();
  await conn.beginTransaction();

  try {
    const [rows, fields] = await conn.query(
      'SELECT * FROM `users` WHERE `room_id` = ?',
      [room_number]
  )
    const [rows1, fields1] = await conn.query(
      'INSERT INTO `parcel` (`p_name`, `room_number`, `transport_name`, `sent_date`, `tenant_id`) VALUES (?, ?, ?, ?, ?)',
      [p_name, room_number, transport_name, sent_date, rows[0].id]
  )
    const [rows2, fields2] = await conn.query(
      'SELECT * FROM `parcel` WHERE `parcel_id` = ?',
      [rows1.insertId]
  )
    await conn.commit()
    return res.json(rows2[0])
  } catch (err) {
    await conn.rollback();
     res.status(400).json('ไม่มีหมายเลขห้องนี้ กรุณากรอกใหม่อีกครั้ง'.toString())
  } finally {
    conn.release();
  }
});

router.put('/updateParcel/:parcelId', isLoggedIn, parcelAdmin, async function (req, res, next) {
  const p_name = req.body.p_name
  const room_number = req.body.room_number
  const transport_name = req.body.transport_name
  const sent_date = req.body.sent_date
  const conn = await pool.getConnection();
  await conn.beginTransaction();

  try {
      const [rows1, fields1] = await conn.query(
          'UPDATE parcel SET p_name=?, room_number=?, transport_name=?, sent_date=? WHERE parcel_id=?', [p_name, room_number, transport_name, sent_date, req.params.parcelId]
      )
      
      res.json({ p_name: p_name, room_number: room_number, transport_name: transport_name, sent_date: sent_date})
      await conn.commit()
    } catch (err) {
      console.log(err)
      await conn.rollback()
      return next(error)
    } finally {
      console.log('finally')
      await conn.release()
    }
});

router.put('/confirmParcel/:parcelId', isLoggedIn, parcelTenant,async function (req, res, next) {
  const receive_date = req.body.receive_date
  const status = req.body.status

  const conn = await pool.getConnection();
  await conn.beginTransaction();

  try {
      const [rows1, fields1] = await conn.query(
          'UPDATE parcel SET receive_date=?, status=? WHERE parcel_id=?', [receive_date, status, req.params.parcelId]
      )
      
      res.json({ receive_date: receive_date, status: status})
      await conn.commit()
    } catch (err) {
      console.log(err)
      await conn.rollback()
      return next(error)
    } finally {
      console.log('finally')
      await conn.release()
    }
});

router.delete('/parcel/:parcelId', isLoggedIn, parcelAdmin, async function (req, res, next) {
  try {
      const [rows1, fields1] = await pool.query(
          'DELETE FROM parcel WHERE parcel_id=?', [req.params.parcelId]
      )
      res.json("success")
  } catch (error) {
      res.status(500).json(error)
  }
});
exports.router = router;
