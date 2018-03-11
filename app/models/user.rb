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

  belongs_to :monthly_salary_range, foreign_key: "monthly_salary_range_id"
  belongs_to :role, foreign_key: "role_tid"
  has_many :bank_accounts, :dependent => :destroy

  after_create :setup_country
  after_create :setup_role


  private

    def setup_country
      self.update_attributes(country: "FR")
    end

    def setup_role
      self.update_attributes(role_tid: Role::CLIENT_ROLE_TID)
    end

end
