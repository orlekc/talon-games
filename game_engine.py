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
    
    def game_hold(key: str, multiplier: int):
        """Hold a key for (multiplier * 100) milliseconds
        
        Example: game_hold("w", 5) holds W for 500ms
        """
        hold_duration = multiplier * 100
        print(f"[game] Holding '{key}' for {hold_duration}ms (multiplier: {multiplier})")
        press_key(key, hold_duration)
    
    def game_toggle(key: str):
        """Toggle a key on/off - press to hold down, press again to release
        
        Example: First call holds W down, second call releases W
        """
        global _toggled_keys
        
        if key in _toggled_keys and _toggled_keys[key]:
            # Key is currently held - release it
            print(f"[game] Toggle OFF: '{key}'")
            actions.key(f"{key}:up")
            _toggled_keys[key] = False
        else:
            # Key is not held - press it down
            print(f"[game] Toggle ON: '{key}'")
            actions.key(f"{key}:down")
            _toggled_keys[key] = True    
    def game_toggle_all_off():
        """Release all currently toggled keys
        
        Useful for quickly releasing all held keys without toggling each one individually
        """
        global _toggled_keys
        
        released_keys = []
        for key, is_pressed in list(_toggled_keys.items()):
            if is_pressed:
                print(f"[game] Releasing toggled key: '{key}'")
                actions.key(f"{key}:up")
                _toggled_keys[key] = False
                released_keys.append(key)
        
        if released_keys:
            app.notify(f"Released: {', '.join(released_keys)}")
            print(f"[game] Released {len(released_keys)} toggled keys")
        else:
            print("[game] No toggled keys to release")

# Game mode management
_game_mode_active = False
_active_game = None

# Toggle state tracking - stores which keys are currently toggled on
_toggled_keys = {}

# Auto-discover games from games/ folder
# Scan for .talon files and create tags/contexts dynamically
import os
from pathlib import Path

# Get the directory where this file is located
GAMES_DIR = Path(__file__).parent / "games"

# Create a single context for managing game tags
# This context is always active when in game mode
game_ctx = Context()
game_ctx.matches = r"""
mode: user.game_mode
"""

# List to track discovered game names
_discovered_games = []

# IMPORTANT: Register tags FIRST before any .talon files load
# This ensures tags exist when .talon files reference them
if GAMES_DIR.exists():
    print(f"[talon-games] Scanning for games in: {GAMES_DIR}")
    
    # Create all tags for discovered games
    for talon_file in GAMES_DIR.glob("*.talon"):
        if talon_file.name == "template.talon":
            continue  # Skip template
        
        game_name = talon_file.stem
        _discovered_games.append(game_name)
        mod.tag(f"game_{game_name}", desc=f"{game_name.capitalize()} game is active")
        print(f"[talon-games] Created tag for: {game_name}")
    
    # Auto-generate game_selection.talon with all discovered games
    selection_file = Path(__file__).parent / "game_selection.talon"
    try:
        with open(selection_file, 'w') as f:
            f.write("# Game selection commands\n")
            f.write("# These work when in game mode to switch between games\n")
            f.write("# Auto-generated - do not edit manually\n\n")
            f.write("mode: user.game_mode\n")
            f.write("-\n\n")
            f.write("# Game activation commands\n")
            for game_name in sorted(_discovered_games):
                f.write(f"game {game_name}: user.game_load(\"{game_name}\")\n")
        print(f"[talon-games] Generated game_selection.talon with {len(_discovered_games)} games")
    except Exception as e:
        print(f"[talon-games] Warning: Could not generate game_selection.talon: {e}")
else:
    print(f"[talon-games] WARNING: games/ folder not found at {GAMES_DIR}")


@mod.action_class
class GameModeActions:
    def game_mode_enable():
        """Enable game mode (disables other Talon commands)"""
        global _game_mode_active
        _game_mode_active = True
        actions.mode.disable("command")
        actions.mode.enable("user.game_mode")
        print("[game] Game mode enabled - other Talon commands disabled")
    
    def game_mode_disable():
        """Disable game mode"""
        global _game_mode_active, _active_game, _toggled_keys
        
        # Release any toggled keys before disabling
        for key, is_pressed in list(_toggled_keys.items()):
            if is_pressed:
                print(f"[game] Releasing toggled key: '{key}'")
                actions.key(f"{key}:up")
        _toggled_keys.clear()
        
        _game_mode_active = False
        _active_game = None
        actions.mode.disable("user.game_mode")
        actions.mode.enable("command")
        
        # Clear all game tags
        game_ctx.tags = []
        
        print("[game] Game mode disabled - normal Talon commands restored")
    
    def game_mode_is_active() -> bool:
        """Check if game mode is currently active"""
        return _game_mode_active
    
    def game_load(name: str):
        """Load a specific game configuration (disables other games)"""
        global _active_game
        
        # Check if game exists
        if name not in _discovered_games:
            available = ", ".join(_discovered_games)
            app.notify(f"Unknown game: {name}")
            print(f"[talon-games] Unknown game: {name}. Available: {available}")
            return
        
        _active_game = name
        
        # Set only the selected game's tag on the game context
        # This makes that game's .talon file active
        game_ctx.tags = [f"user.game_{name}"]
        app.notify(f"Game: {name.capitalize()}")
        print(f"[talon-games] Loaded {name} controls - tag user.game_{name} activated")
