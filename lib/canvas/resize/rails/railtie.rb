require 'canvas/resize/models/active_record'

module Canvas
  module Resize
    module Rails
      require 'rails'
      class Railtie < ::Rails::Railtie
        initializer 'canvas-resize-rails.insert_into_active_record' do
          ActiveSupport.on_load :active_record do
            ::ActiveRecord::Base.extend ::Canvas::Resize::Model::ActiveRecord
          end
        end
      end
    end
  end
end

