# Talon Games - Voice Control for Gaming

Simple, extensible voice control for games using reliable input detection.

## Quick Start

1. Say **"game mode"** to enter game mode
2. Say **"game digimon"** (or your game name) to load that game's controls
3. Use the voice commands defined in your game file
4. Say **"game off"** to exit

## Creating a New Game

1. Copy `games/template.talon` to `games/yourgame.talon`
2. Replace `yourgame` with your game name
3. Define your voice commands (see examples below)
4. Say "game mode" then "game yourgame"

## Voice Command Syntax

### Simple Key Press
```talon
whale: user.game_key("w")
jump: user.game_key("space")
```
Keys are held for 80ms by default (configurable).

### Multiple Keys in Sequence
```talon
whale air: user.game_keys("w a")
combo attack: user.game_keys("q w e r")
```
Default 50ms delay between keys (configurable).

### Repeat a Key
```talon
air five: user.game_repeat("a", 5)
jump three: user.game_repeat("space", 3)
```

### Custom Hold Duration
```talon
big jump: user.game_key("space", 150)
```
Hold space for 150ms instead of default 80ms.

### Combo with Custom Delay
```talon
special combo: user.game_combo("q w e", 100)
```
Press q, wait 100ms, press w, wait 100ms, press e.

### Simultaneous Keys
```talon
strafe shoot: user.game_simultaneous("shift space")
```
Press shift and space at the same time.

## Configuration

Settings can be adjusted globally in your settings.talon:

```talon
settings():
    # How long to hold each key (milliseconds)
    user.game_hold_duration = 80
    
    # Delay between sequential key presses (milliseconds)
    user.game_sequence_delay = 50
```

## Examples

See `games/digimon.talon` for a complete example.

## How It Works

- **Game Mode**: Disables all other Talon commands for better voice recognition
- **betterinput**: Uses the betterinput library for reliable key holds that games can detect
- **Per-Game Files**: Each game gets its own `.talon` file with commands
- **Automatic Context**: Commands only work when game mode is active

## Troubleshooting

**Commands not recognized:**
- Make sure you said "game mode" first
- Then say "game yourgame" to load your game file
- Check the Talon log for errors

**Keys not working in game:**
- Increase `user.game_hold_duration` (some games need longer holds)
- Make sure the game window is focused

**betterinput not found:**
- Clone betterinput into your Talon user directory
- Falls back to basic implementation if not available

## Sharing Game Files

To share your game configuration:
1. Copy your `games/yourgame.talon` file
2. Send it to friends
3. They drop it in their `talon-games/games/` folder
4. It works immediately!

## Advanced: Future Extensions

Not yet implemented but designed for:
- Auto-detection of game windows
- Saved macro sequences
- Mouse control integration
- Game-specific settings per file
