reaper.PreventUIRefresh(1);
reaper.Undo_BeginBlock();

reaper.Main_OnCommand(40001, 0); --Track: Insert new track

selTrack = reaper.GetSelectedTrack(0, 0);
reaper.SetMediaTrackInfo_Value(selTrack, 'B_MUTE', 1)
reaper.SetMediaTrackInfo_Value(selTrack, 'B_MAINSEND', 0)
reaper.SetMediaTrackInfo_Value(selTrack, 'I_HEIGHTOVERRIDE', 26)
reaper.SetMediaTrackInfo_Value(selTrack, 'B_HEIGHTLOCK', 1)
reaper.GetSetMediaTrackInfo_String(selTrack, 'P_NAME', '>sep', 1)

reaper.Main_OnCommand(41312, 0); --Track: Lock track controls

reaper.Undo_EndBlock("Add New Track - Separator", -1);
reaper.PreventUIRefresh(-1);
