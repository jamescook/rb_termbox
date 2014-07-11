require "bundler/setup"
require "ffi"

lib = File.expand_path('../../', __FILE__)
$:.unshift lib unless $:.include?(lib)

module Termbox
  def self.run
    initialize_library

    if tb_init
      tb_select_input_mode 1 # TB_INPUT_ESC
      ev = Event.new

      yield

      tb_present

      while tb_poll_event(ev) >= 0 do
        case ev[:type]
        when 1 #TB_EVENT_KEY
          tb_shutdown if ev[:key] == 0x1B # ESC
        end
      end
    end
  ensure
    tb_shutdown if tb_init
  end

  extend FFI::Library

  class Cell < FFI::Struct
    layout :ch, :ulong,
           :fg, :uint16,
           :bg, :uint16
   end

  class Event < FFI::Struct
    layout :type, :uint8,
           :mod,  :uint8,
           :key,  :uint16,
           :ch,   :uint32,
           :w,    :int32,
           :h,    :int32
   end

  def self.initialize_library
    ffi_lib File.expand_path("../libtermbox.bundle", __FILE__)
    attach_function :tb_init,        [], :int
    attach_function :tb_shutdown,    [], :void
    attach_function :tb_width,       [], :uint
    attach_function :tb_height,      [], :uint
    attach_function :tb_clear,       [], :void
    attach_function :tb_present,     [], :void
    attach_function :tb_set_cursor,  [:int, :int], :void
    attach_function :tb_put_cell,    [:uint, :uint, :pointer], :void  #pointer follows TbCell
    attach_function :tb_change_cell, [:uint, :uint, :ulong, :uint16, :uint16], :void
    attach_function :tb_blit,        [:uint, :uint, :uint, :uint, :pointer], :void # pointer follows TbCell

    # with 0 returns current input mode
    attach_function :tb_select_input_mode, [:int], :int
    attach_function :tb_peek_event, [:pointer, :int], :int
    attach_function :tb_poll_event, [:pointer], :int
  end

  require_relative  "termbox/keys"
  require_relative  "termbox/colors"
end
