local first_sel = reaper.GetSelectedTrack(0, 0)
if not first_sel then return end

reaper.Undo_BeginBlock()
reaper.PreventUIRefresh(1)

local idx = reaper.GetMediaTrackInfo_Value(first_sel, 'IP_TRACKNUMBER') - 1
reaper.InsertTrackAtIndex(idx, true)
local bus = reaper.GetTrack(0, idx)
reaper.GetSetMediaTrackInfo_String(bus, 'P_NAME', 'BUS', true)
reaper.SetMediaTrackInfo_Value(bus, 'D_PANLAW', 1.0)

for i = 0, reaper.CountSelectedTracks(0) - 1 do
local tr = reaper.GetSelectedTrack(0, i)
reaper.SetMediaTrackInfo_Value(tr, 'B_MAINSEND', 0)

local send = reaper.CreateTrackSend(tr, bus)
reaper.SetTrackSendInfo_Value(tr, 0, send, 'D_VOL', 1)
reaper.SetTrackSendInfo_Value(tr, 0, send, 'I_SENDMODE', 0)    
end

reaper.PreventUIRefresh(-1)
reaper.TrackList_AdjustWindows(false)
reaper.UpdateArrange()
reaper.Undo_EndBlock('Create bus before selected tracks and reroute them', 0)
