function colorTracks()

  for i = 0, selectedTracks -1 do
    local mediaColor = reaper.ColorToNative(150,0,0)|16777216
    local mediaTrack = reaper.GetSelectedTrack(0, i)
    reaper.Main_OnCommand(40421, 0)
    local trackItemCount = reaper.CountTrackMediaItems(mediaTrack);

    for ii = 1, trackItemCount do;
      item = reaper.GetTrackMediaItem(mediaTrack, ii-1);
      reaper.SetMediaItemSelected(item, true);
      reaper.SetTrackColor(mediaTrack, mediaColor)
    end
  end
end

selectedTracks = reaper.CountSelectedTracks(0)

if selectedTracks > 0 then
  reaper.PreventUIRefresh(1)
  reaper.Undo_BeginBlock()

  colorTracks()

  reaper.Undo_EndBlock("Color Tracks", -1)
  reaper.UpdateArrange()
  reaper.PreventUIRefresh(-1)
end
