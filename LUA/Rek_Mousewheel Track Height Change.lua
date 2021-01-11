is_new_value,filename,sectionID,cmdID,mode,resolution,val = reaper.get_action_context()
if is_new_value then
 x, y = reaper.GetMousePosition()
 track, _ = reaper.GetTrackFromPoint(x,y)
   if track then
   old_height = reaper.GetMediaTrackInfo_Value(track,"I_TCPH")
    if val > 0 then
    reaper.SetMediaTrackInfo_Value(track, "I_HEIGHTOVERRIDE", (old_height+15))
    else
    reaper.SetMediaTrackInfo_Value(track, "I_HEIGHTOVERRIDE", (old_height-15))   
    end
   end
end
reaper.TrackList_AdjustWindows(false)
reaper.UpdateArrange()
reaper.defer()
