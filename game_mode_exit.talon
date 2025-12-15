# Exit game mode command
# This file is active INSIDE game mode so you can exit

mode: user.game_mode
-

game off:
    user.game_mode_disable()
