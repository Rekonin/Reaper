reaper.PreventUIRefresh(1);
reaper.Undo_BeginBlock();

reaper.Main_OnCommand(41147, 0); --Track: Insert new track at end of mixer

tracknum = reaper.CountSelectedTracks(0)

for i = 0, tracknum - 1, 1 do
  reaper.SetMediaTrackInfo_Value(reaper.GetSelectedTrack(tracknum, i), "I_RECINPUT", 4096 | 0 | (63 << 5))
end

reaper.Undo_EndBlock("Add New Track - MIDI All",-1);
reaper.PreventUIRefresh(-1);
