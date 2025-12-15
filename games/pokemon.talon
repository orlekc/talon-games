# Pokemon game voice controls
# 
# To use:
# 1. Say "game mode" to enter game mode
# 2. Say "game pokemon" to activate these controls
# 3. Use the voice commands below

mode: user.game_mode
-

# Activate this game configuration
game pokemon: skip()

# ============================================
# MOVEMENT
# ============================================
whale: user.game_key("w")
air: user.game_key("a")
sun: user.game_key("s")
delta: user.game_key("d")

# Run (hold direction longer)
run whale: user.game_key("w", 200)
run air: user.game_key("a", 200)
run sun: user.game_key("s", 200)
run delta: user.game_key("d", 200)


# ============================================
# ACTIONS
# ============================================
interact: user.game_key("space")
confirm: user.game_key("enter")
cancel: user.game_key("escape")
menu: user.game_key("x")


# ============================================
# BATTLE COMMANDS
# ============================================
select: user.game_key("space")
back: user.game_key("escape")
move one: user.game_key("1")
move two: user.game_key("2")
move three: user.game_key("3")
move four: user.game_key("4")


# ============================================
# MENU NAVIGATION
# ============================================
up: user.game_key("w")
down: user.game_key("s")
left: user.game_key("a")
right: user.game_key("d")


# ============================================
# SHORTCUTS
# ============================================
# Spam A button (for text)
spam: user.game_repeat("space", 10)

# Quick menu navigation
bag: user.game_keys("x down enter")
pokemon: user.game_keys("x down down enter")
