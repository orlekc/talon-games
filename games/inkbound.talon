# Inkbound game voice controls
# Inkbound is a turn-based tactical roguelike by Shiny Shoe
# 
# To use:
# 1. Say "game mode" to enter game mode
# 2. Say "game inkbound" to activate these controls
# 3. Use the voice commands below

mode: user.game_mode
tag: user.game_inkbound
-

# Commands below only work when Inkbound is the active game

# ============================================
# MOVEMENT (WASD or Arrow Keys)
# ============================================
whale: user.game_key("w")
air: user.game_key("a")
sun: user.game_key("s")
drums: user.game_key("d")

up: user.game_key("up")
down: user.game_key("down")
left: user.game_key("left")
right: user.game_key("right")

# Movement with numbers
whale <number_small>: user.game_repeat("w", number_small)
air <number_small>: user.game_repeat("a", number_small)
sun <number_small>: user.game_repeat("s", number_small)
drums <number_small>: user.game_repeat("d", number_small)


# ============================================
# ABILITY KEYS (1-4 for abilities, Q/E for items)
# ============================================
ability one: user.game_key("1")
ability two: user.game_key("2")
ability three: user.game_key("3")
ability four: user.game_key("4")

# Quick ability casting
one: user.game_key("1")
two: user.game_key("2")
three: user.game_key("3")
four: user.game_key("4")

# Item/Consumable slots
item left: user.game_key("q")
item right: user.game_key("e")
quick item: user.game_key("q")


# ============================================
# COMBAT ACTIONS
# ============================================
attack: user.game_key("space")
confirm: user.game_key("space")
select: user.game_key("enter")
cancel: user.game_key("escape")
back: user.game_key("escape")

# End turn
end turn: user.game_key("space")
pass: user.game_key("space")


# ============================================
# MENU NAVIGATION
# ============================================
escape: user.game_key("escape")
menu: user.game_key("escape")
inventory: user.game_key("i")
character: user.game_key("c")
map: user.game_key("m")
tab: user.game_key("tab")


# ============================================
# INTERACTION
# ============================================
interact: user.game_key("f")
use: user.game_key("f")
pickup: user.game_key("f")
examine: user.game_key("e")
touch: mouse_click(0)
drag: user.mouse_drag(0)

# ============================================
# UI AND SHORTCUTS
# ============================================
pause: user.game_key("escape")
skip: user.game_key("space")
hold shift: user.game_key("shift", 100)

# Zoom/Camera
zoom in: user.game_key("=")
zoom out: user.game_key("-")


# ============================================
# TARGETING
# ============================================
target next: user.game_key("tab")
target previous: user.game_key("shift-tab")
cycle target: user.game_key("tab")


# ============================================
# SOCIAL/MULTIPLAYER
# ============================================
chat: user.game_key("enter")
emote: user.game_key("t")


# ============================================
# NUMBER KEYS (for quick selection)
# ============================================
five: user.game_key("5")
six: user.game_key("6")
seven: user.game_key("7")
eight: user.game_key("8")
nine: user.game_key("9")


# ============================================
# FUNCTION KEYS
# ============================================
help: user.game_key("f1")
quick save: user.game_key("f5")
quick load: user.game_key("f9")


# ============================================
# REPEAT ACTIONS
# ============================================
# Spam space for skipping dialogue/animations
spam: user.game_repeat("space", 10)
spam fast: user.game_repeat("space", 20)

# Repeat abilities
ability one <number_small>: user.game_repeat("1", number_small)
ability two <number_small>: user.game_repeat("2", number_small)
ability three <number_small>: user.game_repeat("3", number_small)
ability four <number_small>: user.game_repeat("4", number_small)


# ============================================
# COMBOS
# ============================================
# Quick ability combos
combo one two: user.game_keys("1 2")
combo one three: user.game_keys("1 3")
combo two three: user.game_keys("2 3")
quick cast all: user.game_keys("1 2 3 4")
