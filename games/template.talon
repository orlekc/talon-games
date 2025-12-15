# Template for creating new game configurations
# 
# INSTRUCTIONS:
# 1. Copy this file and rename it to yourgame.talon
# 2. Replace "yourgame" with your actual game name in the tag line below
# 3. Delete the game activation command (it's auto-generated)
# 4. Define your voice commands below
# 
# USAGE:
# - Say "game mode" to enter game mode
# - Say "game yourgame" to activate this configuration (auto-generated command)
# - All commands below will be available
# - All other Talon commands will be disabled for better recognition
# - Say "game off" to exit game mode

mode: user.game_mode
tag: user.game_yourgame
-

# NOTE: The "game yourgame:" activation command is auto-generated
# You don't need to add it here - it's in game_selection.talon


# ============================================
# MOVEMENT KEYS (WASD example)
# ============================================
whale: user.game_key("w")
air: user.game_key("a")
sun: user.game_key("s")
delta: user.game_key("d")

# Multiple keys in sequence (with default 50ms delay between)
whale air: user.game_keys("w a")
air sun delta: user.game_keys("a s d")


# ============================================
# ACTION KEYS
# ============================================
jump: user.game_key("space")
attack: user.game_key("e")
defend: user.game_key("q")
interact: user.game_key("f")
reload: user.game_key("r")


# ============================================
# NUMBER KEYS
# ============================================
one: user.game_key("1")
two: user.game_key("2")
three: user.game_key("3")
four: user.game_key("4")
five: user.game_key("5")


# ============================================
# REPEATED ACTIONS
# ============================================
# Press a key multiple times with a number
# Say "whale five" to press W 5 times
whale <number_small>: user.game_repeat("w", number_small)
air <number_small>: user.game_repeat("a", number_small)
sun <number_small>: user.game_repeat("s", number_small)
delta <number_small>: user.game_repeat("d", number_small)
jump <number_small>: user.game_repeat("space", number_small)

# Fixed repeat amounts (if you prefer)
air five: user.game_repeat("a", 5)
jump three: user.game_repeat("space", 3)


# ============================================
# COMBOS (with custom delays)
# ============================================
# Special combo: press q, wait 100ms, press w, wait 100ms, press e
special combo: user.game_combo("q w e", 100)
fast combo: user.game_combo("1 2 3", 50)


# ============================================
# SIMULTANEOUS KEYS
# ============================================
# Press multiple keys at the same time
strafe shoot: user.game_simultaneous("shift space")
sprint jump: user.game_simultaneous("shift space")


# ============================================
# CUSTOM HOLD DURATIONS
# ============================================
# Hold a key longer than the default 80ms
big jump: user.game_key("space", 150)
long press: user.game_key("e", 200)


# ============================================
# UTILITY KEYS
# ============================================
escape: user.game_key("escape")
enter: user.game_key("enter")
tab: user.game_key("tab")
backspace: user.game_key("backspace")


# ============================================
# CUSTOM COMMANDS
# ============================================
# Add your game-specific commands here
# Examples:
# cast spell: user.game_combo("q w e r", 80)
# ultimate: user.game_key("r", 100)
# inventory: user.game_key("i")
