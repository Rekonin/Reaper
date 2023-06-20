local itemCount = reaper.CountSelectedMediaItems(0);

if reaper.CountSelectedMediaItems(0) < 1 then
    return
  else
    reaper.Main_OnCommand(40061, 0); --Item: Split items at time selection
end

