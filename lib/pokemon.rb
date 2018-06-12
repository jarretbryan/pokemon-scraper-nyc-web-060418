require 'pry'


class Pokemon

  attr_accessor :name, :type, :db, :id, :hp

  #@@all = []

  def initialize(props)
    props.each {|key, value| self.send(("#{key}="), value)}
    # @hp = nil
  end

  def self.all
    sql_string = <<-SQL_STRING
      select *
      from pokemon
    SQL_STRING

    array_of_hashes_from_the_database = @db.execute(sql_string)
    array_of_hashes_from_the_database.map do |pkmn|
      Pokemon.new(pkmn)
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
    pkmn = Pokemon.new(id: arr.flatten[0], name: arr.flatten[1], type: arr.flatten[2])
    # pkmn.hp = 60
    # pkmn
    # binding.pry
  end



end
