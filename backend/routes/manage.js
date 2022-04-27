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

router.get("/manage", isLoggedIn, async function (req, res, next) {
    const conn = await pool.getConnection()
    await conn.beginTransaction();

    try {
        const [rows2, fields2] = await conn.query(
            'SELECT * FROM `users` WHERE `id` = ?',
            [req.user.id]
        )
        await conn.commit()
        return res.json({blog: rows2[0], error: null})
    } catch (err) {
        await conn.rollback();
        return res.status(500).json(err)
    } finally {
        console.log('finally')
        conn.release();
    }
});

router.put("/updateProfile", isLoggedIn,async function (req, res, next) {
  // Your code here
  console.log(req.body)
  const name = req.body.name
  const surname = req.body.surname
  const tel1 = req.body.tel1
  const tel2 = req.body.tel2

  //transaction
  const conn = await pool.getConnection()

  await conn.beginTransaction()

  try {
    const [rows1, fields1] = await conn.query("UPDATE users SET first_name=?, last_name=?, mobile=?, phone2=? WHERE id=?", [
      name, surname, tel1, tel2, req.user.id,
    ]);

    //console.log(blogs.insertId)
    //console.log(file.path)
    res.json({ name: name,
    surname: surname,
    tel1: tel1,
    tel2: tel2,})
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

router.put("/updateEmail", isLoggedIn,async function (req, res, next) {
  // Your code here
  console.log(req.body)
  const email = req.body.email

  //transaction
  const conn = await pool.getConnection()

  await conn.beginTransaction()

  try {
    const [rows1, fields1] = await conn.query("UPDATE users SET email=? WHERE id=?", [
      email, req.user.id,
    ]);

    //console.log(blogs.insertId)
    //console.log(file.path)
    res.json({ email: email})
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

exports.router = router;
