reaper.Undo_BeginBlock()

reaper.Main_OnCommand(40436, 0) --Item: Apply track/take FX to items (MIDI output)
reaper.Main_OnCommand(40131, 0) --Take: Crop to active take in items

reaper.Undo_EndBlock('Commit to MIDI Output', 0)
