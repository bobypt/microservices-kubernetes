'use strict';

const express = require('express');
const uuidv1 = require('uuid/v1');

// Constants
const PORT = 8080;
const ID = uuidv1();
const CONTEXT_BASE = "/api/v1/orderapi"

// App
const app = express();

//logging middleware
app.use(function (req, res, next) {
  console.log(req.method + " " + req.url);
  next();
});


app.get(CONTEXT_BASE+'/health', (req, res) => {
  res.json({instanceId : ID, version: "1", status: "OK"});
});

app.get(CONTEXT_BASE+'/orders/:id', (req, res) => {
  res.json({id: req.params.id, description: "Order for Name"+ req.params.id});
});


app.listen(PORT, () => console.log('App listening on port ' + PORT))