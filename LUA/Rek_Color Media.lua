function colorMedia()

  for i = 0, selectedItems - 1 do
    local mediaItem = reaper.GetSelectedMediaItem(0, i)
    local mediaTake = reaper.GetActiveTake(mediaItem)
    local mediaTrack = reaper.GetMediaItemTrack(mediaItem)
    local mediaColor = reaper.ColorToNative(150,0,0)|16777216

    if mediaTake then
      reaper.SetMediaItemTakeInfo_Value(mediaTake, "I_CUSTOMCOLOR", mediaColor)
      reaper.SetTrackColor(mediaTrack, mediaColor)
        else
      reaper.SetMediaItemInfo_Value(mediaTake, "I_CUSTOMCOLOR", mediaColor)
      reaper.SetTrackColor(mediaTrack, mediaColor)
    end
  end
end

selectedItems = reaper.CountSelectedMediaItems(0)

if selectedItems > 0 then
  reaper.PreventUIRefresh(1)
  reaper.Undo_BeginBlock()

  colorMedia()

  reaper.Undo_EndBlock("Color Media", -1)
  reaper.UpdateArrange()
  reaper.PreventUIRefresh(-1)
end
