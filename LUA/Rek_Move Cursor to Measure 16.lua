local msr = 16
local moveview = 0

local time = reaper.TimeMap_GetMeasureInfo(0, msr)

local play_st = reaper.GetPlayState()
if (play_st == 0 or play_st == 2) and reaper.GetCursorPosition() == time then return end

reaper.Undo_BeginBlock()
reaper.SetEditCurPos2(0, time, moveview, 0)
reaper.Undo_EndBlock('Go to measure'..' '..msr, 2)
