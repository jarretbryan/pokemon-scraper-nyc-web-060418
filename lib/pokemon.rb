require 'pry'


class Pokemon

  attr_accessor :name, :type, :db, :id, :hp

  #@@all = []

  def initialize(props = {})
    @name = props['name']
    @type = props['type']
    @id = props['id']
    @hp = nil
    # @hp = nil
  end

  def self.all
    sql_string = <<-SQL_STRING
      select *
      from pokemon
    SQL_STRING

    array_of_hashes_from_the_database = @db.execute(sql_string)
    array_of_hashes_from_the_database.map do |hashy_tweet|
      Pokemon.new(hashy_tweet)
    end
  end

  def self.save(name, type, db)
    sql_string = <<-FOO
    INSERT INTO pokemon (name, type)
    VALUES (?, ?)
    FOO
    db.execute(sql_string, name, type)
  end

  def self.find(id_num, db)
    sql_string = <<-FOO
    SELECT *
    FROM pokemon
    WHERE id = ?
    FOO
    arr = db.execute(sql_string, id_num)
    Pokemon.new("id" => arr.flatten[0], "name" => arr.flatten[1], "type" => arr.flatten[2], "hp" =>60)
    # binding.pry
  end



end
