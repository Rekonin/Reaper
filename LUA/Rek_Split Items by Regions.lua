console = false
pos = {}

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

function MultiSplitMediaItem(item, times)

local item_pos = reaper.GetMediaItemInfo_Value(item, 'D_POSITION')
local item_end = reaper.GetMediaItemInfo_Value(item, 'D_LENGTH') + item_pos

local items = {}

table.insert(items, item)

for i, time in ipairs(times) do
  if time > item_end then break end
  if time > item_pos and time < item_end and item then
  item = reaper.SplitMediaItem(item, time)
  table.insert(items, item)
  end
end

  return items

end

function SaveSelectedItems (table)
  for i = 0, reaper.CountSelectedMediaItems(0)-1 do
    table[i+1] = reaper.GetSelectedMediaItem(0, i)
  end
end

function Msg(value)
  if console then
    reaper.ShowConsoleMsg(tostring(value) .. '\n')
  end
end

function GetRegionsPoints()
  local i=0
  repeat
    local iRetval, bIsrgnOut, iPosOut, iRgnendOut, sNameOut, iMarkrgnindexnumberOut, iColorOur = reaper.EnumProjectMarkers3(0, i)
    if iRetval >= 1 then
      if bIsrgnOut == true then
        table.insert(pos, iPosOut)
        table.insert(pos, iRgnendOut)
      end
      i = i+1
    end
  until iRetval == 0
  pos = table_unique(pos)
  table.sort(pos)
end

function main()
  GetRegionsPoints()
  for idx, item in ipairs(init_sel_items) do
      MultiSplitMediaItem(item, pos)
  end
end

count_sel_items = reaper.CountSelectedMediaItems(0)

if count_sel_items > 0 then
  reaper.PreventUIRefresh(1)
  reaper.Undo_BeginBlock()

  init_sel_items =  {}
  SaveSelectedItems(init_sel_items)

  main()

  reaper.Undo_EndBlock('Split selected items at regions', -1)
  reaper.UpdateArrange()
  reaper.PreventUIRefresh(-1)
end
