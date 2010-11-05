require 'active_support'
require 'action_view'
require 'easel_helpers_lite/helpers'

module EaselHelpersLite
  class Railtie < Rails::Railtie
    railtie_name :easel_helpers_lite

    initializer :insert_into_action_view do
      ActiveSupport.on_load(:action_view) do
        ActionView::Base.send(:include, EaselHelpersLite::Helpers)
      end
    end
  end
end
