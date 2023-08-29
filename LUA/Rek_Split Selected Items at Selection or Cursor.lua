local itemCount = reaper.CountSelectedMediaItems(0);

if reaper.CountSelectedMediaItems(0) < 1 then
    return
  else

    timeStart, timeEnd = reaper.GetSet_LoopTimeRange(0, 0, 0, 0, 0)

    reaper.Undo_BeginBlock()

    if timeStart == 0 and timeEnd == 0 then
        reaper.Main_OnCommand(40757, 0)
      else
        reaper.Main_OnCommand(40061, 0)
    end

    reaper.Undo_EndBlock('Split Selected Items at Selection or Cursor', -1)

end
