const express = require("express");
const router = express.Router();
const passport = require("passport");
const dateFormat = require("dateformat");

// Test
router.get("/test", (req, res) => {
  res.json("Match works");
});

// Load match schema
const Match = require("../../models/Match");

// Load Cancel schema
const Cancel = require("../../models/Cancel");

router.post(
  "/add",
  passport.authenticate("jwt", { session: false }),
  (req, res) => {
    const newMatch = new Match({
      user: req.user.id,
      date: req.body.date,
      time: req.body.time,
      team: req.body.team,
      name: req.body.name,
      phone: req.body.phone,
      createdBy: req.body.createdBy
    });
    Match.findOne({ user: req.user.id })
      .then(student => {
        new Match(newMatch)
          .save()
          .then(stu => res.json(stu))
          .catch(err => res.json(err));
      })
      .catch(err => res.json(err));
  }
);

// Add amount
router.post(
  "/addAmount/:id",
  passport.authenticate("jwt", { session: false }),
  (req, res) => {
    Match.findOne({
      $and: [{ user: req.user.id }, { _id: req.params.id }]
    })
      .then(match => {
        match.amount = req.body.amount;
        match.save().then(match => res.json(match));
      })
      .catch(err => res.json(err));
  }
);

// Get turf booking by date
router.get(
  "/turf/:date",
  passport.authenticate("jwt", { session: false }),
  (req, res) => {
    Match.find({
      $and: [
        { user: req.user.id },
        {
          date: req.params.date
        },
        {
          $or: [
            {
              team: "7s"
            },
            {
              team: "5s A"
            },
            {
              team: "5s B"
            }
          ]
        }
      ]
    })

      .then(match => {
        if (match.length === 0) {
          res.status(404).json({ msg: "No match on this date" });
        }
        res.json(match);
      })
      .catch(err => res.status(200).json(err));
  }
);

// Get pool booking by date

router.get(
  "/pool/:date",
  passport.authenticate("jwt", { session: false }),
  (req, res) => {
    Match.find({
      $and: [
        { user: req.user.id },
        {
          date: req.params.date
        },
        {
          team: "Pool"
        }
      ]
    })

      .then(match => {
        if (match.length === 0) {
          res.status(404).json({ msg: "No match on this date" });
        }
        res.json(match);
      })
      .catch(err => res.status(200).json(err));
  }
);

// Get slots
router.get(
  "/:date/:time",
  passport.authenticate("jwt", { session: false }),
  (req, res) => {
    Match.find({
      $and: [
        { user: req.user.id },
        { date: req.params.date },
        { time: req.params.time }
      ]
    })
      .then(slot => {
        if (slot.length === 1) {
          if (slot[0].team === "7s") {
            res.json({ 1: "Pool" });
          } else if (slot[0].team === "5s A") {
            res.json({ 1: "5s B", 2: "Pool" });
          } else if (slot[0].team === "5s B") {
            res.json({ 1: "5s A", 2: "Pool" });
          } else {
            res.json({ 1: "7s", 2: "5s A", 3: "5s B" });
          }
        } else if (slot.length === 2) {
          if (
            (slot[0].team === "7s" && slot[1].team === "Pool") ||
            (slot[0].team === "Pool" && slot[1].team === "7s")
          ) {
            res.json({ msg: "No available slot in this time" });
          } else if (
            (slot[0].team === "5s A" && slot[1].team === "Pool") ||
            (slot[0].team === "Pool" && slot[1].team === "5s A")
          ) {
            res.json({ 1: "5s B" });
          } else if (
            (slot[0].team === "5s B" && slot[1].team === "Pool") ||
            (slot[0].team === "Pool" && slot[1].team === "5s B")
          ) {
            res.json({ 1: "5s A" });
          } else if (
            (slot[0].team === "5s A" && slot[1].team === "5s B") ||
            (slot[0].team === "5s B" && slot[1].team === "5s A")
          ) {
            res.json({ 1: "Pool" });
          } else {
            res.json({ 1: "Pool" }); //errr
          }
        } else if (slot.length === 3) {
          res.json({ msg: "No available slot in this time" });
        } else {
          res.json({ 1: "7s", 2: "5s A", 3: "5s B", 4: "Pool" });
        }
      })
      .catch(err => res.json(err));
  }
);

module.exports = router;
