hs.window.animationDuration = 0

local mashshift = {"cmd", "alt", "shift"}

function reloadConfig(files)
  local doReload = false
  for _,file in pairs(files) do
    if file:sub(-4) == ".lua" then
      doReload = true
    end
  end
  if doReload then
    hs.reload()
    hs.alert.show('Config Reloaded')
  end
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()

function bindKey(key, fn)
  hs.hotkey.bind({"cmd", "ctrl"}, key, fn)
end

positions = {
  maximized = hs.layout.maximized,
  centered = {x=0.15, y=0.15, w=0.7, h=0.7},
  centeredWithGutter = {x=0.0017, y=0.025, w=0.9963, h=0.948},

  left17 = {x=0, y=0, w=0.17, h=1},
  left25 = {x=0, y=0, w=0.25, h=1},
  left34 = {x=0, y=0, w=0.34, h=1},
  left50 = hs.layout.left50,
  left66 = {x=0, y=0, w=0.66, h=1},
  left70 = hs.layout.left70,
  left75 = {x=0, y=0, w=0.75, h=1},
  left83 = {x=0, y=0, w=0.83, h=1},

  right17 = {x=0.83, y=0, w=0.17, h=1},
  right25 = {x=0.75, y=0, w=0.25, h=1},
  right30 = hs.layout.right30,
  right34 = {x=0.66, y=0, w=0.34, h=1},
  right50 = hs.layout.right50,
  right66 = {x=0.34, y=0, w=0.66, h=1},
  right75 = {x=0.25, y=0, w=0.75, h=1},
  right83 = {x=0.17, y=0, w=0.83, h=1},

  upper50 = {x=0, y=0, w=1, h=0.5},
  upper50Left50 = {x=0, y=0, w=0.5, h=0.5},
  upper50Right15 = {x=0.85, y=0, w=0.15, h=0.5},
  upper50Right30 = {x=0.7, y=0, w=0.3, h=0.5},
  upper50Right50 = {x=0.5, y=0, w=0.5, h=0.5},

  lower50 = {x=0, y=0.5, w=1, h=0.5},
  lower50Left50 = {x=0, y=0.5, w=0.5, h=0.5},

  lower50Right17 = {x=0.83, y=0.5, w=0.17, h=0.5},
  lower50Right25 = {x=0.75, y=0.5, w=0.25, h=0.5},
  lower50Right34 = {x=0.66, y=0.5, w=0.34, h=0.5},
  lower50Right50 = {x=0.50, y=0.5, w=0.50, h=0.5},
  lower50Right66 = {x=0.34, y=0.5, w=0.66, h=0.5},
  lower50Right75 = {x=0.25, y=0.5, w=0.75, h=0.5},
  lower50Right83 = {x=0.17, y=0.5, w=0.83, h=0.5},

  leftThird = {x=0, y=0, w=0.33, h=1},
  leftTwoThirds = {x=0, y=0, w=0.67, h=1},
  middleThird = {x=0.33, y=0, w=0.33, h=1},
  middleTwoThirds = {x=0.17, y=0, w=0.66, h=1},
  rightTwoThirds = {x=0.33, y=0, w=0.67, h=1},
  rightThird = {x=0.66, y=0, w=0.34, h=1},

  leftFourth = {x=0, y=0, w=0.25, h=1},
  leftTwoFourth = {x=0, y=0, w=0.50, h=1},
  leftMiddleFourth = {x=0.25, y=0, w=0.25, h=1},
  middleTwoFourth = {x=0.25, y=0, w=0.50, h=1},
  rightMiddleFourth = {x=0.50, y=0, w=0.25, h=1},
  rightTwoFourth = {x=0.50, y=0, w=0.50, h=1},
  rightFourth = {x=0.75, y=0, w=0.25, h=1},

  chat = {x=0.5, y=0, w=0.35, h=0.5}
}

--
-- Layouts
--

