local function nothing() end; local function bla() reaper.defer(nothing) end

local tracks = reaper.CountSelectedTracks()
if tracks < 2 then bla() return end

local first_sel = reaper.GetSelectedTrack(0,0)

local first_sel_items = reaper.CountTrackMediaItems(first_sel)
if first_sel_items == 0 then bla() return end

function item_in_areas(item, ...)

  local pos0 = reaper.GetMediaItemInfo_Value(item, 'D_POSITION')
  local len0 = reaper.GetMediaItemInfo_Value(item, 'D_LENGTH')
  local end0 = pos0+len0
  
  local arg={...}
  for i = 1, #arg, 2 do
    local x,y = arg[i],arg[i+1]

    if pos0 <= x and end0 >= x+0.00001 or
       pos0 <= y-0.00001 and end0 >= y or
       pos0 >= x and end0 <= y then
       return 1
    end

  end
end

split_pos = {}
for i = 0, first_sel_items-1 do
  local tr_item = reaper.GetTrackMediaItem(first_sel, i)
  local pos0 = reaper.GetMediaItemInfo_Value(tr_item, 'D_POSITION')
  local len0 = reaper.GetMediaItemInfo_Value(tr_item, 'D_LENGTH')
  local end0 = pos0+len0
  split_pos[#split_pos+1] = pos0
  split_pos[#split_pos+1] = end0
end

split_pos_sorted = split_pos
table.sort(split_pos_sorted)

s_tracks = {}

for i = 1, tracks-1 do
  local tr = reaper.GetSelectedTrack(0,i)
  s_tracks[#s_tracks+1] = tr
end

split_items = {}

for i = 1, #s_tracks do
  local tr = s_tracks[i]
  
  local tr_items = reaper.CountTrackMediaItems(tr)
  for j = 0, tr_items-1 do
    local tr_item = reaper.GetTrackMediaItem(tr, j)
    split_items[#split_items+1] = tr_item
  end
end

reaper.PreventUIRefresh(1);
reaper.Undo_BeginBlock();

for i = 1, #split_items do
  for j = #split_pos,1,-1 do
    reaper.SplitMediaItem(split_items[i], split_pos_sorted[j])
  end
end


del = {}

for i = 1, #s_tracks do
  local tr = s_tracks[i]
  
  local tr_items = reaper.CountTrackMediaItems(tr)
  for j = 0, tr_items-1 do
    local tr_item = reaper.GetTrackMediaItem(tr, j)
    if not item_in_areas(tr_item, table.unpack(split_pos)) then
      del[tr_item] = tr
    end
  end
end

for item,tr in pairs(del) do reaper.DeleteTrackMediaItem(tr,item) end

reaper.UpdateArrange()

reaper.Undo_EndBlock('Replicate Splits',-1);
reaper.PreventUIRefresh(-1);
