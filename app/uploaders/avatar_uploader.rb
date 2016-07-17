# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick
  
  #def default_url
    #"/assets/default/" + [version_name, "avatar.jpg"].compact.join('_')
  #end
  
  #def default_url
    #if !(Rails.env.development? || Rails.env.test?)
      #"#{Settings.asset_host}#{ActionController::Base.helpers.asset_path("images/default/" + [version_name, "avatar.jpg"].compact.join('_'))}"
    #else
      #ActionController::Base.helpers.asset_path("assets/default/" + [version_name, "avatar.jpg"].compact.join('_'))
    #end
  #end

  # Choose what kind of storage to use for this uploader:
  # For Heroku
  if Rails.env.production?
    storage :fog
  else
    storage :file
  end

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
   def default_url
     # For Rails 3.1+ asset pipeline compatibility:
    if Rails.env.production?
      "assets/images/default/" + [version_name, "avatar.jpg"].compact.join('_')
      #"https://photobucketu.s3.amazonaws.com/uploads/photo/picture/4/Castle_Black.jpg"
    else
     "/assets/default/" + [version_name, "avatar.jpg"].compact.join('_')
    end
   end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
