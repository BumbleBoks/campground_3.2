# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Common::State.delete_all
Common::State.create!(name: "Alabama")
Common::State.create!(name: "Alaska")
Common::State.create!(name: "Arizona")
Common::State.create!(name: "Arkansas")
Common::State.create!(name: "California")
Common::State.create!(name: "Colorado")
Common::State.create!(name: "Connecticut")
Common::State.create!(name: "Delaware")
Common::State.create!(name: "Florida")
Common::State.create!(name: "Georgia")
Common::State.create!(name: "Hawaii")
Common::State.create!(name: "Idaho")
Common::State.create!(name: "Illinois")
Common::State.create!(name: "Indiana")
Common::State.create!(name: "Iowa")
Common::State.create!(name: "Kansas")
Common::State.create!(name: "Kentucky")
Common::State.create!(name: "Louisiana")
Common::State.create!(name: "Maine")
Common::State.create!(name: "Maryland")
Common::State.create!(name: "Massachusetts")
Common::State.create!(name: "Michigan")
Common::State.create!(name: "Minnesota")
Common::State.create!(name: "Mississippi")
Common::State.create!(name: "Missouri")
Common::State.create!(name: "Montana")
Common::State.create!(name: "North Carolina")
Common::State.create!(name: "North Dakota")
Common::State.create!(name: "Nebraska")
Common::State.create!(name: "Nevada")
Common::State.create!(name: "New Hampshire")
Common::State.create!(name: "New Jersey")
Common::State.create!(name: "New Mexico")
Common::State.create!(name: "New York")
Common::State.create!(name: "Ohio")
Common::State.create!(name: "Oklahoma")
Common::State.create!(name: "Oregon")
Common::State.create!(name: "Pennsylvania")
Common::State.create!(name: "Rhode Island")
Common::State.create!(name: "South Carolina")
Common::State.create!(name: "South Dakota")
Common::State.create!(name: "Tennessee")
Common::State.create!(name: "Texas")
Common::State.create!(name: "Utah")
Common::State.create!(name: "Vermont")
Common::State.create!(name: "Virginia")
Common::State.create!(name: "Washington")
Common::State.create!(name: "West Virginia")
Common::State.create!(name: "Wisconsin")
Common::State.create!(name: "Wyoming")

Common::Activity.delete_all
Common::Activity.create!(name: "Cycling")
Common::Activity.create!(name: "Hiking")
Common::Activity.create!(name: "Cross country skiing")
