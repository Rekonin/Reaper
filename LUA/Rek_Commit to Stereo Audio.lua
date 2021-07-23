reaper.Undo_BeginBlock()

reaper.Main_OnCommand(40209, 0) --Item: Apply track/take FX to items
reaper.Main_OnCommand(reaper.NamedCommandLookup('_XENAKIOS_SELECTFIRSTTAKEOFITEMS'), 0)
reaper.Main_OnCommand(40129, 0) --Take: Delete active take from items

reaper.Undo_EndBlock('Commit to Stereo Audio', 0)
