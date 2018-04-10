require("pg")

class SpaceCowboy

  attr_reader :id
  attr_accessor :name, :species, :bounty_value, :danger_level

  def initialize(details)
    @id = details["id"].to_i
    @name = details["name"]
    @species = details["species"]
    @bounty_value = details["bounty_value"].to_i
    @danger_level = details["danger_level"]
  end

  def save()
    db = PG.connect({dbname: "space_cowboys", host: "localhost"})
    sql = "INSERT INTO space_cowboys(name, species, bounty_value, danger_level) VALUES ($1, $2, $3, $4) RETURNING id"
    values = [@name, @species, @bounty_value, @danger_level]
    db.prepare("save", sql)
    result = db.exec_prepared("save", values)
    db.close()
    @id = result[0]["id"].to_i
  end

  def update()
    db = PG.connect({dbname:"space_cowboys", host: "localhost"})
    sql = "UPDATE space_cowboys SET (name, species, bounty_value, danger_level) = ($1, $2, $3, $4) WHERE id = $5"
    values = [@name, @species, @bounty_value, @danger_level, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

  def delete()
    db = PG.connect({dbname: "space_cowboys", host:"localhost"})
    sql = "DELETE FROM space_cowboys WHERE id = $1"
    values = [@id]
    db.prepare("delete", sql)
    db.exec_prepared("delete", values)
    db.close()
  end

  def self.all()
    db = PG.connect({dbname: "space_cowboys", host: "localhost"})
    sql = "SELECT * FROM space_cowboys"
    db.prepare("all", sql)
    cowboys = db.exec_prepared("all")
    db.close()
    return cowboys.map{|cowboy| SpaceCowboy.new(cowboy)}
  end

  def self.delete_all()
    db = PG.connect({dbname: "space_cowboys", host: "localhost"})
    sql = "DELETE FROM space_cowboys"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end

  def self.find_by_name(name)
    self.all().find {|cowboy| cowboy.name == name}
  end

  def self.find_by_id(id)
    self.all().find {|cowboy| cowboy.id == id}
  end

  def self.find_highest_bounty()
    self.all().max {|cowboy| cowboy.bounty_value}
  end

end
