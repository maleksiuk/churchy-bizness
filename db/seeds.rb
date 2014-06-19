# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# In order to put this in a public repo I have replaced real data with fake data.  The real data is safely in prod anyway.

User.create(:username => 'dustin', :first_name => "Dustin", :last_name => "Robertson", :honorific => "Brother", :email => "dustin@fakeemail.com", :phone_number => '(555) 555-5555', :password => 'password', :admin => true)

jturkeybum = User.create(:username => 'jturkeybum', :first_name => "Jimmy", :last_name => "Turkeybum", :honorific => "Brother", :email => "jturkeybum@fakeemail.com", :phone_number => '(555) 555-5555', :password => SecureRandom.hex(16))
rmuckity = User.create(:username => 'rmuckity', :first_name => "Ricky", :last_name => "Muckitymuck", :honorific => "Brother", :email => "rmuckity@fakeemail.com", :phone_number => '(555) 555-5555', :password => SecureRandom.hex(16))

theyo = User.create(:username => 'theyo', :first_name => "Tommy", :last_name => "Heyo", :honorific => "Brother", :email => "theyo@fakeemail.com", :phone_number => '(555) 555-5555', :password => SecureRandom.hex(16))
jhux = User.create(:username => 'jhux', :first_name => "John", :last_name => "Huxtable", :honorific => "Brother", :email => "jhux@fakeemail.com", :phone_number => '(555) 555-5555', :password => SecureRandom.hex(16))

leader_1 = Leader.create(:name => "President Leader1")
leader_2 = Leader.create(:name => "President Leader2")

Position.create(:leader => leader_1, :name => "Position 1", :user => jturkeybum, :meeting_time => '1pm')
Position.create(:leader => leader_1, :name => "Position 2", :user => rmuckity, :meeting_time => '9am')

Position.create(:leader => leader_2, :name => "Position 3", :user => theyo, :meeting_time => '1pm')
Position.create(:leader => leader_2, :name => "Position 4", :user => jhux, :meeting_time => '1pm')






















