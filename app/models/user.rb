class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  validates :title, presence: true, inclusion: { in: %w(Mr Mme Mlle) }
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :birthday, presence: true
  validates :city, presence: true
  validates :monthly_salary_range, presence: true


end