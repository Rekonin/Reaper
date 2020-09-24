reaper.PreventUIRefresh(1)
reaper.Undo_BeginBlock()

reaper.Main_OnCommand(40161, 0) --Markers: Go to marker 01
reaper.Main_OnCommand(40044, 0) --Transport: Play/stop

reaper.Undo_EndBlock('Play from Marker 1', -1)
reaper.PreventUIRefresh(-1)
