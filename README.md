<picture>
  <source media="(prefers-color-scheme: dark)" srcset="media/title_dark.png">
  <img alt="LevelUpScreenshot" src="media/title_light.png">
</picture>

# LevelUpScreenshot

A World of Warcraft addon that takes a screenshot every time you level up, with your name and new level shown in chat.

- **Automatic screenshots on level-up.** No key to press.
- **Name and level in the picture.** A line like **"Thrall reached level 42!"** appears in your chat right before the screenshot.
- **Level-up screenshots stand out.** They are saved as **PNG** by default, while your normal screenshots keep their usual format.
- **Your settings stay untouched.** The format is switched only for the level-up shot and restored right after, even if the game crashes in between.
- **Lightweight.** It only does something when you level up.

## Install

Install it from CurseForge, or copy the `LevelUpScreenshot` folder into:

```
World of Warcraft\_retail_\Interface\AddOns\
```

(use `_classic_era_`, `_anniversary_` or `_classic_` for the Classic versions).

## Commands

| Command | What it does |
|---|---|
| `/lus` | Shows the status: enabled or disabled, delay and screenshot format |
| `/lus help` | Lists all commands |
| `/lus test` | Takes a test screenshot right now, exactly like a real level-up |
| `/lus on` / `/lus off` | Turns automatic level-up screenshots on or off |
| `/lus delay <seconds>` | Sets the wait time before the screenshot, from 0.2 to 5 seconds (default: 0.2) |
| `/lus format png\|jpg\|tga` | Sets the level-up screenshot format (TGA is Windows only) |
| `/lus reset` | Restores all settings to their defaults |

## Compatibility

Retail (Midnight), Classic Era, TBC Anniversary and MoP Classic.

## License

MIT, see [LICENSE](LICENSE).
