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

  def review_average
    reviews.any? ? reviews.sum(:rating_out_of_ten)/reviews.size : 0 
  end

  validates_processing_of :image
  validate :image_size_validation

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
