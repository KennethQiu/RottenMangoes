class Movie < ApplicationRecord
  validates :title,
    presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true }

  validates :description,
    presence: true

  validates :release_date,
    presence: true

  validate :release_date_is_in_the_past

  has_many :reviews

  mount_uploader :image, ImageUploader 

  validates_processing_of :image
  validate :image_size_validation
  
  scope :title_is, -> (title) { where("title LIKE ?", "%#{title}%") }
  scope :director_is, -> (director) { where("director LIKE ?", "%#{director}%") }
  scope :is_short, -> { where("runtime_in_minutes < 90") }
  scope :is_medium, -> { where("runtime_in_minutes BETWEEN 90 AND 120") }
  scope :is_long, -> { where("runtime_in_minutes > 120 ") }
  def review_average
    reviews.any? ? reviews.sum(:rating_out_of_ten)/reviews.size : 0 
  end


  protected

  def release_date_is_in_the_past
    if release_date.present?  
      errors.add(:release_date, "should be in the past") if release_date > Date.today
    end
  end

  private
  def image_size_validation
    errors[:image] << "should be less than 500KB" if image.size > 0.5.megabytes
  end

end
