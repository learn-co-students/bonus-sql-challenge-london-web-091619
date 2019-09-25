# Parse the CSV and seed the database here! Run 'ruby db/seed' to execute this code.
require 'csv'
require 'pry'
require 'sqlite3'

seed = CSV.read("/Users/timgolding/Development/code/bonus-sql-challenge-london-web-091619/daily_show_guests.csv")
db = SQLite3::Database.new 'the_daily_show.db'

def create_new_database(db)
    db.execute "DROP TABLE show"
    db.execute "DROP TABLE famous_people"
    db.execute "CREATE TABLE show(id INTEGER PRIMARY KEY, topic TEXT, date TEXT, year INTEGER, famous_people_id INTEGER)"
    db.execute "CREATE TABLE famous_people(id INTEGER PRIMARY KEY, guest TEXT, job TEXT)"
end
    
class PopulateDatabase
    attr_reader :db, :show, :famous_people, :seed
    def initialize(seed, db)
        @seed = seed
        @db = db
        @famous_people = []
        @show = []
        self.get_seed
    end

    def populate_show
        show.each do |row|
            rowstring = "INSERT INTO show (topic, date, year, famous_people_id) VALUES ('#{row[0]}','#{row[1]}',#{row[2]}, #{row[3]})"
            db.execute rowstring
        end
    end

    def populate_famous_people
        famous_people.uniq.each do |row|
            rowstring = 'INSERT INTO famous_people (guest, job) VALUES ("' + row[0] +  '","' + row[1] + '")'
            db.execute rowstring
        end
    end

    def get_seed
        seed.shift
        seed.each do |row|
            row.each{|value| value.gsub! /"/, '' }
            person = [row[4],row[1]]
            famous_people << person
            index = famous_people.index(person)
            famous_people.uniq!
            
            show << [row[3],row[2],row[0], index]
        end
        self.populate_show
        self.populate_famous_people
    end
end


create_new_database(db)
db1 = PopulateDatabase.new(seed, db)
