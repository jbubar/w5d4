class ShortenedUrl < ApplicationRecord
    validates :long_url, :short_url, :user_id, presence: true
    validates :long_url, :short_url, uniqueness: true

    def self.random_code
        generated_url = "www.shrinkydink.com/#{SecureRandom.urlsafe_base64}"
        
        until !ShortenedUrl.exists?(generated_url)
            generated_url = "www.shrinkydink.com/#{SecureRandom.urlsafe_base64}"
        end

        generated_url
    end

    def self.generate(user, long_url)
        generated_url = ShortenedUrl.random_code
        ShortenedUrl.create!(long_url: long_url, short_url: generated_url, user_id: user.id)
    end

    belongs_to :submitter,
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :User
end
