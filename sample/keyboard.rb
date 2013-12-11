load File.join(File.expand_path("."), "/lib/termbox.rb")
load File.join(File.expand_path("."), "sample/keyboard_keys.rb")
load File.join(File.expand_path("."), "sample/keyboard_keys.rb")

class Keyboard
  def self.run

    # Tell termbox where your shared lib is
    Termbox.termbox_library_path "termbox"

    # Call initialize_library once the above is set, this links us to the library C functions
    Termbox.initialize_library

    start = Termbox.tb_init
    if start
      Termbox.tb_select_input_mode 1 # TB_INPUT_ESC
      ev = Termbox::Event.new
      Termbox.tb_clear
      draw
      draw_word "Keyboard started. Press CTRL + Q to quit."
      Termbox.tb_present
      while Termbox.tb_poll_event(ev) >= 0 do
        case ev[:type]
          when 1 #TB_EVENT_KEY
            if ev[:key] == 0x11 # CTRL_Q
              Termbox.tb_shutdown
              exit
            end

            Termbox.tb_clear
            draw
            if ev[:mod] > 0
              draw_word "Pressed mod? (#{ev[:mod].inspect})", 60, 35
            end

            if ev[:key] > 0
              draw_word "Pressed #{Termbox.reverse_key_lookup(ev[:key]) || "?"}  -- #{ev[:ch].inspect}"
            elsif ev[:ch]> 0
              draw_word "Pressed key #{[ev[:ch]].pack("C*")} (#{ev[:ch]})"
            end
            Termbox.tb_present
          else
            draw_word "????"
        end
      end
    else
      raise "tb_init() failed"
    end
  end

  def self.draw
    Termbox.tb_change_cell(0,  0,  0x250C, Termbox::Colors[:white], Termbox::Colors[:default])
    Termbox.tb_change_cell(79, 0,  0x2510, Termbox::Colors[:white], Termbox::Colors[:default])
    Termbox.tb_change_cell(0,  23, 0x2514, Termbox::Colors[:white], Termbox::Colors[:default])
    Termbox.tb_change_cell(79, 23, 0x2518, Termbox::Colors[:white], Termbox::Colors[:default])


    1.upto(79) do |i|
      Termbox.tb_change_cell(i, 0, 0x2500, Termbox::Colors[:white], Termbox::Colors[:default])
      Termbox.tb_change_cell(i, 23, 0x2500, Termbox::Colors[:white], Termbox::Colors[:default])
      Termbox.tb_change_cell(i, 17, 0x2500, Termbox::Colors[:white], Termbox::Colors[:default])
      Termbox.tb_change_cell(i, 4, 0x2500, Termbox::Colors[:white], Termbox::Colors[:default])
    end

    1.upto(23) do |i|
      Termbox.tb_change_cell(0, i, 0x2502, Termbox::Colors[:white], Termbox::Colors[:default])
      Termbox.tb_change_cell(79, i, 0x2502, Termbox::Colors[:white], Termbox::Colors[:default])
    end

    Termbox.tb_change_cell(0, 17, 0x251C, Termbox::Colors[:white], Termbox::Colors[:default])
    Termbox.tb_change_cell(79, 17, 0x2524, Termbox::Colors[:white], Termbox::Colors[:default])
    Termbox.tb_change_cell(0, 4, 0x251C, Termbox::Colors[:white], Termbox::Colors[:default])
    Termbox.tb_change_cell(79, 4, 0x2524, Termbox::Colors[:white], Termbox::Colors[:default])

    5.upto(17) do |i|
      Termbox.tb_change_cell(1, i, 0x2588, Termbox::Colors[:yellow], Termbox::Colors[:yellow])
      Termbox.tb_change_cell(78, i, 0x2588, Termbox::Colors[:yellow], Termbox::Colors[:yellow])
    end
    draw_key "ESC", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "F1",  Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "F2",  Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "F3",  Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "F4",  Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "F5",  Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "F6",  Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "F7",  Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "F8",  Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "F9",  Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "F10", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "F11", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "F12", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "PRN", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "BRK", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "LED1", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "LED2", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "LED3", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "`", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "1", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "2", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "3", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "4", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "5", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "6", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "7", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "8", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "9", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "0", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "-", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "=", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "\\", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "BACKSPACE", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "INS", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "HOM", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "PGU", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "PGU", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "NUMLOCK", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "K_SLASH", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "K_STAR", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "K_MINUS", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "TAB", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "q", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "w", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "e", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "r", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "t", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "y", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "u", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "i", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "o", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "p", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "u", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "i", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "o", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "p", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "[", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "]", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "DEL", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "PGD", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "K_7", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "K_8", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "K_9", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "K_PLUS", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "CAPS", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "a", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "s", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "d", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "f", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "g", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "h", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "j", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "k", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "l", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key ";", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "'", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "K_4", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "K_5", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "K_6", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "L_SHIFT", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "z", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "x", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "c", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "v", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "b", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "n", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "m", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key ",", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key ".", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "/", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "R_SHIFT", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "ARROW_UP", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "K_1", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "K_2", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "K_3", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "K_ENTER", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "L_CTRL", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "L_MOD4", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "SPACE", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "R_CTRL", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "R_PROP", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "R_MOD4", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "R_ALT", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "ARROW_LEFT", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "ARROW_DOWN", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "ARROW_RIGHT", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "K_0", Termbox::Colors[:white], Termbox::Colors[:blue]
    draw_key "K_PERIOD", Termbox::Colors[:white], Termbox::Colors[:blue]
  end


  def self.draw_key key, fg, bg

    seq = Keyboard::KEYS[key] || []
    seq.each do |k|
      Termbox.tb_change_cell(k[:x]+2,k[:y]+4, k[:ch], fg, bg);
    end
  end

  def self.draw_word phrase, x=70, y=30
    cur_x = x
    cur_y = y
    phrase.split("").each do |char|
      Termbox.tb_change_cell(cur_x,cur_y, char.ord, Termbox::Colors[:white], Termbox::Colors[:blue]);
      cur_x = cur_x + 1
    end
  end

  def self.handle_keypress event
    draw_word "Pressed '#{event.inspect}'"
  end
end

if __FILE__ == $0
  Keyboard.run
end

