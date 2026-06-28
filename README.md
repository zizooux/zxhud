# zxhud — FiveM HUD Resource

A custom FiveM HUD resource featuring a dark cyberpunk UI with warm gold (#967969) accent color, minimap integration, camera status indicator, and smooth animations.

## Features
- Dark cyberpunk theme with gold accent (#967969)
- Custom minimap overlay
- Camera status indicator (icon turns green when inside a monitored zone)
- Camera zone ability — triggers automatically when player enters a surveillance area
- Gear, speed, fuel, and engine displays
- Smooth CSS animations and glassmorphism panels

## Camera Zone Ability
When a player enters a configured camera zone, the HUD detects it and can trigger server-side or client-side abilities such as:
- Notify nearby police / authorities
- Log the player's presence in the zone
- Trigger wanted level or alert system
- Block or allow certain actions inside the zone

## Installation
1. Drop the `zxhud` folder into your `resources` directory
2. Add `ensure zxhud` to your `server.cfg`
3. Restart your server

## Configuration
Edit `config.lua` to add or remove camera zones:
```lua
Config.CameraZones = {
    {
        label  = "Police Station – Mission Row",
        coords = vector3(399.09, -1007.39, 56.67),
        radius = 120.0,
    },
    -- Add more zones here
}

Config.ZoneCheckInterval = 600 -- ms, lower = more responsive
```

## Dependencies
- `/assetpacks`

## Credits
Made by zizooux

<img width="661" height="370" alt="image" src="https://github.com/user-attachments/assets/7c3b0f7f-44dc-4b87-bcea-10118dc1cf2b" />

