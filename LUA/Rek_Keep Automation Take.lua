reaper.PreventUIRefresh(1)
reaper.Undo_BeginBlock()


reaper.Main_OnCommand(40622, 0) --Time selection: Copy time selection to loop points
local timeSelStart,timeSelEnd = reaper.GetSet_LoopTimeRange2(0,false,true,0,0,false)
reaper.SetEditCurPos2(0,timeSelStart,false,false)

reaper.Main_OnCommand(40061, 0) --Item: Split items at time selection
reaper.Main_OnCommand(40057, 0) --Edit: Copy items/tracks/envelope points (depending on focus) ignoring time selection

reaper.Main_OnCommand(reaper.NamedCommandLookup('_XENAKIOS_SELPREVTRACK'), 0)
reaper.Main_OnCommand(42398, 0) --Item: Paste items/tracks
--reaper.Main_OnCommand(40209, 0) --Item: Apply track/take FX to items
--reaper.Main_OnCommand(41999, 0) --Item: Render items to new take
reaper.Main_OnCommand(40285, 0) --Track: Go to next track



--reaper.Main_OnCommand(, 0)
--reaper.Main_OnCommand(, 0)



reaper.Undo_EndBlock('Keep Automation Take', -1)
reaper.PreventUIRefresh(-1)
