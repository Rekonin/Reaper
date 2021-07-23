reaper.PreventUIRefresh(1);
reaper.Undo_BeginBlock();

reaper.Main_OnCommand(40296, 0) --Track: Select all tracks
reaper.Main_OnCommand(reaper.NamedCommandLookup("_XENAKIOS_SELTRAX_RECUNARMED"), 0)
reaper.Main_OnCommand(40297, 0) --Track: Unselect all tracks
reaper.Main_OnCommand(41147, 0); --Track: Insert new track at end of mixer
reaper.Main_OnCommand(reaper.NamedCommandLookup("_XENAKIOS_SELTRAX_RECARMED"), 0)

tracknum = reaper.CountSelectedTracks(0)
for i = 0, tracknum - 1, 1 do
  reaper.SetMediaTrackInfo_Value(reaper.GetSelectedTrack(tracknum, i), "I_RECINPUT", 0 | 0 | (0 << 0))
  reaper.Main_OnCommand(40493, 0) --Track: Set track record monitor to on
end

reaper.Undo_EndBlock("Add New Track - Input 1",-1);
reaper.PreventUIRefresh(-1);
