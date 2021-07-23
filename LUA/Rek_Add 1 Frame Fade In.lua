reaper.Undo_BeginBlock()

count = reaper.CountSelectedMediaItems(0)
for i = 0, count -1 do
    local item = reaper.GetSelectedMediaItem(0, i)
    reaper.SetMediaItemInfo_Value(item, "D_FADEINLEN", 1 / reaper.TimeMap_curFrameRate(0), 0, 0)
end

reaper.Undo_EndBlock("Add 1 Frame Fade-in To Start of Item", 0)
