reaper.PreventUIRefresh(1);
reaper.Undo_BeginBlock();

reaper.Main_OnCommand(41147, 0); --Track: Insert new track at end of mixer

tracknum = reaper.CountSelectedTracks(0)

for i = 0, tracknum - 1, 1 do
  reaper.SetMediaTrackInfo_Value(reaper.GetSelectedTrack(tracknum, i), "I_RECINPUT", 0 | 0 | (0 << 0))
end

reaper.Undo_EndBlock("Add New Track - Input 1",-1);
reaper.PreventUIRefresh(-1);
