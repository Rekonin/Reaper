local name = 'BUS'
local tracks = reaper.CountTracks()

if not tracks == 0 then bla() return end

reaper.PreventUIRefresh(1)
reaper.Undo_BeginBlock()

reaper.Main_OnCommand(40297,0) --Track: Unselect all tracks

for i = 0, tracks-1 do
  local tr = reaper.GetTrack(0, i)
  local _, tr_name = reaper.GetSetMediaTrackInfo_String(tr, 'P_NAME', 'BUS', 0)
  if tr_name == name then reaper.SetTrackSelected(tr, 1)
  end;
end;

reaper.Undo_EndBlock('Select track with BUS in name', -1)
reaper.PreventUIRefresh(-1)
