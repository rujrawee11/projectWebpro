const express = require("express")

const app = express();
const cors = require('cors')
const { logger } = require('./middlewares')
app.use(logger)
app.use(cors())

// Statics
app.use(express.static('static'))
app.use(express.json()) // for parsing application/json
app.use(express.urlencoded({ extended: true })) // for parsing application/x-www-form-urlencoded

// routers
const indexRouter = require('./routes/index')
const blogRouter = require('./routes/blog')
const commentRouter = require('./routes/comment')
const imageRouter = require('./routes/image')
const userRouter = require('./routes/user')
const manageRouter = require('./routes/manage')
const parcelRouter = require('./routes/parcel')

app.use(indexRouter.router)
app.use(blogRouter.router)
app.use(commentRouter.router)
app.use(imageRouter.router)
app.use(userRouter.router)
app.use(manageRouter.router)
app.use(parcelRouter.router)

/* async function logger (req, res, next) {
  const timestamp = new Date().toISOString().substring(0, 19)
  console.log(`${timestamp} | ${req.method}: ${req.originalUrl}`)
  next()
}

module.exports = {
  logger
} */
app.listen(5000, () => {
  console.log(`Example app listening at http://localhost:5000`)
})