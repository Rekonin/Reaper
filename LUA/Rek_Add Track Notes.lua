local NameFX = 'VST:Track Notes'

reaper.PreventUIRefresh(1);
reaper.Undo_BeginBlock();

NameFX = NameFX:gsub('.+:%s+','');

SelTrack = reaper.GetSelectedTrack(0, 0);
reaper.TrackFX_AddByName(SelTrack, NameFX, true, -1)

reaper.Undo_EndBlock('Add Track Notes', -1);
reaper.PreventUIRefresh(-1);
