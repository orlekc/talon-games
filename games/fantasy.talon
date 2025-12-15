# ff12
mode: user.game_mode
tag: user.game_fantasy
-

# Movement commands
(whale | forward | up): user.game_key("w")
(sun | back | down): user.game_key("s")
(air | left): user.game_key("a")
(drums | right): user.game_key("d")

# Movement with repeat
whale <number_small>: user.game_repeat("w", number_small)
sun <number_small>: user.game_repeat("s", number_small)
air <number_small>: user.game_repeat("a", number_small)
drums <number_small>: user.game_repeat("d", number_small)

# Camera controls
camera left: user.game_key("q")
camera right: user.game_key("e")
camera up: user.game_key("pageup")
camera down: user.game_key("pagedown")

# Action buttons
(confirm | space): user.game_key("space")
(cancel | esc): user.game_key("escape")
attack: user.game_key("space")

# Menu navigation
menu: user.game_key("escape")
map: user.game_key("m")
open map: user.game_key("m")
party: user.game_key("p")
inventory: user.game_key("i")
equipment: user.game_key("i")
status: user.game_key("c")
gambits: user.game_key("g")
license: user.game_key("l")

# Target selection
next target: user.game_key("tab")
previous target: user.game_keys("shift tab")
target enemy: user.game_key("tab")
target ally: user.game_key("f")

# Special actions
quickening: user.game_key("r")
summon: user.game_key("r")
pause: user.game_key("p")
run: user.game_key("shift")

# Turbo mode (FF12 specific feature)
turbo: user.game_key("f1")
speed normal: user.game_key("f1")
speed double: user.game_key("f2")
speed quad: user.game_key("f3")

# Party controls
switch leader: user.game_key("f2")
switch party: user.game_key("f3")
(next | switch) character: user.game_key("f2")

# Screenshot and UI
screenshot: user.game_key("f12")
hide U I: user.game_key("h")
toggle U I: user.game_key("h")

# Mouse click controls
touch: mouse_click(0)
righty: mouse_click(1)
(left click | click): mouse_click(0)
(right click | rights): mouse_click(1)
double click: 
    mouse_click(0)
    sleep(50ms)
    mouse_click(0)

# Common key combinations for FF12
quick save: user.game_key("f5")
quick load: user.game_key("f9")

# Number keys for shortcuts (for menu selections)
one: user.game_key("1")
two: user.game_key("2")
three: user.game_key("3")
four: user.game_key("4")
five: user.game_key("5")
six: user.game_key("6")
seven: user.game_key("7")
eight: user.game_key("8")
nine: user.game_key("9")

# Battle commands
use item: user.game_key("i")
magic: user.game_key("m")
technick: user.game_key("t")

# Zoom/minimap
zoom in: user.game_key("equals")
zoom out: user.game_key("minus")

# Additional movement commands
sprint: user.game_key("shift")
walk: user.game_key("ctrl")
