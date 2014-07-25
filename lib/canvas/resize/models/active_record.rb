require 'active_record'
require 'canvas/resize/models/base64_decodable'

module Canvas
  module Resize
    module Model
      module ActiveRecord
        def canvas_resize column
          include ::Canvas::Resize::Model::Base64Decodable
          before_validation :decode_base64_image
          data_field_prefix column
        end
      end
    end
  end
end
