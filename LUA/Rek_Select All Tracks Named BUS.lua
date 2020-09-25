reaper.PreventUIRefresh(1)
reaper.Undo_BeginBlock()

reaper.Main_OnCommand(40297,0) --Track: Unselect all tracks

for i = 1, reaper.CountSelectedTracks(0) do
  tr = reaper.GetSelectedTrack(0,i-1)
  _, tr_name = reaper.GetSetMediaTrackInfo_String(tr, 'P_NAME', '', false)
  tr_name_last_sym = string.upper(string.sub(tr_name,-3))
  if tr_name_last_sym == 'BUS' then reaper.SetTrackSelected(tr, 1) end
end

reaper.Undo_EndBlock('Select All Tracks with BUS in Name', -1)
reaper.PreventUIRefresh(-1)
