local NameFX = "VST3:AmpliTube 4"
local NamePreset = "Ampeg V-4B"
local TrackName = "Ampeg V-4B"

reaper.PreventUIRefresh(1);
reaper.Undo_BeginBlock();

reaper.Main_OnCommand(40491, 0);
reaper.Main_OnCommand(41147, 0);

NameFX = NameFX:gsub(".+:%s+","");
tracknum = reaper.CountSelectedTracks(0)

for i = 0, tracknum - 1, 1 do
  reaper.SetMediaTrackInfo_Value(reaper.GetSelectedTrack(tracknum, i), "I_RECINPUT", 0)
end

SelTrack = reaper.GetSelectedTrack(0,0);
reaper.TrackFX_AddByName(SelTrack,NameFX,false,-1)
reaper.TrackFX_SetPreset(SelTrack,0,NamePreset)
if TrackName and TrackName ~= "" then
  reaper.GetSetMediaTrackInfo_String(SelTrack,"P_NAME",TrackName,1)
end
reaper.SetMediaTrackInfo_Value(SelTrack,"I_RECARM",1)

reaper.Undo_EndBlock("Setup Ampeg V-4B",-1);
reaper.PreventUIRefresh(-1);
