# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  def default_url
    ActionController::Base.helpers.asset_path(
      '/' + [version_name, 'default_avatar.png'].compact.join('_')
    )
  end
end
