# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

MonthlySalaryRange.delete_all
AccountState.delete_all
TransactionState.delete_all

MonthlySalaryRange.create!(range: 'de 0 à 999€')
MonthlySalaryRange.create!(range: 'de 1000 à 1999€')
MonthlySalaryRange.create!(range: 'de 2000 à 2999€')
MonthlySalaryRange.create!(range: 'plus de 3000€')

AccountState.create!(state: 'en attente d\'activation')
AccountState.create!(state: 'actif')
AccountState.create!(state: 'fermé')

TransactionState.create!(state_tid:1, state: "en attente")
TransactionState.create!(state_tid:2, state: "refusée")
TransactionState.create!(state_tid:3, state: "validée")
