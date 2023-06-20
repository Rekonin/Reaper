reaper.PreventUIRefresh(1)
reaper.Undo_BeginBlock()

reaper.Main_OnCommand(40296, 0) --Track: Select all tracks
reaper.Main_OnCommand(reaper.NamedCommandLookup('_SWS_UNSELPARENTS'), 0)

reaper.Undo_EndBlock('Select All Non-Parent Tracks', -1)
reaper.PreventUIRefresh(-1)
