const express = require("express");
const router = express.Router();
const jwt = require("jsonwebtoken");
const keys = require("../../config/keys");

// Test
router.get("/test", (req, res) => {
  res.json("User works");
});

// Load User model
const User = require("../../models/User");

// Load input validation
const validateLoginInput = require("../../validation/login");

// Login
router.post("/login", (req, res) => {
  const { errors, isValid } = validateLoginInput(req.body);
  if (!isValid) {
    return res.status(400).json(errors);
  }
  const username = req.body.username;
  const password = req.body.password;
  User.findOne({ username })
    .then(user => {
      if (!user) {
        errors.username = "User not found";
        res.status(404).json(errors);
      } else if (password === user.password) {
        const payload = { id: user.id, username: user.username };
        jwt.sign(
          payload,
          keys.secretOrKey,
          { expiresIn: 6.307e7 },
          (err, token) => {
            res.json({
              success: true,
              token: "Bearer " + token
            });
          }
        );
      } else {
        errors.password = "Incorrect password";
        return res.status(400).json(errors);
      }
    })
    .catch(err => {
      res.status(404).json(err);
    });
});

module.exports = router;
