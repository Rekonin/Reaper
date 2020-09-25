reaper.PreventUIRefresh(1)
reaper.Undo_BeginBlock()

reaper.Main_OnCommand(40361, 0) --Item: Apply track/take FX to items (mono output)
reaper.Main_OnCommand(40698, 0) --Edit: Copy items
reaper.Main_OnCommand(40318, 0) --Item navigation: Move cursor left to edge of item
reaper.Main_OnCommand(40285, 0) --Track: Go to next track
reaper.Main_OnCommand(42398, 0) --Item: Paste items/tracks
reaper.Main_OnCommand(reaper.NamedCommandLookup('_XENAKIOS_SELECTFIRSTTAKEOFITEMS'), 0)
reaper.Main_OnCommand(40129, 0) --Take: Delete active take from items
reaper.Main_OnCommand(40418, 0) --Item navigation: Select and move to item in previous track
reaper.Main_OnCommand(reaper.NamedCommandLookup('_XENAKIOS_SELECTLASTTAKEOFITEMS'), 0)
reaper.Main_OnCommand(40129, 0) --Take: Delete active take from items
reaper.Main_OnCommand(40719, 0) --Item properties: Mute

reaper.Undo_EndBlock('Commit MIDI to Mono Audio to Next Track', 0)
reaper.PreventUIRefresh(-1)
reaper.UpdateArrange()
reaper.UpdateTimeline()
