reaper.Undo_BeginBlock()
reaper.PreventUIRefresh(1)

local trackCount = reaper.CountSelectedTracks(0)
if trackCount == 0 then
    reaper.ShowMessageBox('No tracks selected.', 'Error', 0)
    return
end

for i = 0, reaper.CountSelectedTracks(0) - 1 do
  local selTrack = reaper.GetSelectedTrack(0, i)
  local volTrack = reaper.GetMediaTrackInfo_Value(selTrack, 'D_VOL')
  
  reaper.Main_OnCommand(40421, 0); --Item: Select all items in track
  
  for j = 0, reaper.CountMediaItems(0) - 1 do
  
  end
  
  reaper.SetMediaTrackInfo_Value(selTrack, 'D_VOL', '1')
end

reaper.PreventUIRefresh(-1)
reaper.Undo_EndBlock('Rebalance Volume from Track to Media Items', 0)
reaper.UpdateArrange()
