reaper.PreventUIRefresh(1)
reaper.Undo_BeginBlock()

local item = reaper.GetSelectedMediaItem(0,0)
if not item then return end
local take = reaper.GetActiveTake(item)
if not take then return end

local newItem = reaper.AddMediaItemToTrack(reaper.GetMediaItemTake_Track(take))
local newTake = reaper.AddTakeToMediaItem(newItem)
reaper.SetMediaItemTake_Source(newTake, reaper.GetMediaItemTake_Source(take))
reaper.SetMediaItemInfo_Value(newItem, 'D_POSITION', reaper.GetMediaItemInfo_Value(item, 'D_POSITION'))
reaper.SetMediaItemInfo_Value(newItem, 'D_LENGTH', reaper.GetMediaItemInfo_Value(item, 'D_LENGTH'))
for i, key in pairs({ 'D_STARTOFFS', 'D_VOL', 'D_PAN', 'D_PANLAW', 'D_PLAYRATE', 'D_PITCH',
                      'B_PPITCH', 'I_CHANMODE', 'I_PITCHMODE', 'I_CUSTOMCOLOR', 'IP_TAKENUMBER' }) do
    local value = reaper.GetMediaItemTakeInfo_Value(take, key)
    reaper.SetMediaItemTakeInfo_Value(newTake, key, value)
end

reaper.Main_OnCommand(40129, 0) -- delete active take
reaper.SetMediaItemSelected(item, false)
reaper.SetMediaItemSelected(newItem, true)

take = reaper.GetActiveTake(item)
track = reaper.GetMediaItemTake_Track(take)
tracknum = reaper.GetMediaTrackInfo_Value(track, "IP_TRACKNUMBER")
reaper.InsertTrackAtIndex(tracknum, false)
reaper.Main_OnCommand(40118, 0) -- move take down

reaper.Undo_EndBlock('Move active take to new item', 0)
reaper.PreventUIRefresh(-1)
reaper.UpdateArrange()
