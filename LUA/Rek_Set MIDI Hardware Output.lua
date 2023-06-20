reaper.PreventUIRefresh(1);
reaper.Undo_BeginBlock();

selTrack = reaper.GetSelectedTrack(0, 0)
reaper.SetMediaTrackInfo_Value(selTrack, 'I_MIDIHWOUT', 0 | 3 << 5)

reaper.UpdateArrange()

reaper.Undo_EndBlock('Set MIDI Hardware Output', -1);
reaper.PreventUIRefresh(-1);
