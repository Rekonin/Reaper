reaper.PreventUIRefresh(1)
reaper.Undo_BeginBlock()


reaper.Main_OnCommand(40062, 0)

selTrack = reaper.GetSelectedTrack(0, 0)
_, trackName = reaper.GetSetMediaTrackInfo_String(selTrack, 'P_NAME', '', false)
newTrackName = trackName .. " Dup"

reaper.GetSetMediaTrackInfo_String(selTrack, "P_NAME", newTrackName, true)

reaper.SetMediaTrackInfo_Value(selTrack, "B_PHASE", -1)
reaper.TrackFX_AddByName(selTrack, "ReaComp", false, -1)
reaper.TrackFX_SetPreset(selTrack, 0, "Invert Phase Gate")

reaper.Main_OnCommand(reaper.NamedCommandLookup("_XENAKIOS_SELPREVTRACKKEEP"), 0)


reaper.Undo_EndBlock("Invert Phase Gate", -1)
reaper.PreventUIRefresh(-1)
