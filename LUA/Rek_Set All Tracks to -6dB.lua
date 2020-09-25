local function no_undo();reaper.defer(function()end);end;
local CountTrack = reaper.CountTracks(0);

if CountTrack == 0 then no_undo() return end;

reaper.Undo_BeginBlock();

for i = 1, CountTrack do;
  local Track = reaper.GetTrack(0, i-1);
  reaper.SetMediaTrackInfo_Value(Track,"D_VOL",(10^(-6/20)));
end;

reaper.Undo_EndBlock("Set Volume All Tracks to -6dB",-1);
reaper.UpdateArrange();
