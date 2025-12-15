"""
Game input orchestration engine using betterinput for reliable key detection.

This module provides a simple, extensible framework for voice-controlled gaming.
Users can create per-game .talon files with voice commands that map to game inputs.
"""

from talon import Module, Context, actions, app, settings
import time

# Check if betterinput is available - REQUIRED for talon-games
try:
    # Attempt to load betterinput from the workspace
    actions.user.betterinput
    HAS_BETTERINPUT = True
    print("[talon-games] Using betterinput for reliable key detection")
except Exception as e:
    HAS_BETTERINPUT = False
    print(f"[talon-games] ERROR: betterinput not found!")
    print("[talon-games] Please install betterinput: https://github.com/lucillablessing/betterinput")
    print(f"[talon-games] Error details: {e}")


def press_key(key: str, hold_ms: int = 80):
    """Press a key with specified hold duration using betterinput"""
    if not HAS_BETTERINPUT:
        app.notify("ERROR: betterinput not installed!")
        print("[talon-games] betterinput is required but not available")
        return
    
    try:
        actions.user.betterinput(
            key,
            "",
            {
                "sustain_clicks_for": f"{hold_ms}ms",
            }
        )
    except Exception as e:
        app.notify(f"betterinput error: {e}")
        print(f"[talon-games] betterinput error: {e}")


mod = Module()
mod.mode("game_mode", desc="Game mode is active - disables other Talon commands")
mod.list("game_names", desc="Available games")

# Settings
mod.setting(
    "game_hold_duration",
    type=int,
    default=80,
    desc="Default key hold duration in milliseconds for game inputs"
)

mod.setting(
    "game_sequence_delay",
    type=int,
    default=50,
    desc="Delay between sequential key presses in milliseconds"
)


@mod.action_class
class GameActions:
    def game_key(key: str, hold_ms: int = None):
        """Press a single key with specified hold duration"""
        if hold_ms is None:
            hold_ms = settings.get("user.game_hold_duration")
        
        print(f"[game] Pressing '{key}' for {hold_ms}ms")
        press_key(key, hold_ms)
    
    def game_keys(keys: str, delay_ms: int = None):
        """Press multiple keys in sequence (space-separated)"""
        if delay_ms is None:
            delay_ms = settings.get("user.game_sequence_delay")
        
        key_list = keys.split()
        hold_ms = settings.get("user.game_hold_duration")
        
        print(f"[game] Sequence: {' -> '.join(key_list)} (delay {delay_ms}ms)")
        for i, key in enumerate(key_list):
            press_key(key, hold_ms)
            if i < len(key_list) - 1:
                actions.sleep(f"{delay_ms}ms")
    
    def game_repeat(key: str, count: int, delay_ms: int = None):
        """Repeat a key press multiple times"""
        if delay_ms is None:
            delay_ms = settings.get("user.game_sequence_delay")
        
        hold_ms = settings.get("user.game_hold_duration")
        
        print(f"[game] Repeat '{key}' x{count} (delay {delay_ms}ms)")
        for i in range(count):
            press_key(key, hold_ms)
            if i < count - 1:
                actions.sleep(f"{delay_ms}ms")
    
    def game_combo(keys: str, delay_ms: int):
        """Execute a combo with custom delay between keys"""
        key_list = keys.split()
        hold_ms = settings.get("user.game_hold_duration")
        
        print(f"[game] Combo: {' -> '.join(key_list)} (delay {delay_ms}ms)")
        for i, key in enumerate(key_list):
            press_key(key, hold_ms)
            if i < len(key_list) - 1:
                actions.sleep(f"{delay_ms}ms")
    
    def game_simultaneous(keys: str):
        """Press multiple keys simultaneously (hold all, then release all)"""
        key_list = keys.split()
        print(f"[game] Simultaneous: {' + '.join(key_list)}")
        
        # Press all keys down
        for key in key_list:
            actions.key(f"{key}:down")
        
        # Hold for configured duration
        hold_ms = settings.get("user.game_hold_duration")
        actions.sleep(f"{hold_ms}ms")
        
        # Release all keys
        for key in key_list:
            actions.key(f"{key}:up")


# Game mode management
_game_mode_active = False

@mod.action_class
class GameModeActions:
    def game_mode_enable():
        """Enable game mode (disables other Talon commands)"""
        global _game_mode_active
        _game_mode_active = True
        actions.mode.disable("command")
        actions.mode.enable("user.game_mode")
        app.notify("Game Mode: ON")
        print("[game] Game mode enabled - other Talon commands disabled")
    
    def game_mode_disable():
        """Disable game mode"""
        global _game_mode_active
        _game_mode_active = False
        actions.mode.disable("user.game_mode")
        actions.mode.enable("command")
        app.notify("Game Mode: OFF")
        print("[game] Game mode disabled - normal Talon commands restored")
    
    def game_mode_is_active() -> bool:
        """Check if game mode is currently active"""
        return _game_mode_active
