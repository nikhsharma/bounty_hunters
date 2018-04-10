require("pry-byebug")
require_relative("./models/space_cowboy.rb")

SpaceCowboy.delete_all()

cowboy1 = SpaceCowboy.new({
  "name" => "Han Solo",
  "species" => "human",
  "bounty_value" => 10000,
  "danger_level" => "medium"
  })

  cowboy1.save()

  cowboy2 = SpaceCowboy.new({
    "name" => "Boba Fett",
    "species" => "unkown",
    "bounty_value" => 30000,
    "danger_level" => "high"
    })

  cowboy2.save()


  binding.pry
  nil
