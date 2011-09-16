module Breeze
  module Commerce
    class VariantUploader < CarrierWave::Uploader::Base
      include CarrierWave::ConditionalVersions
      include CarrierWave::RMagick

      FULL_SIZE  = [ 168, 142 ].freeze unless defined?(FULL_SIZE)
      THUMB_SIZE = [ 34, 34 ].freeze unless defined?(THUMB_SIZE)
      BREEZE_THUMB_SIZE = [ 16, 16 ].freeze unless defined?(BREEZE_THUMB_SIZE)
    
      storage :file
    
      def store_path(for_file = filename)
        folder = "images/variants/#{model.id}/"
        File.join *[version_name ? "#{folder}#{version_name}" : folder, full_filename(for_file)].compact
        # File.join *[version_name ? "images/galleries/#{model.gallery.title}/#{version_name}" : "images/galleries/#{model.gallery.title}", full_filename(for_file)].compact
      end
      
      def full_filename(for_file)
        for_file
      end

      def extension_white_list
        %w(jpg jpeg gif png)
      end

      version :full do
        process :resize_to_limit => FULL_SIZE
      end

      version :thumbnail do
        process :resize_to_fill => THUMB_SIZE
      end

      version :breeze_thumb do
        process :resize_to_limit => BREEZE_THUMB_SIZE
      end

      before :cache, :capture_size_before_cache 
      before :retrieve_from_cache, :capture_size_after_retrieve_from_cache 

    protected
      def capture_size_before_cache(new_file)
        capture_image_size!(new_file.path || new_file.file.tempfile.path)
      end
    
      def capture_size_after_retrieve_from_cache(cache_name)
        capture_image_size!(@file.path)
      end
      
      def capture_image_size!(path)
        model.image_width, model.image_height = `identify -format "%wx%h" #{path}`.split(/x/)
      end
    end
  end
end

