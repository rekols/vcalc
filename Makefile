VALAC = valac

PKG =   --pkg=gtk+-3.0 \
	--pkg=gee-0.8 

SRC =   ./widget/Window.vala \
	./widget/TitleBar.vala \
	./widget/WindowButton.vala \
	./widget/Button.vala \
	./lib/Draw.vala \
	./lib/Utils.vala \
	./lib/Core.vala \
	./project_path.c \
	./main.vala

BIN = vcalc

all:
	$(VALAC) $(PKG) $(SRC) $(OPTIONS)  -o $(BIN)

