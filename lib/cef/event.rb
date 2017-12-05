require 'time'

module CEF
  class Event
    attr_accessor :syslog_pri, :my_hostname
    # set up accessors for all of the CEF event attributes. ruby meta magic.
    CEF::ATTRIBUTES.each do |k, _v|
      instance_eval do
        attr_accessor k
      end
    end

    def attrs
      CEF::ATTRIBUTES
    end

    def event_time=(event_time)
      @event_time = Time.parse(event_time)
    end

    # so we can CEF::Event.new(:foo=>"bar")
    def initialize(*params)
      @event_time         = Time.new
      @deviceVendor       = 'breed.org'
      @deviceProduct      = 'CEF'
      @deviceVersion      = CEF::VERSION
      @deviceEventClassId = '0:event'
      @deviceSeverity     = CEF::SEVERITY_LOW
      @name               = 'unnamed event'
      # used to avoid requiring syslog.h on windoze
      # syslog_pri= Syslog::LOG_LOCAL0 | Syslog::LOG_NOTICE
      @syslog_pri         = 131
      @my_hostname        = Socket.gethostname
      @other_attrs = {}
      @additional = {}
      Hash[*params].each { |k, v| send(format('%s=', k), v) }
      yield self if block_given?
      self
    end

    # returns a cef formatted string of the kind:
    # CEF:Version|Device Vendor|Device Product|Device Version|Signature ID (deviceEventClassId)|Name|Severity|Extension
    def to_s
      log_time = @event_time.strftime(CEF::LOG_TIME_FORMAT)

      format(
        CEF::LOG_FORMAT,
        syslog_pri.to_s,
        log_time,
        my_hostname,
        format_prefix,
        format_extension
      )
    end

    # used for non-schema fields
    def set_additional(k, v)
      @additional[k] = v
    end

    def get_additional(k, _v)
      @additional[k]
    end

    # escape only pipes and backslashes in the prefix. you bet your sweet
    # ass there's a lot of backslashes in the substitution. you can thank
    # the three levels of lexical analysis/substitution in the ruby interpreter
    # for that.

    def escape_prefix_value(val)
      escapes = {
        /(\||\\)/ => '\\\\\&'
      }
      escapes.reduce(val) do |memo, replace|
        memo = memo.gsub(*replace)
      end
    end

    # only equals signs need to be escaped in the extension. i think.
    # TODO: something in the spec about \n and some others.
    def escape_extension_value(val)
      escapes = {
        /=/  => '\=',
        /\n/ => ' ',
        /\\/ => '\\'
      }
      escapes.reduce(val) do |memo, replace|
        memo = memo.gsub(*replace)
      end
    end

    # returns a pipe-delimeted list of prefix attributes
    def format_prefix
      values = CEF::PREFIX_ATTRIBUTES.keys.map { |k| send(k) }
      escaped = values.map do |value|
        escape_prefix_value(value)
      end
      escaped.join('|')
    end

    # returns a space-delimeted list of attribute=value pairs for all optionals
    def format_extension
      extensions = CEF::EXTENSION_ATTRIBUTES.keys.map do |meth|
        value = send(meth)
        next if value.nil?
        shortname = CEF::EXTENSION_ATTRIBUTES[meth]
        [shortname, escape_extension_value(value)].join('=')
      end

      # make sure time comes out as milliseconds since epoch
      times = CEF::TIME_ATTRIBUTES.keys.map do |meth|
        value = send(meth)
        next if value.nil?
        shortname = CEF::TIME_ATTRIBUTES[meth]
        [shortname, escape_extension_value(value)].join('=')
      end
      (extensions + times).compact.join(' ')
    end
  end
end

# vendor=  self.deviceVendor       || "Breed"
# product= self.deviceProduct      || "CEF Sender"
# version= self.deviceVersion      || CEF::VERSION
# declid=  self.deviceEventClassId || "generic:0"
# name=    self.name               || "Generic Event"
# sev=     self.deviceSeverity     || "1"
# %w{ deviceVendor deviceProduct deviceVersion deviceEvent}
# cef_prefix="%s|%s|%s|%s|%s|%s" % [
#   prefix_escape(vendor),
#   prefix_escape(product),
#   prefix_escape(version),
#   prefix_escape(declid),
#   prefix_escape(name),
#   prefix_escape(sev),
# ]
