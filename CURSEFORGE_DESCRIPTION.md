# LevelUpScreenshot

![LevelUpScreenshot](LOGO_IMAGE_URL)

**Never miss a level-up moment again.** LevelUpScreenshot automatically takes a screenshot every time your character levels up, with your name and new level shown in chat, so every screenshot tells you exactly who leveled and when.

---

## Features

- **Automatic screenshots on level-up.** No key to press, nothing to remember. Just keep playing.
- **Name and level in the picture.** Right before the screenshot, a line like **"Thrall reached level 42!"** appears in your chat window, so the screenshot shows who leveled and to which level.
- **Level-up screenshots stand out.** Level-up screenshots are saved as **PNG** by default, while your normal screenshots keep their usual format. That makes them easy to find in your Screenshots folder.
- **Your settings stay untouched.** The addon switches the format only for the level-up shot and restores your normal format right after, even if the game crashes in between.
- **Adjustable timing.** Choose how long to wait after the level-up so the golden level-up effect is in the shot.
- **Lightweight.** No frames, no libraries, no performance impact. It only does something when you level up.
- **Private.** The chat line is visible only to you. Nothing is sent to other players.

![Example level-up screenshot](SCREENSHOT_IMAGE_URL)

---

## Commands

All commands start with `/lus`.

| Command | What it does |
|---|---|
| `/lus` | Shows the current status: enabled or disabled, delay and screenshot format |
| `/lus help` | Lists all commands |
| `/lus test` | Takes a test screenshot right now, exactly like a real level-up |
| `/lus on` | Turns automatic level-up screenshots on |
| `/lus off` | Turns automatic level-up screenshots off |
| `/lus delay <seconds>` | Sets the wait time before the screenshot, from 0.2 to 5 seconds (default: 1) |
| `/lus format png` | Saves level-up screenshots as PNG (default) |
| `/lus format jpg` | Saves level-up screenshots as JPG |
| `/lus format tga` | Saves level-up screenshots as TGA (Windows only) |
| `/lus reset` | Restores all settings to their defaults |

**Examples**

```
/lus test
/lus delay 2
/lus format jpg
```

---

## How it works

1. You level up.
2. A gold line appears in your chat: **"YourName reached level XX!"**
3. After a short delay (1 second by default), the addon takes a screenshot in your chosen format.
4. Your normal screenshot format is restored immediately.

Screenshots are saved in your usual WoW screenshot folder, for example:

```
World of Warcraft\_retail_\Screenshots\
```

---

## Tips

- **Keep your chat window visible** if you want the name and level in the picture. The line is printed in the chat tab you currently have open.
- **Hiding the UI (Alt+Z) also hides the chat line.**
- **Use different formats** for level-up and normal screenshots so you can tell them apart at a glance. For example, keep your normal screenshots as JPG and level-up screenshots as PNG.
- **TGA files are large** and aren't supported on Mac. PNG is the best choice for most players.

---

## Compatibility

- Retail (Midnight)
- Classic Era
- TBC Anniversary
- MoP Classic

---

## Feedback

Found a bug or have an idea? Leave a comment or open an issue. Feedback is always welcome!
