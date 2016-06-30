class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :photos, dependent: :destroy
         
  def full_name
    return "#{first_name} #{last_name}".strip if (first_name || last_name)
    # if the user don't have a first or last name show as anonymous
    "Anonymous"
  end

end
