reaper.PreventUIRefresh(1)
reaper.Undo_BeginBlock()

reaper.Main_OnCommand(40296, 0) --Track: Select all tracks
reaper.Main_OnCommand(reaper.NamedCommandLookup('_XENAKIOS_SELTRAX_RECUNARMED'), 0)
reaper.Main_OnCommand(40297, 0) --Track: Unselect all tracks
reaper.Main_OnCommand(41147, 0) --Track: Insert new track at end of mixer
reaper.Main_OnCommand(reaper.NamedCommandLookup('_XENAKIOS_SELTRAX_RECARMED'), 0)
tracknum = reaper.CountSelectedTracks(0)
for i = 0, tracknum - 1, 1 do
  reaper.SetMediaTrackInfo_Value(reaper.GetSelectedTrack(tracknum, i), "I_RECINPUT", 4096 | 0 | (16 << 1))
end
reaper.Main_OnCommand(40493, 0) --Track: Set track record monitor to on
reaper.Main_OnCommand(40271, 0) --View: Show FX browser window

reaper.Undo_EndBlock('Prepare MIDI Instrument', 0)
reaper.PreventUIRefresh(-1)
reaper.UpdateArrange()
reaper.UpdateTimeline()
