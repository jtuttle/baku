module Baku
  module EventDispatcher
    def add_event_listener(event_name, *method, &block)
      @event_listeners ||= {}
      @event_listeners[event_name] ||= []

      if block
        @event_listeners[event_name] << block
      else
        @event_listeners[event_name] << method[0]
      end
    end

    def dispatch_event(event_name, *args)
      return unless @event_listeners.has_key?(event_name)
      @event_listeners[event_name].each { |f| f.call(*args) }
    end
  end
end
