script_title = 'Copy selected area of active take to new track'

reaper.Undo_BeginBlock()
reaper.PreventUIRefresh(1)

item = reaper.GetSelectedMediaItem(0,0)
startOut, endOut = reaper.GetSet_LoopTimeRange2(0, false, false, 0, 0, false)

if item == nil then return end
take = reaper.GetActiveTake(item)
if take == nil then return end

takenum = reaper.GetMediaItemTakeInfo_Value(take,'IP_TAKENUMBER')
itempos = reaper.GetMediaItemInfo_Value(item, 'D_POSITION')
itemlen = reaper.GetMediaItemInfo_Value(item, 'D_LENGTH')

if itempos >= startOut and itempos < endOut
  or startOut >= itempos and startOut < itempos+itemlen
  then
  reaper.ApplyNudge(0, 2, 5, 0, 1, false, 1)
  track = reaper.GetMediaItemTake_Track(take)
  tracknum = reaper.GetMediaTrackInfo_Value(track, 'IP_TRACKNUMBER')
  reaper.InsertTrackAtIndex(tracknum, false)
  dest_track = reaper.GetTrack(0, tracknum)
  reaper.TrackList_AdjustWindows(false)
  reaper.MoveMediaItemToTrack(item, dest_track)
  reaper.SetActiveTake(take)
  reaper.Main_OnCommand(40131, 0) --Crop to active take
  reaper.SetMediaItemInfo_Value(item, 'D_POSITION',itempos)
  reaper.BR_SetItemEdges(item, startOut, endOut)
end  

reaper.PreventUIRefresh(-1)
reaper.UpdateArrange()
reaper.Undo_EndBlock(script_title, 0)
