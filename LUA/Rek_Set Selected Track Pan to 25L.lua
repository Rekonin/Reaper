local self = ({reaper.get_action_context()})[2]:match('([^/\\_]+).lua$')
local UNDO_STATE_TRACKCFG = 1

local seltracks = reaper.CountSelectedTracks()
if seltracks < 1 then return reaper.defer(function() end) end

reaper.Undo_BeginBlock()

for i=0, seltracks-1 do
  local track = reaper.GetSelectedTrack(0, i)
  reaper.SetMediaTrackInfo_Value(track, 'D_PAN', -0.25)
end

reaper.Undo_EndBlock(self, UNDO_STATE_TRACKCFG)