module CEF
  require 'socket'

  class Sender
    attr_accessor :receiver, :receiverPort, :eventDefaults
    attr_reader   :sock
    def initialize(*args)
      Hash[*args].each { |argname, argval| send(format('%s=', argname), argval) }
      @sock = nil
    end
  end

  # TODO: Implement relp/tcp senders

  class UDPSender < Sender
    def initialize(receiver = '127.0.0.1', port = 514)
      @receiver = receiver
      @port = port
    end

    # fire the message off
    def emit(event)
      socksetup if sock.nil?
      # process eventDefaults - we are expecting a hash here. These will
      # override any values in the events passed to us. i know. brutal.
      unless eventDefaults.nil?
        eventDefaults.each do |k, v|
          event.send(format('%s=', k), v)
        end
      end
      sock.send event.to_s, 0
    end

    def socksetup
      @sock = UDPSocket.new
      @sock.connect(@receiver, @port)
    end
  end
end
