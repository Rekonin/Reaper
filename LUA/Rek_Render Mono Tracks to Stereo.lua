reaper.PreventUIRefresh(1)
reaper.Undo_BeginBlock()

reaper.Main_OnCommand(reaper.NamedCommandLookup("_XENAKIOS_SELNEXTTRACKKEEP"), 0)
reaper.Main_OnCommand(40718, 0) --Item: Select all items on selected tracks in current time selection
reaper.Main_OnCommand(reaper.NamedCommandLookup("_XENAKIOS_IMPLODEITEMSPANSYMMETRICALLY"), 0)
reaper.Main_OnCommand(reaper.NamedCommandLookup("_XENAKIOS_SELFIRSTOFSELTRAX"), 0)
reaper.Main_OnCommand(40788, 0) --Track: Render tracks to stereo stem tracks (and mute originals)
reaper.Main_OnCommand(reaper.NamedCommandLookup("_XENAKIOS_SELNEXTTRACK"), 0)
reaper.Main_OnCommand(reaper.NamedCommandLookup("_XENAKIOS_SELNEXTTRACKKEEP"), 0)
reaper.Main_OnCommand(40005, 0) --Track: Remove tracks

reaper.Undo_EndBlock("Render Mono Tracks to Stereo", 0)
reaper.PreventUIRefresh(-1)
reaper.UpdateArrange()
reaper.UpdateTimeline()
