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
Role.delete_all

MonthlySalaryRange.create!(
  range_tid: MonthlySalaryRange::BETWEEN_0_AND_999_RANGE_TID,
  range: 'de 0 à 999€')
MonthlySalaryRange.create!(
  range_tid: MonthlySalaryRange::BETWEEN_1000_AND_1999_RANGE_TID,
  range: 'de 1000 à 1999€')
MonthlySalaryRange.create!(
  range_tid: MonthlySalaryRange::BETWEEN_2000_AND_2999_RANGE_TID,
  range: 'de 2000 à 2999€')
MonthlySalaryRange.create!(
  range_tid: MonthlySalaryRange::GREATER_THAN_3000_RANGE_TID,
  range: 'plus de 3000€')

AccountState.create!(state_tid: AccountState::PENDING_ACTIVATION_STATE_TID, state: 'en attente d\'activation')
AccountState.create!(state_tid: AccountState::ACTIVE_STATE_TID, state: 'actif')
AccountState.create!(state_tid: AccountState::CLOSED_STATE_TID, state: 'fermé')

TransactionState.create!(state_tid: TransactionState::PENDING_STATE_TID, state: "en attente")
TransactionState.create!(state_tid: TransactionState::CANCELLED_STATE_TID, state: "refusée")
TransactionState.create!(state_tid: TransactionState::VALIDATED_STATE_TID, state: "validée")

Role.create!(role_tid: Role::ADMIN_ROLE_TID, role_label: "admin")
Role.create!(role_tid: Role::CLIENT_ROLE_TID, role_label: "client")
