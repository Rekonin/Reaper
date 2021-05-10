local msr = 16
local moveview = 0

local r = reaper

local time = r.TimeMap_GetMeasureInfo(0, msr)

local play_st = r.GetPlayState()
if (play_st == 0 or play_st == 2) and r.GetCursorPosition() == time then return end

r.Undo_BeginBlock()
r.SetEditCurPos2(0, time, moveview, 0)
r.Undo_EndBlock('Go to measure'..' '..msr, 2)
