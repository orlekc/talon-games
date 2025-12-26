# Talon Games

**Talon Games is a simple script library that makes playing games using talon easier.**

Control video games with your voice using [Talon Voice](https://talonvoice.com/). When you activate game mode, all non-gaming Talon commands are disabled, dramatically improving voice recognition accuracy. Each game gets its own isolated set of commands, making recognition faster and more reliable.

## Features

- **Better Recognition**: Disables all other Talon commands when gaming - only your game's commands are active
- **Game Isolation**: Each game has its own command set - no conflicts between games
- **Reliable Input**: Uses [betterinput](https://github.com/lucillablessing/betterinput) to ensure keypresses are detected by games
- **Easy to Share**: One `.talon` file per game - share your game configs with friends
- **Zero Configuration**: Drop a game file in the `games/` folder and it's automatically discovered(needs Talon restart)

## Installation

1. **Clone this repository** into your Talon user folder:
   ```bash
   cd ~/talon/user  # or C:\Users\YourName\AppData\Roaming\talon\user on Windows
   git clone https://github.com/yourusername/talon-games.git
   ```

2. **Install betterinput** (required dependency):
   ```bash
   cd ~/talon/user
   git clone https://github.com/lucillablessing/betterinput.git
   ```

3. **Restart Talon** - game commands are now available!

## Quick Start

1. Say **"game mode"** to enter game mode (disables all other Talon commands)
2. Say **"game pokemon"** (or your game name) to load that game's controls
3. Use voice commands like "whale" (W), "air five" (press A 5 times), etc.
4. Say **"game off"** to exit and restore normal Talon

## Creating a New Game

1. Copy `games/template.talon` to `games/yourgame.talon`
2. Replace `yourgame` with your game name in the tag line
3. Define your voice commands (see API reference below)
4. Commands are automatically available - no other setup needed!

## API Reference

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

### Hold with Duration Multiplier
```talon
each <number_small>: user.game_hold("w", number_small)
charge five: user.game_hold("space", 5)
```
Hold a key for (number × 100) milliseconds. Saying "each five" holds W for 500ms. Perfect for charging abilities or long presses in games.

### Toggle Keys On/Off
```talon
red: user.game_toggle("w")
auto run: user.game_toggle("shift")
```
Toggle a key to stay pressed. First call holds the key down, second call releases it. Useful for auto-run, continuous movement, or sustained actions like crouching.

## Configuration

Settings can be adjusted globally in your `settings.talon`:

```talon
settings():
    # How long to hold keys (milliseconds)
    user.game_key_hold_ms = 80
    
    # Delay between sequential keys (milliseconds)
    user.game_key_delay_ms = 50
```

## Why Voice Recognition is Improved

**The Problem**: Normal Talon has thousands of active commands. When you say "whale", Talon has to check if you meant "whale", "wail", "well", "wall", "while", or hundreds of other similar-sounding words and commands.

**The Solution**: Game mode disables ALL other Talon commands. When playing Pokemon with only 30 game commands active, your voice recognition accuracy dramatically improves because Talon only matches against those 30 words instead of thousands.

**Per-Game Isolation**: Each game file has its own tag. Only the active game's commands work - Pokemon commands don't interfere with Digimon commands.

## How It Works

- **Game Mode**: Disables all other Talon commands (command mode off, `user.game_mode` on)
- **Auto-Discovery**: Scans `games/` folder and automatically registers all games
- **Tag-Based Activation**: Each game has a unique tag (e.g., `user.game_pokemon`), only one active at a time
- **betterinput Integration**: Uses betterinput for reliable key holds (80ms default ensures games detect them)
- **Toggle State Tracking**: Remembers which keys are toggled on and automatically releases them when exiting game mode
- **Zero Configuration**: Drop a `.talon` file in `games/`, it's immediately available

## Examples

See the included game files for complete examples:
- `games/pokemon.talon` - RPG controls with movement and menu navigation
- `games/inkbound.talon` - Turn-based tactical game with abilities and combat
- `games/template.talon` - Template with all available functions documented

## Sharing Game Files

To share your game configuration:
1. Copy your `games/yourgame.talon` file
2. Send it to friends
3. They drop it in their `talon-games/games/` folder
4. It works immediately - no configuration needed!

## Troubleshooting

**Commands not recognized:**
- Make sure you said "game mode" first
- Then say "game yourgame" to load your game file
- Check the Talon log for errors

**Keys not registering in game:**
- Increase hold duration: `user.game_key("w", 150)` 
- Check that betterinput is installed correctly
- Try running Talon as administrator on Windows

## Contributing

Have a great game configuration? Submit a PR with your `.talon` file in the `games/` folder! Help build a library of voice-controlled games.

## Requirements

- [Talon Voice](https://talonvoice.com/)
- [betterinput](https://github.com/lucillablessing/betterinput)

## License

MIT - Feel free to use, modify, and share!
