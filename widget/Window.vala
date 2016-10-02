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
	public class Window : Gtk.Window {
		private Widgets.TitleBar titlebar = new Widgets.TitleBar();

		public Gtk.Fixed Common = new Gtk.Fixed();
		public Gtk.Entry entry;
		public Widgets.NumButton ButtonText0 = new Widgets.NumButton("0");
		public Widgets.NumButton ButtonText1 = new Widgets.NumButton("1");
		public Widgets.NumButton ButtonText2 = new Widgets.NumButton("2");
		public Widgets.NumButton ButtonText3 = new Widgets.NumButton("3");
		public Widgets.NumButton ButtonText4 = new Widgets.NumButton("4");
		public Widgets.NumButton ButtonText5 = new Widgets.NumButton("5");
		public Widgets.NumButton ButtonText6 = new Widgets.NumButton("6");
		public Widgets.NumButton ButtonText7 = new Widgets.NumButton("7");
		public Widgets.NumButton ButtonText8 = new Widgets.NumButton("8");
		public Widgets.NumButton ButtonText9 = new Widgets.NumButton("9");
		public Widgets.NumButton ButtonTextPoint = new Widgets.NumButton(".");
		public Widgets.NumButton ButtonTextPlus =  new Widgets.NumButton("+");
		public Widgets.NumButton ButtonTextMinus = new Widgets.NumButton("-");
		public Widgets.NumButton ButtonTextMult =  new Widgets.NumButton("×");
		public Widgets.NumButton ButtonTextDiv =   new Widgets.NumButton("÷");
		public Widgets.NumButton ButtonTextIs =    new Widgets.NumButton("=");
		public Widgets.NumButton ButtonTextBack =  new Widgets.NumButton("←");
		public Widgets.NumButton ButtonTextClear = new Widgets.NumButton("C");
		public Widgets.NumButton ButtontextBrackets = new Widgets.NumButton("( )");

		private int position;

		public Window(){
			this.set_title("Calculator");
			this.set_resizable(false);
			this.set_default_size(353, 310);
			this.window_position = Gtk.WindowPosition.CENTER;
			this.destroy.connect(Gtk.main_quit);

			position = 0;
			build_ui();

			try {
				this.set_icon_from_file(Utils.get_image_path("calculator.svg"));
			} catch(Error error) {
				stdout.printf(error.message);
			}

			this.add(Common);
			this.show_all();
		}

		private void build_ui() {
			this.set_titlebar(titlebar);
			entry = new Gtk.Entry();
			ButtonTextIs.set_size_request(50, 75);
			ButtonText0.set_size_request(162, 30);

			entry.get_style_context().add_class("calc_entry");
			this.get_style_context().add_class("window");

			entry.activate.connect(is_button_clicked);

			Common.put(entry, 10, 10);

			Common.put(ButtonTextClear, 10, 100);
			Common.put(ButtonTextBack, 95, 100);
			Common.put(ButtonTextDiv, 180, 100);
			Common.put(ButtonTextMult, 265, 100);

			Common.put(ButtonText7, 10, 140);
			Common.put(ButtonText8, 95, 140);
			Common.put(ButtonText9, 180, 140);
			Common.put(ButtonTextMinus, 265, 140);

			Common.put(ButtonText4, 10, 180);
			Common.put(ButtonText5, 95, 180);
			Common.put(ButtonText6, 180, 180);
			Common.put(ButtonTextPlus, 265, 180);

			Common.put(ButtonText1, 10, 220);
			Common.put(ButtonText2, 95, 220);
			Common.put(ButtonText3, 180, 220);
			Common.put(ButtonTextIs, 265, 220);

			//Common.put(ButtontextBrackets, 10, 260);
			Common.put(ButtonText0, 10, 260);
			Common.put(ButtonTextPoint, 180, 260);

			ButtonTextPoint.clicked.connect(() => { num_button_clicked(".");});
			ButtonText0.clicked.connect(() => { num_button_clicked("0");});
			ButtonText1.clicked.connect(() => { num_button_clicked("1");});
			ButtonText2.clicked.connect(() => { num_button_clicked("2");});
			ButtonText3.clicked.connect(() => { num_button_clicked("3");});
			ButtonText4.clicked.connect(() => { num_button_clicked("4");});
			ButtonText5.clicked.connect(() => { num_button_clicked("5");});
			ButtonText6.clicked.connect(() => { num_button_clicked("6");});
			ButtonText7.clicked.connect(() => { num_button_clicked("7");});
			ButtonText8.clicked.connect(() => { num_button_clicked("8");});
			ButtonText9.clicked.connect(() => { num_button_clicked("9");});
			ButtonTextPlus.clicked.connect(() => { num_button_clicked("+");});
			ButtonTextMinus.clicked.connect(() => { num_button_clicked("-");});
			ButtonTextMult.clicked.connect(() => { num_button_clicked("×");});
			ButtonTextDiv.clicked.connect(() => { num_button_clicked("÷");});

			ButtonTextBack.clicked.connect(() => { back_button_clicked();});
			ButtonTextClear.clicked.connect(() => { clear_button_clicked();});
			ButtonTextIs.clicked.connect(() => { is_button_clicked();});
			ButtontextBrackets.clicked.connect(() => { brackets_button_clicked();});
		}

		private void num_button_clicked(string num) {
			int position = entry.get_position();
			entry.insert_at_cursor (num);
            		position += num.length;
            		entry.grab_focus ();
            		entry.set_position (position);
		}

		private void back_button_clicked() {
			position = entry.get_position();

			if (entry.get_text().length > 0) {
                		string new_text = "";
                		int index = 0;
                		unowned unichar c;
                		List<unichar> news = new List<unichar> ();

                	for (int i = 0; entry.get_text().get_next_char(ref index, out c); i++) {
                    		if (i+1 != position)
                        		news.append(c);
                	}

                	foreach (unichar u in news) {
                    		new_text += u.to_string();
                	}

                	entry.set_text (new_text);
            	}

            		entry.grab_focus ();
            		entry.set_position (position - 1);
		}

		private void clear_button_clicked() {
            		position = 0;
            		entry.set_text ("");
            		set_focus (entry);
            		entry.grab_focus ();
            		entry.set_position (position);
        	}

		private void is_button_clicked() {
			position = entry.get_position();
		
			
			if (entry.get_text() != "") {
				
			} else {
				
			}

            		entry.grab_focus();
            		entry.set_position(position);
		}

		private void brackets_button_clicked() {
			
		}


	}
}
