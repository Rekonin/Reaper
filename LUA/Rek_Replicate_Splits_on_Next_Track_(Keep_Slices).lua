--Adapted from script, original author: X-Raym

function save_item_selection()
  save_item = {}
  for f = 0, count_sel_items - 1 do
    save_item[f+1] = reaper.GetSelectedMediaItem(0, f)
  end
end

function table_count(tt, item)
  local count
  count = 0
  for ii,xx in pairs(tt) do
    if item == xx then count = count + 1 end
  end
  return count
end

function table_unique(tt)
  local newtable
  newtable = {}
  for ii,xx in ipairs(tt) do
    if(table_count(newtable, xx) == 0) then
      newtable[#newtable+1] = xx
    end
  end
  return newtable
end

function GetSplitPoints()

  split_all = {}

  for i = 0, count_sel_tracks -1 do
    local track = reaper.GetSelectedTrack(0, i) -- Get selected track 0
    local item_on_tracks = reaper.CountTrackMediaItems(track)
    for j = 0, item_on_tracks-1  do
    local item = reaper.GetTrackMediaItem(track, j) -- Get selected item i
      local item_len = reaper.GetMediaItemInfo_Value(item, "D_LENGTH")
      local item_pos = reaper.GetMediaItemInfo_Value(item, "D_POSITION")
      local item_end = item_pos + item_len

      table.insert(split_all, item_pos)
      table.insert(split_all, item_end)

    end

  end

  split_pos = table_unique(split_all)

  table.sort(split_pos)

  return split_pos

end

function main()

  for i, item in ipairs(save_item) do

    item_pos = reaper.GetMediaItemInfo_Value(item, "D_POSITION")
    item_end = reaper.GetMediaItemInfo_Value(item, "D_LENGTH") + item_pos

    -- SPLIT ITEMS
    for j, pos in ipairs(split_pos) do

      if pos < item_end and pos > item_pos then
        item = reaper.SplitMediaItem(item, pos)
      end

      if pos > item_end then break end
    end

  end

end

count_sel_tracks = reaper.CountSelectedTracks(0)
count_sel_items = reaper.CountSelectedMediaItems(0)

if count_sel_tracks > 0 and count_sel_items > 0 then

reaper.PreventUIRefresh(1);
reaper.Undo_BeginBlock();

GetSplitPoints()
save_item_selection()
main()

reaper.UpdateArrange()

reaper.Undo_EndBlock("Replicate Splits on Next Track (Keep Slices)",-1);
reaper.PreventUIRefresh(-1);

end
