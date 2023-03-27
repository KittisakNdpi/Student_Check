const mysql = require('mysql2');
const express = require('express');
const bodyParser = require('body-parser');
const short = require('short-uuid');
const app = express();
const port = 3000;
const con = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  database: 'sdcs'
});
app.use(bodyParser.json());

//regis student
app.post('/student/register', function (req, res) {
  con.query(`INSERT INTO sdcs.tab_student
            (id, username, password, code, name, lastname, branchId, email, createAt, updateAt)
            VALUES(
              '${short.generate()}', 
              '${req.body.username}', 
              '${req.body.password}', 
              '${req.body.code}', 
              '${req.body.name}', 
              '${req.body.lastname}', 
              '${req.body.branchId}', 
              '${req.body.email}',
              CURRENT_TIMESTAMP(), 
              CURRENT_TIMESTAMP()
            );
  `, (err, result) => {
    if (err) {
      res.status(400).json({
        code: err.code,
        message: err.message
      })
    } else {
      res.status(200).json({
        "status": "sucess",
        "data": result
      }).send()
    }
  })
})

//update student
app.post('/student/update', (req, res) => {
  con.query(``, (err, result) => {
    if (err) {
      res.status(400).json({
        code: err.code,
        message: err.message
      })
    } else {
      res.status(200).json({
        "status": "sucess",
        "data": result
      }).send()
    }
  })
})

//delete student
app.delete('/student/update/', (req, res) => {
  con.query(``, (err, result) => {
    if (err) {
      res.status(400).json({
        code: err.code,
        message: err.message
      })
    } else {
      res.status(200).json({
        "status": "sucess",
        "data": result
      }).send()
    }
  })
})

app.listen(port, () => { console.log(" start index.js on port", port) });


