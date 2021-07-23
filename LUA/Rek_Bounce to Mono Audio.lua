reaper.Undo_BeginBlock()

reaper.Main_OnCommand(41173, 0) --Item navigation: Move cursor to start of items
reaper.Main_OnCommand(40361, 0) --Item: Apply track/take FX to items (mono output)
reaper.Main_OnCommand(40698, 0) --Edit: Copy items
reaper.Main_OnCommand(40001, 0) --Track: Insert new track
reaper.Main_OnCommand(42398, 0) --Item: Paste items/tracks
reaper.Main_OnCommand(reaper.NamedCommandLookup('_XENAKIOS_SELECTFIRSTTAKEOFITEMS'), 0)
reaper.Main_OnCommand(40129, 0) --Take: Delete active take from items
reaper.Main_OnCommand(40418, 0) --Item navigation: Select and move to item in previous track
reaper.Main_OnCommand(reaper.NamedCommandLookup('_XENAKIOS_SELECTLASTTAKEOFITEMS'), 0)
reaper.Main_OnCommand(40129, 0) --Take: Delete active take from items
reaper.Main_OnCommand(40719, 0) --Item properties: Mute

reaper.Undo_EndBlock('Bounce to Mono Audio', 0)
