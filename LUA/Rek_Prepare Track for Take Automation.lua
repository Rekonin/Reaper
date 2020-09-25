reaper.PreventUIRefresh(1)
reaper.Undo_BeginBlock()

local track = reaper.GetSelectedTrack(0,0)
if not track then return end
local _, track_name = reaper.GetSetMediaTrackInfo_String(track, 'P_NAME', '', 0)
track_name = track_name .. " Takes"

reaper.Main_OnCommand(40408, 0) --Track: Toggle track pre-FX volume envelope visible
reaper.Main_OnCommand(reaper.NamedCommandLookup('_SWS_INSRTTRKABOVE'), 0)

local track = reaper.GetSelectedTrack(0,0)
reaper.GetSetMediaTrackInfo_String(track, 'P_NAME', track_name, 1)

reaper.Main_OnCommand(40751, 0) --Track properties: Set free item positioning
reaper.Main_OnCommand(40285, 0) --Track: Go to next track

reaper.Undo_EndBlock('Prepare Tracks for Take Automation', -1)
reaper.PreventUIRefresh(-1)
