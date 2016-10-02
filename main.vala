using Gtk;

public class Application : Object {
	public static void main(string[] args) {
		Gtk.init(ref args);

		var application = new Application();
		application.run();

		Gtk.main();
	}

	public void run(){
		var window = new Widgets.Window();

		Utils.load_css_theme(Utils.get_root_path("style.css"));

		window.show_all();
	}
}
