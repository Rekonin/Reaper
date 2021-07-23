reaper.PreventUIRefresh(1)
reaper.Undo_BeginBlock()

reaper.Main_OnCommand(40340, 0) --Track: Unsolo all tracks
reaper.Main_OnCommand(reaper.NamedCommandLookup("_SWS_SELALLPARENTS"), 0)
reaper.Main_OnCommand(40728, 0) --Track: Solo tracks

reaper.Undo_EndBlock("Solo All Parent Tracks", -1)
reaper.PreventUIRefresh(-1)
