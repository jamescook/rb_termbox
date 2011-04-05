module Termbox
  Keys = {
    "F1"  => 0xFFFF - 0,
    "F2"  => 0xFFFF - 1,
    "F3"  => 0xFFFF - 2,
    "F4"  => 0xFFFF - 3,
    "F5"  => 0xFFFF - 4,
    "F6"  => 0xFFFF - 5,
    "F7"  => 0xFFFF - 6,
    "F8"  => 0xFFFF - 7,
    "F9"  => 0xFFFF - 8,
    "F10" => 0xFFFF - 9,
    "F11" => 0xFFFF - 10,
    "F12" => 0xFFFF - 11,

    "INS"    => 0xFFFF - 12,
    "INSERT" => 0xFFFF - 12,
    "DELETE" => 0xFFFF - 13,
    "HOME"   => 0xFFFF - 14,
    "END"    => 0xFFFF - 15,
    "PGUP"   => 0xFFFF - 16,
    "PGDN"   => 0xFFFF - 17,

    "ARROW_UP"    => 0xFFFF - 18,
    "ARROW_DOWN"  => 0xFFFF - 19,
    "ARROW_LEFT"  => 0xFFFF - 20,
    "ARROW_RIGHT" => 0xFFFF - 21,

    "UP"    => 0xFFFF - 18,
    "DOWN"  => 0xFFFF - 19,
    "LEFT"  => 0xFFFF - 20,
    "RIGHT" => 0xFFFF - 21,

    "CTRL" => {
      "~" => 0x00, # this or below can't be right can it?
      "A" => 0x01,
      "B" => 0x02,
      "C" => 0x03,
      "D" => 0x04,
      "E" => 0x05,
      "F" => 0x06,
      "G" => 0x07,
      "H" => 0x08, # same as backspace??
      "I" => 0x09, # same as tab??
      "J" => 0x0A,
      "L" => 0x0B,
      "M" => 0x0D, # same as ENTER?
      "N" => 0x0E,
      "O" => 0x0F,
      "P" => 0x10,
      "Q" => 0x11,
      "R" => 0x12,
      "S" => 0x13,
      "T" => 0x14,
      "U" => 0x15,
      "V" => 0x16,
      "W" => 0x17,
      "X" => 0x18,
      "Y" => 0x19,
      "Z" => 0x1A,
      "2" => 0x00,
      "3" => 0x1B,
      "4" => 0x1C,
      "5" => 0x1D,
      "6" => 0x1E,
      "7" => 0x1F,
      "8" => 0x7F,
      "\\"=> 0x1C,
      "/" => 0x1F,
      "[" => 0x1B,
      "]" => 0x1D,
      "_" => 0x1F, # same as few others
      " " => 0x20, # same as few others
    },

    "BACKSPACE" => 0x08,
    "BACKSPACE2"=> 0x7F,
    "TAB"       => 0x09,
    "ENTER"     => 0x0D,
    "RETURN"    => 0x0D,
    "ESC"       => 0x1B,
    "ESCAPE"    => 0x1B,
  }

  def lookup_key string
    if string =~ /CTRL/i
      if string =~ /CTRL\s\+\s/i
        string.sub! /CTRL\s\+\s/i, ''  # CTRL + y
        return Keys["CTRL"][string.upcase]
      else
        string.sub! /CTRL\s/i, ''      # CTRL x
        return Keys["CTRL"][string.upcase]
      end
    end

    # assume other keys like "ESC"
    return Keys[string.upcase]
  end

  def reverse_key_lookup num  # 102 => f
    # Quick check of top level keys
    match = Keys.select{|k,v| v.is_a?(Numeric) }.detect{|k,v| v == num }
    return match.shift if match

    # Now look through Ctrl sequences
    combo = Keys.select{|k,v| v.is_a?(Hash) }
    if combo.any?
      combo.each do |k,v| #k == CTRL
        match = v.detect{|k,v| v == num }
        if match
          return "CTRL + #{match.shift}"
        else
          return nil
        end
      end
    end
  end
  module_function :lookup_key, :reverse_key_lookup
end
