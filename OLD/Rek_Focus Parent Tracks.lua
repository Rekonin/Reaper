reaper.PreventUIRefresh(1)
reaper.Undo_BeginBlock()



trackHeight_A = 26;
trackHeight_B = 50;
trackHeight_C = 75;

reaper.Main_OnCommand(40296, 0) --Track: Select all tracks

reaper.Main_OnCommand(reaper.NamedCommandLookup("_SWS_UNSELPARENTS"), 0)

for i = 0, reaper.CountSelectedTracks(0) - 1 do
  local selTrack = reaper.GetSelectedTrack(0, i)
  reaper.SetMediaTrackInfo_Value(selTrack, 'I_HEIGHTOVERRIDE', trackHeight_A)
end

reaper.Main_OnCommand(reaper.NamedCommandLookup("_SWS_TOGTRACKSEL"), 0)

for i = 0, reaper.CountSelectedTracks(0) - 1 do
  local selTrack = reaper.GetSelectedTrack(0, i)
  reaper.SetMediaTrackInfo_Value(selTrack, 'B_HEIGHTLOCK', 0)
  reaper.SetMediaTrackInfo_Value(selTrack, 'I_FOLDERCOMPACT', 1)
  reaper.SetMediaTrackInfo_Value(selTrack, 'I_HEIGHTOVERRIDE', trackHeight_C)
end

reaper.Main_OnCommand(40297, 0) --Track: Unselect (clear selection of) all tracks

reaper.TrackList_AdjustWindows(0)



reaper.Undo_EndBlock("Focus Parent Tracks", -1)
reaper.PreventUIRefresh(-1)
