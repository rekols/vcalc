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

using Cairo;
using Draw;
using Gtk;

namespace Widgets {
    public class WindowButton : Gtk.Button {
        Cairo.ImageSurface normal_surface;
        Cairo.ImageSurface hover_surface;
        Cairo.ImageSurface press_surface;

        public Cairo.ImageSurface normal_dark_surface;
        
        public WindowButton(string image_path) {
            normal_surface = new Cairo.ImageSurface.from_png(Utils.get_image_path(image_path) + "_normal.png");
            hover_surface = new Cairo.ImageSurface.from_png(Utils.get_image_path(image_path) + "_hover.png");
            press_surface = new Cairo.ImageSurface.from_png(Utils.get_image_path(image_path) + "_press.png");

            
            set_size_request(this.normal_surface.get_width(), this.normal_surface.get_height());

            draw.connect(on_draw);
        }
     
        private bool on_draw(Gtk.Widget widget, Cairo.Context cr) {
            var state_flags = widget.get_state_flags();
            
            if ((state_flags & Gtk.StateFlags.ACTIVE) != 0) {
                Draw.draw_surface(cr, press_surface);
            } else if ((state_flags & Gtk.StateFlags.PRELIGHT) != 0) {
                Draw.draw_surface(cr, hover_surface);
            } else {
                Draw.draw_surface(cr, normal_surface);
            }

            
            return true;
        }
    }
}
