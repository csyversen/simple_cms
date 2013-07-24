require "digest/sha2"

class AdminUser < ActiveRecord::Base
  
  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i

 # validates_presence_of :first_name
 # validates_length_of :first_name, :maxiumum => 25
 
 # validates_presence_of :last_name
 # validates_length_of :last_name, :maxiumum => 50
 
 # validates_presence_of :username
 # validates_length_of :username, :within => 8..25
 # validates_uniqueness_of :username
 
 # validates_presence_of :email
 # validates_length_of :email, :maxiumum => 100
 # validates_format_of :email, :with => EMAIL_REGEX
 # validates_confirmation_of :email

  validates_length_of :password, :within => 8..25, :on => :create 

  validates :email, :presence => true,
                    #:length => { :maxiumum => 50 }, 
                    :uniqueness => true,
                    :format => { :with => EMAIL_REGEX },
                    :confirmation => true


  # attr_accessible :title, :body
  has_and_belongs_to_many :pages
  has_many :section_edits
  has_many :sections, :through => :section_edits

  scope :named, lambda {|first, last| where(:first_name => first, :last_name => last)}

  attr_accessor :password

  before_save :create_hashed_password
  after_save :clear_password

  def self.make_salt(username = "")
    Digest::SHA2.hexdigest("Use #{username} with #{Time.now} to maek salt")
  end


  def self.hash_with_salt(password="", salt = "")
    Digest::SHA2.hexdigest("Put #{salt} on the #{password}")
  end


  def self.authenticate(username = "", password = "")
    user = AdminUser.find_by_username(username)
    if user && user.password_match?(password)
      user
    else
      false
    end
  end

  def password_match?(password = "")
    hashed_password == AdminUser.hash_with_salt(password, salt)
  end


############################################################################
  private
############################################################################

  def create_hashed_password
    # Whenever :password has a value hashing is needed
    unless password.blank?
      # always use "self" when assigning values
      self.salt = AdminUser.make_salt(username) if salt.blank?
      self.hashed_password = AdminUser.hash_with_salt(password, salt)
    end
  end

  def clear_password
    # for security and b/c hashing is not needed
    self.password = nil
  end


end
