cursorPosX, cursorPosY = reaper.GetMousePosition()
windowPosX = cursorPosX - 145
windowPosY = cursorPosY - 145

gfx.init(Palette, 280, 280, false, windowPosX, windowPosY)
