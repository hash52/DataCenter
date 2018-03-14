class DataFileUploader < CarrierWave::Uploader::Base
  include CarrierWave::Magic
  process :set_magic_content_type => [true]

  if Rails.env.development?
    storage :file
  elsif Rails.env.test?
    storage :file
  else
    storage :file
  end

  def store_dir
    "uploads/#{model.user_id}"
  end

  def filename
    original_filename if original_filename
  end

end
