# The Legend of Heroes: Trails Beyond the Horizon
# Voice controls for Trails Beyond the Horizon
# 
# To use:
# 1. Say "game mode" to enter game mode
# 2. Say "game trails" to activate these controls
# 3. Use the voice commands below

mode: user.game_mode
tag: user.game_horizon
-

# ============================================
# MOVEMENT (WASD)
# ============================================
whale: user.game_key("w")
air: user.game_key("a")
sun: user.game_key("s")
drums: user.game_key("d")
red: user.game_key("r")

# Movement with repeat
whale <number_small>: user.game_repeat("w", number_small)
air <number_small>: user.game_repeat("a", number_small)
sun <number_small>: user.game_repeat("s", number_small)
drums <number_small>: user.game_repeat("d", number_small)


# ============================================
# FIELD ACTIONS
# ============================================
interact: user.game_key("f")
use topic: user.game_key("r")
deploy shards: user.game_key("r")
dash: user.game_key("shift")
walk: user.game_key("alt")
cap: user.game_key("\\")
cap <number_small>: user.game_repeat("\\", number_small)
look: user.game_key("[")
quick art: user.game_hold("f", 7)
point: user.game_hold("]", 3)


# ============================================
# MENU NAVIGATION
# ============================================
confirm: user.game_key("enter")
cancel: user.game_key("escape")

menu action one: user.game_key("f")
menu action two: user.game_key("r")

previous tab: user.game_key("q")
next tab: user.game_key("e")
tab left: user.game_key("q")
tab right: user.game_key("e")

previous page: user.game_key("z")
next page: user.game_key("c")

urge: user.game_key("up")
harp: user.game_key("left")
crunch: user.game_key("right")
made: user.game_key("down")
urge <number_small>: user.game_repeat("up", number_small)
harp <number_small>: user.game_repeat("left", number_small)
crunch <number_small>: user.game_repeat("righ", number_small)
made <number_small>: user.game_repeat("down", number_small)

each: user.game_key("escape")


# ============================================
# CAMP MENU
# ============================================
item: user.game_key("w")
orbment: user.game_key("a")
equipment: user.game_key("s")
status: user.game_key("c")
tactics: user.game_key("z")
achievements: user.game_key("q")
crafts menu: user.game_key("e")
system menu: user.game_key("tab")
examine character: user.game_key("x")
change pose: user.game_key("p")


# ============================================
# BATTLE COMMANDS
# ============================================
previous target: user.game_key("r")
next target: user.game_key("f")
arts: user.game_key("q")
crafts: user.game_key("e")
awakening: user.game_key("e")
items: user.game_key("x")
show enemy info: user.game_key("b")
enemy info: user.game_key("b")
boost: user.game_key("c")
show sub info: user.game_key("z")
shard command: user.game_key("t")
skip: user.game_key("escape")
enter: user.game_key("enter")
zoc: user.game_hold("c", 11)
shard search: user.game_key("c")
release shards: user.game_hold("esc", 30)


# ============================================
# SHORTCUTS
# ============================================
shortcut menu: user.game_key("y")
open camp: user.game_key("escape")
open notebook: user.game_key("tab")
notebook: user.game_key("tab")
open log: user.game_key("l")
log: user.game_key("l")
expand map: user.game_key("m")
minimap: user.game_key("m")
todo list: user.game_key("j")
travel menu: user.game_key("n")
contact lines: user.game_key("x")

# Direct shortcuts
party lineup: user.game_simultaneous("p")
timely terms: user.game_key("t")
healing arts: user.game_key("h")
fishing: user.game_key("g")


# ============================================
# VEHICLE/DRONE CONTROLS
# ============================================
accelerate: user.game_key("w")
brake: user.game_key("s")
reverse: user.game_key("s")
steer left: user.game_key("a")
steer right: user.game_key("d")
drone up: user.game_key("e")
drone down: user.game_key("q")
change camera: user.game_key("b")


# ============================================
# QUICK COMBINATIONS
# ============================================
# Fast menu navigation
go items: user.game_keys("escape w")
go equipment: user.game_keys("escape s")
go orbment: user.game_keys("escape a")

# Quick shortcuts
quick heal: user.game_key("h")
quick items: user.game_key("i")


# ============================================
# UTILITY COMMANDS
# ============================================
# Spam confirm (useful for dialogue)
spam confirm: user.game_repeat("enter", 4)
spam skip: user.game_repeat("escape", 5)
