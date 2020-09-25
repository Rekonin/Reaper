reaper.Undo_BeginBlock()

last_context = reaper.GetCursorContext2(true)

if last_context < 2 then
  reaper.Main_OnCommand(40183, 0)  --Item properties: Toggle items/tracks mute (depending on focus)
else
  reaper.Main_OnCommand(42211, 0)  --Envelope: Mute automation items
end

reaper.Undo_EndBlock("Toggle Mute All The Things", 0)
