playState = reaper.GetPlayState()
numMarkers = reaper.CountProjectMarkers(0)

if playState > 0 then
  reaper.Main_OnCommand(1016, 0) --Transport: Stop
  else
  
  if numMarkers > 0 then
    reaper.Main_OnCommand(40161, 0) --Markers: Go to marker 01
    reaper.Main_OnCommand(1007, 0)  --Transport: Play
    else
    reaper.Main_OnCommand(40042, 0) --Transport: Go to start of project
    reaper.Main_OnCommand(1007, 0)  --Transport: Play
  end
end
