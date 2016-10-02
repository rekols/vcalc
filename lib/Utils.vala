/* -*- Mode: Vala; indent-tabs-mode: nil; tab-width: 4 -*-
 * -*- coding: utf-8 -*-
 *
 * Copyright (C) 2011 ~ 2016 Deepin, Inc.
 *               2011 ~ 2016 Wang Yong
 *
 * Author:     Wang Yong <wangyong@deepin.com>
 * Maintainer: Wang Yong <wangyong@deepin.com>
 *
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

extern char* project_path();

namespace Utils {
	public Gdk.RGBA hex_to_rgba(string hex_color, double alpha=1.0) {
        	Gdk.RGBA rgba_color = Gdk.RGBA();
        	rgba_color.parse(hex_color);
        	rgba_color.alpha = alpha;
        
        	return rgba_color;
    	}

	public void set_context_color(Cairo.Context cr, Gdk.RGBA color) {
		cr.set_source_rgba(color.red, color.green, color.blue, color.alpha);
	}

	public void load_css_theme(string css_path) {
        	var screen = Gdk.Screen.get_default();
        	var css_provider = new Gtk.CssProvider();
        	try {
            		css_provider.load_from_path(css_path);
        	} catch (GLib.Error e) {
            		print("Got error when load css: %s\n", e.message);
        	}
        	Gtk.StyleContext.add_provider_for_screen(screen, css_provider, Gtk.STYLE_PROVIDER_PRIORITY_USER);
   	}


	public string get_image_path(string name) {
		return GLib.Path.build_path(Path.DIR_SEPARATOR_S, GLib.Path.get_dirname((string) project_path()), "image", name);
	}

	public string get_root_path(string file_path) {
        	return GLib.Path.build_path(Path.DIR_SEPARATOR_S, GLib.Path.get_dirname((string) project_path()), file_path);
    }
}
