local haveTrack = reaper.CountSelectedTracks();
if haveTrack < 1 then return reaper.defer(function() end) end;

reaper.Undo_BeginBlock()

selTrack = reaper.GetSelectedTrack(0, 0);
receiveCount = reaper.GetTrackNumSends(selTrack, -1);

for i = 0, receiveCount-1 do
  reaper.SetTrackSendInfo_Value(selTrack, 0, i, "I_SENDMODE", -1);
end

reaper.Undo_EndBlock("Set All Sends to Pre-Fader", 0);
