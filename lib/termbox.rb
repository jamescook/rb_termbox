$: << File.dirname(__FILE__)

require 'bundler/setup'
require 'termbox/interface'
require 'termbox/keys'
require 'termbox/colors'

module Termbox
  include Interface
  include Keys
  include Colors

  @@inited = false

  def self.init(library_path = nil)
    library_path ||= File.expand_path(File.join(File.dirname(__FILE__), '..', 'ext', 'termbox', 'libtermbox.so'))
    if File.exist?(library_path)
      self.initialize_library(library_path)
      @@inited = self.tb_init ? true : false
    else
      raise("Could not find libtermbox.so.  Have you run ext/termbox/extconf.rb?")
    end
  end

  def self.shutdown
    if @@inited    
     self.tb_shutdown
     @@inited = false
    end
  end

  def self.input_mode=(mode)
    case mode
    when :esc
      self.tb_select_input_mode(Interface::INPUT_MODE_ESC)
    when :alt
      self.tb_select_input_mode(Interface::INPUT_MODE_ALT)
    else raise("Unknown input mode: use :esc or :alt")
    end
  end

  def self.get
    event = Interface::Event.new
    value = self.tb_poll_event(event)
    raise("Polling returned #{value.to_s}.") if value < 0
    [event[:key], event[:mod], event[:ch]]
  end

end
