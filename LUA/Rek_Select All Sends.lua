function nothing()
end

reaper.Undo_BeginBlock()

reaper.Main_OnCommand(40297, 0) --Track: Unselect all tracks
t_cnt = reaper.CountTracks(0)
if t_cnt > 0 then
  
  for t = 0, t_cnt-1 do
    tr = reaper.GetTrack(0,t)
    if reaper.GetTrackNumSends(tr, 0) > 0 then
      reaper.SetMediaTrackInfo_Value(tr, "I_SELECTED", 1)
    end
  end

  reaper.Undo_EndBlock("Select all sends", -1)
else
  reaper.defer(nothing)
end
