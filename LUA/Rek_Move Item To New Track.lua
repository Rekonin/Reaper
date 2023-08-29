if reaper.CountSelectedMediaItems(0, 0) < 1 then return end

reaper.PreventUIRefresh(1);
reaper.Undo_BeginBlock();

reaper.Main_OnCommand(40297, 0) --Track: Unselect (clear selection of) all tracks
reaper.Main_OnCommand(40001, 0) --Track: Insert new track
reaper.Main_OnCommand(reaper.NamedCommandLookup('_XENAKIOS_DOSTORECURPOS'), 0) --Xenakios/SWS: Store edit cursor position
reaper.Main_OnCommand(41173, 0) --Item navigation: Move cursor to start of items
reaper.Main_OnCommand(40699, 0) --Edit: Cut items
--reaper.Main_OnCommand(40285, 0) --Track: Go to next track
reaper.Main_OnCommand(42398, 0) --Item: Paste items/tracks
reaper.Main_OnCommand(reaper.NamedCommandLookup('_XENAKIOS_DORECALLCURPOS'), 0) --Xenakios/SWS: Recall edit cursor position

reaper.Undo_EndBlock('Move Item To New Track', -1);
reaper.PreventUIRefresh(-1);
