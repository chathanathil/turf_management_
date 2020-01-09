const mongoose = require("mongoose");
const Schema = mongoose.Schema;

// Create Schema
const MatchSchema = new Schema({
  user: {
    type: Schema.Types.ObjectId,
    ref: "users"
  },
  date: {
    type: String
  },
  time: {
    type: String
  },
  team: {
    type: String
  },
  name: {
    type: String
  },
  phone: {
    type: String
  },
  createdBy: {
    type: String
  },
  amount: {
    type: Number
  }
});

module.exports = Match = mongoose.model("matchs", MatchSchema);
