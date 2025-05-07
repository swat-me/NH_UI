# NH UI
*This is currently unfinished, expect many bugs & a lack of features*

### Booting the Library
```lua
local NH_UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/swat-me/NH_UI/refs/heads/main/UI.lua"))()
```

### Creating a Window
```lua
local Window = NH_UI:NewWindow(
	"Nihility Hub", -- Name of the window | required
	"rbxassetid://73151158551827", -- Icon on animation | optional
	"LeftControl" -- Keybind to close & open the window | optional | https://create.roblox.com/docs/reference/engine/enums/KeyCode
)
```

### Creating a Tab
```lua
local Tab = Window:NewTab(
  "Tab", -- Name of the tab | required
  "A Random Tab" -- Info about the tab | optional
)
```

### Creating a Button
```lua
local Button = Tab:NewButton(
  "Button", -- Name of the button | required
  "A Button that prints 'hi'", -- Info about the button | optional
  function() -- The function of the button | required
      print("hi")
  end
)
```

### Creating a Toggle
```lua
-- too lazy (will do later)
```

### Creating a Dropdown
```lua
-- too lazy (will do later)
```
