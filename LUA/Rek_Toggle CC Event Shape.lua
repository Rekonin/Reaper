reaper.Undo_BeginBlock()

if '_S&M_DUMMY_TGL2' == 'on' then
  reaper.MIDIEditor_OnCommand(reaper.NamedCommandLookup('_BR_ME_CC_TO_ENV_LINEAR'), 0)
  reaper.Main_OnCommand(reaper.NamedCommandLookup('_S&M_DUMMY_TGL2'), 0)
else
  reaper.MIDIEditor_OnCommand(reaper.NamedCommandLookup('_BR_ME_CC_TO_ENV_SQUARE'), 0)
  reaper.Main_OnCommand(reaper.NamedCommandLookup('_S&M_DUMMY_TGL2'), 0)
end

reaper.Undo_EndBlock('Toggle CC Event Shape', 0)
