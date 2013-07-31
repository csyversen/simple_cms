require 'position_mover'

class Page < ActiveRecord::Base
  # attr_accessible :title, :body

  include PositionMover

  validates_presence_of :name
  validates_length_of :name, :maximum => 255
  validates_presence_of :permalink, :within => 3..255
  validates_uniqueness_of :permalink

  belongs_to :subject
  has_many :sections
  has_and_belongs_to_many :editors, :class_name => "AdminUser"

  scope :visible, where(:visible => true)
  scope :invisible, where(:visible => false)
  scope :sorted, order("pages.position ASC")

############################
  private
############################

  def position_scope
    "pages.subject_id = #{subject_id.to_i}"
  end
  
end
