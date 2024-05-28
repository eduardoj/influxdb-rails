require "influxdb/rails/middleware/subscriber"

module InfluxDB
  module Rails
    module Middleware
      class RenderSubscriber < Subscriber # :nodoc:
        private

        def fields
          {
            value:      duration,
            count:      payload[:count],
            cache_hits: payload[:cache_hits],
          }
        end

        def tags
          {
            hook:     short_hook_name,
            filename: payload[:identifier],
          }
        end

        def short_hook_name
          return "render_template" if hook_name.include?("render_template")
          return "render_partial" if hook_name.include?("render_partial")

          "render_collection" if hook_name.include?("render_collection")
        end
      end
    end
  end
end
