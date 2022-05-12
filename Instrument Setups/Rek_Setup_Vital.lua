local scriptName = ({reaper.get_action_context()})[2]:match("([^/\\]+).lua$")

function Split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end

local pluginData = Split(scriptName, "_")

local NameFX = "VST3:Vital"
if pluginData[4] then
  NamePreset = pluginData[4]
  else
  NamePreset = "INIT Preset"
end
local TrackName = pluginData[3]

reaper.PreventUIRefresh(1);
reaper.Undo_BeginBlock();

reaper.Main_OnCommand(40491, 0);
reaper.Main_OnCommand(41147, 0);

NameFX = NameFX:gsub(".+:%s+","");
tracknum = reaper.CountSelectedTracks(0)

for i = 0, tracknum - 1, 1 do
  reaper.SetMediaTrackInfo_Value(reaper.GetSelectedTrack(tracknum, i), "I_RECINPUT", 4096 | (63 << 5))
end

SelTrack = reaper.GetSelectedTrack(0, 0);
reaper.TrackFX_AddByName(SelTrack, NameFX, false, -1)
reaper.TrackFX_SetPreset(SelTrack, 0, NamePreset)
if TrackName and TrackName ~= "" then
  reaper.GetSetMediaTrackInfo_String(SelTrack, "P_NAME", TrackName, 1)
end
reaper.SetMediaTrackInfo_Value(SelTrack, "I_RECARM", 1)

reaper.Undo_EndBlock("Setup "..pluginData[3], -1);
reaper.PreventUIRefresh(-1);
