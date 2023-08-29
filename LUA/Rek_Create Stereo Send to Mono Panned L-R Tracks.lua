local sendTrack = reaper.GetSelectedTrack(0, 0)
if not sendTrack then return end



reaper.PreventUIRefresh(1);
reaper.Undo_BeginBlock();



reaper.Main_OnCommand(reaper.NamedCommandLookup('_SWS_DISMPSEND'), 0) --SWS: Disable master/parent send on selected track(s)
reaper.SetMediaTrackInfo_Value(sendTrack, 'I_RECMODE', 2)

local sendTrackIDX = math.floor(reaper.GetMediaTrackInfo_Value(sendTrack, 'IP_TRACKNUMBER'))

reaper.InsertTrackAtIndex(sendTrackIDX, true)
reaper.InsertTrackAtIndex(sendTrackIDX, true)

reaper.Main_OnCommand(40285, 0) --Track: Go to next track
local returnTrack = reaper.GetSelectedTrack(0, 0)
reaper.CreateTrackSend(sendTrack, returnTrack)
reaper.SetTrackSendInfo_Value(returnTrack, -1, 0, 'I_SRCCHAN', 1024)
reaper.SetMediaTrackInfo_Value(returnTrack, 'I_RECMODE', 5)
reaper.SetMediaTrackInfo_Value(returnTrack, 'D_PAN', -1)

reaper.Main_OnCommand(40285, 0) --Track: Go to next track
local returnTrack = reaper.GetSelectedTrack(0, 0)
reaper.CreateTrackSend(sendTrack, returnTrack)
reaper.SetTrackSendInfo_Value(returnTrack, -1, 0, 'I_SRCCHAN', 1025)
reaper.SetMediaTrackInfo_Value(returnTrack, 'I_RECMODE', 5)
reaper.SetMediaTrackInfo_Value(returnTrack, 'D_PAN', 1)



reaper.Undo_EndBlock('Create Stereo Send to Mono Panned L-R Tracks', -1);
reaper.PreventUIRefresh(-1);
