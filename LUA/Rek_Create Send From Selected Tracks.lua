local first_sel = reaper.GetSelectedTrack(0, 0)
if not first_sel then return end

local sendTrackPosition = reaper.CountTracks(0) + 1
reaper.ShowConsoleMsg(sendTrackPosition)

reaper.Undo_BeginBlock()
reaper.PreventUIRefresh(1)

local idx = reaper.GetMediaTrackInfo_Value(first_sel, 'IP_TRACKNUMBER')
reaper.InsertTrackAtIndex(sendTrackPosition, true)
local sendTrackIDX = reaper.GetTrack(0, idx)

for i = 0, reaper.CountSelectedTracks(0) - 1 do
local tr = reaper.GetSelectedTrack(0, i)

local send = reaper.CreateTrackSend(tr, sendTrackIDX)
reaper.SetTrackSendInfo_Value(tr, 0, send, 'D_VOL', 1)
reaper.SetTrackSendInfo_Value(tr, 0, send, 'I_SENDMODE', 0)
end

reaper.Main_OnCommand(reaper.NamedCommandLookup('_XENAKIOS_INSTRACKLABPREF'), 0)
reaper.Main_OnCommand(reaper.NamedCommandLookup('_SWSAUTOCOLOR_APPLY'), 0)

reaper.PreventUIRefresh(-1)
reaper.Undo_EndBlock('Create send before selected tracks and reroute them', 0)

reaper.TrackList_AdjustWindows(false)
reaper.UpdateArrange()
