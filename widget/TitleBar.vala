/*
 * Copyright (C) 2016, Juns Steven <rekols@foxmail.com>

 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

namespace Widgets {
	public class TitleBar : Gtk.Overlay {
		public WindowButton menu_btn;
		public WindowButton min_btn;
		public WindowButton close_btn;
		
		public Gtk.Box Window_Button_Box;
		public int button_margin_right = 5;
        	public int button_margin_top = 10;

		public TitleBar(){

			build_ui();
			Gtk.Label title = new Gtk.Label("Calculator");
			title.get_style_context().add_class("title");
			
			Window_Button_Box = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);
			Window_Button_Box.margin_end = button_margin_right;
            		Window_Button_Box.margin_top = button_margin_top;
			
			set_size_request(40, 40);

			draw.connect(on_draw);

			menu_btn = new WindowButton("window_menu");
			min_btn = new WindowButton("window_min");
			close_btn = new WindowButton("window_close");

			min_btn.button_press_event.connect((w, e) => {
				((Gtk.Window) w.get_toplevel()).iconify();
				return false;
			});

			close_btn.button_press_event.connect((w, e) => {
				Gtk.main_quit();
				return false;
			});

			menu_btn.button_press_event.connect((w, e) => {
				
				return false;
			});

			Gtk.Box box = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);
			box.pack_start(title, true , false , 0);
			box.pack_start(Window_Button_Box, false, false, 0);

			Window_Button_Box.pack_start(menu_btn, false, false, 0);
			Window_Button_Box.pack_start(min_btn, false , false, 0);
			Window_Button_Box.pack_start(close_btn, false, false,0);

			this.add(box);
		}

		private void build_ui() {
			
		}

		private bool on_draw(Gtk.Widget widget, Cairo.Context cr){

			var color = Utils.hex_to_rgba("#3C4751");

           		cr.set_source_rgba(color.red, color.green, color.blue, 1);
            		cr.set_operator (Cairo.Operator.SOURCE);
            		cr.paint();
            		cr.set_operator (Cairo.Operator.OVER);
            
            		foreach(Gtk.Widget w in this.get_children()) {
               			w.draw(cr);
            		};

            		return true;
		}
	}

}
