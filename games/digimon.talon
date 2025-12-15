# Digimon World voice controls
# 
# To use:
# 1. Say "game mode" to enter game mode
# 2. Say "game digimon" to activate these controls
# 3. Use the voice commands below
# 4. Say "game off" to exit

mode: user.game_mode
tag: user.game_digimon
-

# Commands below only work when Digimon is the active game

# ============================================
# MOVEMENT
# ============================================
whale: user.game_key("w")
air: user.game_key("a")
sun: user.game_key("s")
drums: user.game_key("d")

# Diagonal movement
whale air: user.game_keys("w a")
whale drums: user.game_keys("w d")
sun air: user.game_keys("s a")
sun drums: user.game_keys("s d")


# ============================================
# ACTIONS
# ============================================
attack: user.game_key("space")
special: user.game_key("e")
dodge: user.game_key("shift")
interact: user.game_key("f")
jump: user.game_key("space")


# ============================================
# MENU & INVENTORY
# ============================================
menu: user.game_key("escape")
inventory: user.game_key("i")
map: user.game_key("m")


# ============================================
# COMBOS
# ============================================
# Quick attack combo
combo one: user.game_combo("space space e", 100)

# Special move
combo two: user.game_combo("e space", 80)


# ============================================
# SHORTCUTS
# ============================================
# Dodge and attack
dodge attack: user.game_keys("shift space")

# Run forward
run: user.game_repeat("w", 5)

# ============================================
# REPEAT WITH NUMBER
# ============================================
# Say "whale five" to press W 5 times
whale <number_small>: user.game_repeat("w", number_small)
air <number_small>: user.game_repeat("a", number_small)
sun <number_small>: user.game_repeat("s", number_small)
delta <number_small>: user.game_repeat("d", number_small)
attack <number_small>: user.game_repeat("space", number_small)
