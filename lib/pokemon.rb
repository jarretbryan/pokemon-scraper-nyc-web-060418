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
    sql_string = <<-SQL_STRING
    INSERT INTO pokemon (name, type)
    VALUES (?, ?)
    SQL_STRING
    db.execute(sql_string, name, type)
  end

  def self.find(id_num, db)
    sql_string = <<-SQL_STRING
    SELECT *
    FROM pokemon
    WHERE id = ?
    SQL_STRING
    arr = db.execute(sql_string, id_num)
    pkmn = Pokemon.new(id: arr.flatten[0], name: arr.flatten[1], type: arr.flatten[2], hp: arr.flatten[3])
    # pkmn.hp = 60
    # pkmn
    # binding.pry
  end

  def alter_hp(int, db)
    sql_string = <<-SQL_STRING
    UPDATE pokemon
    SET hp = ?
    WHERE id = ?
    SQL_STRING

    db.execute(sql_string, int, self.id)

  end



end
