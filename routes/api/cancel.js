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

// Cancel match
router.post(
  "/add/:id",
  passport.authenticate("jwt", { session: false }),
  (req, res) => {
    Match.findById(req.params.id)
      .then(match => {
        const cancelesMatch = {};
        (cancelesMatch.user = match.user),
          (cancelesMatch.date = match.date),
          (cancelesMatch.time = match.time),
          (cancelesMatch.team = match.team),
          (cancelesMatch.name = match.name),
          (cancelesMatch.phone = match.phone),
          (cancelesMatch.createdBy = match.createdBy);

        new Cancel(cancelesMatch)
          .save()
          .then(m => res.json(m))
          .catch(err => res.json(err));
        match.remove();
      })
      .catch(err => res.json(err));
  }
);

// Get canceled turf booking by date
router.get(
  "/turf/:date",
  passport.authenticate("jwt", { session: false }),
  (req, res) => {
    Cancel.find({
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
        // if (match.length === 0) {
        //   res.status(404).json({ msg: "No match on this date" });
        // }
        res.json(match);
      })
      .catch(err => res.status(200).json(err));
  }
);

// Get canceled pool booking by date
router.get(
  "/pool/:date",
  passport.authenticate("jwt", { session: false }),
  (req, res) => {
    Cancel.find({
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
        // if (match.length === 0) {
        //   res.status(404).json({ msg: "No match on this date" });
        // }
        res.json(match);
      })
      .catch(err => res.status(200).json(err));
  }
);

module.exports = router;
