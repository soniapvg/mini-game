# User
class User
  attr_accessor :email, :age
  
  @@all_users = []

  def initialize(email_to_save, age_to_save)
    @email = email_to_save
    @age = age_to_save
    @@all_users << self
  end

  def self.all
    @@all_users
  end

  def self.find_by_email(known_email)
    @@all_users.each do |user|
      return user.email == known_email ? user : nil
    end
  end
end
