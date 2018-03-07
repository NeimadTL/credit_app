# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

MonthlySalaryRange.create!(range: 'de 0 à 999€')
MonthlySalaryRange.create!(range: 'de 1000 à 1999€')
MonthlySalaryRange.create!(range: 'de 2000 à 2999€')
MonthlySalaryRange.create!(range: 'plus de 3000€')