layouts = {
  -- {
  --   name="Coding",
  --   description="For fun and profit",
  --   small={
  --     {"Microsoft Edge", nil, screen, positions.left70, nil, nil},
  --     {"kitty", nil, screen, positions.right30, nil, nil},
  --   },
  --   large={
  --     {"Microsoft Edge", nil, screen, positions.left50, nil, nil},
  --     {"kitty", nil, screen, positions.upper50Right30, nil, nil},
  --   }
  -- },
}
currentLayout = null

function applyLayout(layout)
  local screen = hs.screen.mainScreen()

  local layoutSize = layout.small
  if layout.large and screen:currentMode().w > 1500 then
    layoutSize = layout.large
  end

  currentLayout = layout
  hs.layout.apply(layoutSize, function(windowTitle, layoutWindowTitle)
    return string.sub(windowTitle, 1, string.len(layoutWindowTitle)) == layoutWindowTitle
  end)
end

layoutChooser = hs.chooser.new(function(selection)
  if not selection then return end

  applyLayout(layouts[selection.index])
end)
i = 0
layoutChooser:choices(hs.fnutils.imap(layouts, function(layout)
  i = i + 1

  return {
    index=i,
    text=layout.name,
    subText=layout.description
  }
end))
layoutChooser:rows(#layouts)
layoutChooser:width(20)
layoutChooser:subTextColor({red=0, green=0, blue=0, alpha=0.4})

bindKey(';', function()
  layoutChooser:show()
end)

hs.screen.watcher.new(function()
  if not currentLayout then return end

  applyLayout(currentLayout)
end):start()

--
-- Grid
--

grid = {
  {
    key="u",
    units={
      positions.upper50Left50,
    }
  },

  {
    key="k",
    units={
      positions.upper50,
    }
  },

  {
    key="o",
    units={
      positions.upper50Right50,
    }
  },

  {
    key="h",
    units={
      positions.left83,
      positions.left75,
      positions.left66,
      positions.left50,
      positions.left34,
      positions.left25,
      positions.left17,
    }
  },

  {
    key="c",
    units={
      positions.centered,
      positions.middleTwoFourth,
      positions.middleTwoThirds,
      positions.maximized,
      positions.centeredWithGutter,
    }
  },

  {
    key="l",
    units={
      positions.right83,
      positions.right75,
      positions.right66,
      positions.right50,
      positions.right34,
      positions.right25,
      positions.right17,
    }
  },

  {
    key="3",
    units={
      positions.leftThird,
      positions.leftTwoThirds,
      positions.middleThird,
      positions.middleTwoThirds,
      positions.rightTwoThirds,
      positions.rightThird
    }
  },

  {
    key="4",
    units={
      positions.leftFourth,
      positions.leftTwoFourth,
      positions.leftMiddleFourth,
      positions.middleTwoFourth,
      positions.rightMiddleFourth,
      positions.rightTwoFourth,
      positions.rightFourth,
    }
  },

  {
    key="m",
    units={
      positions.lower50Left50,
    }
  },

  {
    key="j",
    units={
      positions.lower50,
    }
  },

  {
    key=".",
    units={
      positions.lower50Right83,
      positions.lower50Right75,
      positions.lower50Right66,
      positions.lower50Right50,
      positions.lower50Right34,
      positions.lower50Right25,
      positions.lower50Right17,
    }
  },
}

hs.fnutils.each(grid, function(entry)
  bindKey(entry.key, function()
    local units = entry.units
    local screen = hs.screen.mainScreen()
    local window = hs.window.focusedWindow()
    local windowGeo = window:frame()

    local index = 0
    hs.fnutils.find(units, function(unit)
      index = index + 1

      local geo = hs.geometry.new(unit):fromUnitRect(screen:frame()):floor()
      return windowGeo:equals(geo)
    end)
    if index == #units then index = 0 end

    currentLayout = null
    window:moveToUnit(units[index + 1])
  end)
end)
