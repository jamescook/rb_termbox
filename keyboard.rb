load "./termbox.rb"
load "./keyboard_keys.rb"

class Keyboard
  def self.run
    start = Termbox.tb_init
    puts "INIT"
    if start
      Termbox.tb_select_input_mode 1 # TB_INPUT_ESC
      ev = Termbox::Event.new
      Termbox.tb_clear
      draw
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
            handle_keypress ev
            Termbox.tb_present
          else
            puts ev[:type]
            puts ev[:key]
        end
      end
    else
      raise "tb_init() failed"
    end
  end

  def self.draw
    Termbox.tb_change_cell(0,  0,  0x250C, Termbox::COLORS[:white], Termbox::COLORS[:black]);
    Termbox.tb_change_cell(79, 0,  0x2510, Termbox::COLORS[:white], Termbox::COLORS[:black]);
    Termbox.tb_change_cell(0,  23, 0x2514, Termbox::COLORS[:white], Termbox::COLORS[:black]);
    Termbox.tb_change_cell(79, 23, 0x2518, Termbox::COLORS[:white], Termbox::COLORS[:black])


    1.upto(79) do |i|
      Termbox.tb_change_cell(i, 0, 0x2500, Termbox::COLORS[:white], Termbox::COLORS[:black]);
      Termbox.tb_change_cell(i, 23, 0x2500, Termbox::COLORS[:white], Termbox::COLORS[:black]);
      Termbox.tb_change_cell(i, 17, 0x2500, Termbox::COLORS[:white], Termbox::COLORS[:black]);
      Termbox.tb_change_cell(i, 4, 0x2500, Termbox::COLORS[:white], Termbox::COLORS[:black]);
    end

    1.upto(23) do |i|
      Termbox.tb_change_cell(0, i, 0x2502, Termbox::COLORS[:white], Termbox::COLORS[:black]);
      Termbox.tb_change_cell(79, i, 0x2502, Termbox::COLORS[:white], Termbox::COLORS[:black]);
    end

    Termbox.tb_change_cell(0, 17, 0x251C, Termbox::COLORS[:white], Termbox::COLORS[:black]);
    Termbox.tb_change_cell(79, 17, 0x2524, Termbox::COLORS[:white], Termbox::COLORS[:black]);
    Termbox.tb_change_cell(0, 4, 0x251C, Termbox::COLORS[:white], Termbox::COLORS[:black]);
    Termbox.tb_change_cell(79, 4, 0x2524, Termbox::COLORS[:white], Termbox::COLORS[:black]);

    5.upto(17) do |i|
      Termbox.tb_change_cell(1, i, 0x2588, Termbox::COLORS[:yellow], Termbox::COLORS[:yellow]);
      Termbox.tb_change_cell(78, i, 0x2588, Termbox::COLORS[:yellow], Termbox::COLORS[:yellow]);
    end
    draw_key "ESC", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "F1",  Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "F2",  Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "F3",  Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "F4",  Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "F5",  Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "F6",  Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "F7",  Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "F8",  Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "F9",  Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "F10", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "F11", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "F12", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "PRN", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "BRK", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "LED1", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "LED2", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "LED3", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "`", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "1", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "2", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "3", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "4", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "5", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "6", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "7", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "8", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "9", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "0", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "-", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "=", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "\\", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "BACKSPACE", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "INS", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "HOM", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "PGU", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "PGU", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "NUMLOCK", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "K_SLASH", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "K_STAR", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "K_MINUS", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "TAB", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "q", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "w", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "e", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "r", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "t", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "y", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "u", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "i", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "o", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "p", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "u", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "i", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "o", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "p", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "[", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "]", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "DEL", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "PGD", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "K_7", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "K_8", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "K_9", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "K_PLUS", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "CAPS", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "a", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "s", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "d", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "f", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "g", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "h", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "j", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "k", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "l", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key ";", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "'", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "K_4", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "K_5", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "K_6", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "L_SHIFT", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "z", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "x", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "c", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "v", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "b", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "n", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "m", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key ",", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key ".", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "/", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "R_SHIFT", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "ARROW_UP", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "K_1", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "K_2", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "K_3", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "K_ENTER", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "L_CTRL", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "L_MOD4", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "SPACE", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "R_CTRL", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "R_PROP", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "R_MOD4", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "R_ALT", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "ARROW_LEFT", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "ARROW_DOWN", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "ARROW_RIGHT", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "K_0", Termbox::COLORS[:white], Termbox::COLORS[:blue]
    draw_key "K_PERIOD", Termbox::COLORS[:white], Termbox::COLORS[:blue]


	#draw_key(K_K_PLUS, TB_WHITE, TB_BLUE);
    
  end


  #struct key {
    #unsigned char x;
    #unsigned char y;
    #uint32_t ch;
  #};
  
  #define STOP {0,0,0}
  #struct key K_q[] = {{6,6,'q'},STOP};
  #
  def self.draw_key key, fg, bg

    seq = Keyboard::KEYS[key] || []
    seq.each do |k|
      Termbox.tb_change_cell(k[:x]+2,k[:y]+4, k[:ch], fg, bg);
    end
  end

  def self.handle_keypress event
  end
end
