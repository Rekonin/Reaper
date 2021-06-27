local NameFX = "B-3 V2"
--local NamePreset = "My Default"
local TrackName = "B-3"

reaper.PreventUIRefresh(1);
reaper.Undo_BeginBlock();

reaper.Main_OnCommand(40491, 0);
reaper.Main_OnCommand(41147, 0);

NameFX = NameFX:gsub(".+:%s+","");
tracknum = reaper.CountSelectedTracks(0)

for i = 0, tracknum - 1, 1 do
  reaper.SetMediaTrackInfo_Value(reaper.GetSelectedTrack(tracknum, i), "I_RECINPUT", 4096 | (63 << 5))
end

SelTrack = reaper.GetSelectedTrack(0,0);
reaper.TrackFX_AddByName(SelTrack,NameFX,false,-1)
--reaper.TrackFX_SetPreset(SelTrack,0,NamePreset)
if TrackName and TrackName ~= "" then
  reaper.GetSetMediaTrackInfo_String(SelTrack,"P_NAME",TrackName,1)
end
reaper.SetMediaTrackInfo_Value(SelTrack,"I_RECARM",1)

reaper.Undo_EndBlock("Setup VSTi B-3 Organ",-1);
reaper.PreventUIRefresh(-1);
