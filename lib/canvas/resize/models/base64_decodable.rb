require 'active_support'
module Canvas
  module Resize
    module Model
      module Base64Decodable
        extend ::ActiveSupport::Concern

        module ClassMethods
          def data_field_prefix(prefix)
            class_attribute :_data_field_prefix
            self._data_field_prefix = prefix

            sym_base64 = "#{self._data_field_prefix}_base64".to_sym
            attr_accessible sym_base64
            attr_accessor sym_base64

            sym_file_name = "#{self._data_field_prefix}_file_name".to_sym
            attr_accessible sym_file_name
            attr_accessor sym_file_name
          end
        end

        def data_field_prefix
          self.class._data_field_prefix.to_s
        end

        def base64_field
          self.send("#{data_field_prefix}_base64")
        end

        def file_name_field
          self.send("#{data_field_prefix}_file_name")
        end

        def data_field=(data)
          self.send("#{data_field_prefix}=", data)
        end

        def blank_base64_data?
          base64_field.blank? || file_name_field.blank?
        end

        def decode_base64_image
          unless blank_base64_data?
            # base64_field should be like "data:image/jpeg;base64,/9j/4AAQ..."
            splitted_data = base64_field.split(/[:;,]/, 4)
            decoded_data = Base64.decode64(splitted_data.last)

            self.data_field = StringIO.new(decoded_data).tap do |data|
              data.class_eval{ attr_accessor :original_filename, :content_type }
              data.content_type = splitted_data.second
              data.original_filename = File.basename(file_name_field)
            end
          end
        end
      end
    end
  end
end
