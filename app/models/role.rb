class Role < ActiveRecord::Base


  self.primary_key = 'role_tid'

  ADMIN_ROLE_TID = 1
  CLIENT_ROLE_TID = 2

  validates :role_tid, presence: true, numericality: { only_integer: true }
  validates :role_label, presence: true


end
