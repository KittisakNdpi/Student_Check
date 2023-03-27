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

app.post('/student/login', (req, res) => {
  con.query(`select * from sdcs.tab_student where username = '${req.body.username}' and password = '${req.body.password}'`, (err, result) => {
    if (err) {
      res.status(400).json({
        code: err.code,
        message: err.message
      })
    } else {
      if (result.length > 0) {
        res.status(200).json({
          "status": "sucess",
          "data": result
        }).send()
      } else {
        res.status(200).json({
          "status": "sucess",
          "data": []
        }).send()
      }
    }
  })
})

app.get('/student/register/:id', (req, res) => {
  con.query(`select * from sdcs.tab_student where id = '${req.params.id}'`, (err, result) => {
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

//regis student
app.post('/student/register', (req, res) => {
  con.query(`select * from sdcs.tab_student where username = '${req.body.username}'`, (err, result) => {
    if (err) {
      res.status(400).json({
        code: err.code,
        message: err.message
      })
    } else {
      if (result.length() > 0) {
        res.status(200).json({
          "status": "sucess",
          "data": [],
          "message": "Username duplicate."
        }).send()
      } else {
        con.query(`
        INSERT INTO sdcs.tab_student
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
      }
    }
  })
})

//update student
app.put('/student/register/:id', (req, res) => {
  con.query(`
              UPDATE sdcs.tab_student
              SET name = '${req.body.name}', lastname = '${req.body.lastname}', email = '${req.body.email}'
              WHERE id = '${req.params.id}'
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
app.delete('/student/register/:id', (req, res) => {
  con.query(`
              DELTEE sdcs.tab_student WHERE id = '${req.params.id}'
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

app.listen(port, () => { console.log(" start index.js on port", port) });


