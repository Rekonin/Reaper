reaper.Undo_BeginBlock()

reaper.Main_OnCommand(40361, 0) --Item: Apply track/take FX to items (mono output)
reaper.Main_OnCommand(reaper.NamedCommandLookup('_XENAKIOS_SELECTFIRSTTAKEOFITEMS'), 0)
reaper.Main_OnCommand(40129, 0) --Take: Delete active take from items
reaper.Main_OnCommand(41923, 0) --Item: Reset items volume to +0dB

reaper.Undo_EndBlock('Commit to Mono Audio', 0)
