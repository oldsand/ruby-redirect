class Link < ActiveRecord::Base
  #belongs_to :user
  validates :short_url, uniqueness: true

  before_save :generate_short_url_if_empty

  #Link.where(:original_url => original_url).first_or_create()
  #############################
  #for example of Class method
  #def self.favorited
  #  where(favorited:true)
  #end

  #def self.recents
  #  order('updated_at DESC').limit(5)
  #end
  ######################

  def self.find_or_create_original_url
    where(original_url: params[:original_url]).first_or_create
  end

  def increase_count
    self.count += 1
  end

  def increase_count!
    self.increase_count
    self.save
  end

  private

  def generate_short_url_if_empty
    #self.increase_count

    require 'securerandom'
    if short_url.nil? || short_url.empty?
      #self.short_url = SecureRandom.hex(4)
      self.short_url = SecureRandom.hex[0...4]
    end
  end
end
