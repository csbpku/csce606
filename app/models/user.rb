# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  provider   :string
#  uid        :string
#  name       :string
#  location   :string
#  image_url  :string
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  class << self
    def from_omniauth(auth_hash)
      user = find_or_create_by(uid: auth_hash['uid'], provider: auth_hash['provider'])
      user.name = auth_hash['info']['name']
      user.location = auth_hash['info']['location']
      user.image_url = auth_hash['info']['image']
      user.url = get_social_url_for user.provider, auth_hash['info']['urls']
      user.save!
      user
    end

    private

    def get_social_url_for(provider, urls_hash)
      case provider
        when 'linkedin'
          urls_hash['public_profile']
        else
          urls_hash[provider.capitalize]
      end
    end
  end


end