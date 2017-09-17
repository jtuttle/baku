module Baku
  module EventDispatcher
    def add_event_listener(event_name, method)
      @event_listeners ||= {}
      @event_listeners[event_name] ||= []

      @event_listeners[event_name] << method
    end

    def remove_event_listener(event_name, method)
      @event_listeners[event_name].delete(method)
    end
    
    def dispatch_event(event_name, *args)
      return unless @event_listeners.has_key?(event_name)
      @event_listeners[event_name].each { |f| f.call(*args) }
    end
  end
end
