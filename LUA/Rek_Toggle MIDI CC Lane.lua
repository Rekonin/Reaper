midiEditor = reaper.MIDIEditor_GetActive()
commandID1 = reaper.NamedCommandLookup('_BR_ME_SET_CC_LANES_HEIGHT_200')
commandID2 = reaper.NamedCommandLookup('_BR_ME_INC_CC_LANES_HEIGHT_100')
commandID3 = reaper.NamedCommandLookup('_S&M_HIDECCLANES_ME')

reaper.PreventUIRefresh(1)
reaper.Undo_BeginBlock()

if '_S&M_EXCL_TGL=8' == 'on' then
  reaper.MIDIEditor_OnCommand(midiEditor, commandID1)
  reaper.MIDIEditor_OnCommand(midiEditor, commandID2)
  reaper.Main_OnCommand(reaper.NamedCommandLookup('_S&M_EXCL_TGL=8'), 0);
else
  reaper.MIDIEditor_OnCommand(midiEditor, commandID3)
  reaper.Main_OnCommand(reaper.NamedCommandLookup('_S&M_EXCL_TGL=8'), 0);
end

reaper.Undo_EndBlock('Toggle MIDI CC Lane', -1)
reaper.PreventUIRefresh(-1)
