class Link < ActiveRecord::Base
  before_save :generate_short_url_if_empty

  #Link.where(:original_url => original_url).first_or_create()

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
