local NameFX, NameFX = reaper.GetUserInputs('Load Plugin on All Tracks', 1, 'Plugin Name', '')
local NamePreset = "My Default"

local CountTrack = reaper.CountTracks(0);

if CountTrack > 0 then

  SelTrack = reaper.GetSelectedTrack(0, 0);

  reaper.Undo_BeginBlock();

  for i = 0, CountTrack-1 do
    FXTrack = reaper.GetSelectedTrack(0, i);
    if reaper.IsTrackSelected(SelTrack) then
      reaper.TrackFX_AddByName(FXTrack, NameFX, false, -1)
      reaper.TrackFX_SetPreset(FXTrack, 0, NamePreset)
    end
  end
end;

reaper.Undo_EndBlock('Add Plugin to Selected Tracks', -1);
reaper.UpdateArrange();
