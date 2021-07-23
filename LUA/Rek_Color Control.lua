function colorMedia()

selectedItems = reaper.CountSelectedMediaItems(0)
getColor()

if selectedItems > 0 then
  reaper.PreventUIRefresh(1)
  reaper.Undo_BeginBlock()

    for i = 0, selectedItems - 1 do
      local mediaItem = reaper.GetSelectedMediaItem(0, i)
      local mediaTake = reaper.GetActiveTake(mediaItem)
      local mediaTrack = reaper.GetMediaItemTrack(mediaItem)
      --local mediaColor = reaper.ColorToNative(150,0,0)|16777216
      local mediaColor = reaper.ColorToNative(R,G,B)|16777216

      if mediaTake then
        reaper.SetMediaItemTakeInfo_Value(mediaTake, "I_CUSTOMCOLOR", mediaColor)
        reaper.SetTrackColor(mediaTrack, mediaColor)
          else
        reaper.SetMediaItemInfo_Value(mediaTake, "I_CUSTOMCOLOR", mediaColor)
        reaper.SetTrackColor(mediaTrack, mediaColor)
      end
    end
    
    reaper.Undo_EndBlock("Color Media", -1)
    reaper.UpdateArrange()
    reaper.PreventUIRefresh(-1)
  end
end


-------


function colorTracks()

selectedTracks = reaper.CountSelectedTracks(0)
getColor()

  if selectedTracks > 0 then
    reaper.PreventUIRefresh(1)
    reaper.Undo_BeginBlock()

    for i = 0, selectedTracks -1 do
      --local mediaColor = reaper.ColorToNative(150,0,0)|16777216
      local mediaColor = reaper.ColorToNative(R,G,B)|16777216
      local mediaTrack = reaper.GetSelectedTrack(0, i)
      reaper.Main_OnCommand(40421, 0)
      local trackItemCount = reaper.CountTrackMediaItems(mediaTrack);

      for ii = 1, trackItemCount do;
        item = reaper.GetTrackMediaItem(mediaTrack, ii-1);
        reaper.SetMediaItemSelected(item, true);
        reaper.SetTrackColor(mediaTrack, mediaColor)
      end
    end
    
    reaper.Undo_EndBlock("Color Tracks", -1)
    reaper.UpdateArrange()
    reaper.PreventUIRefresh(-1)
  end
end


-------


function getColor()

local randomNumber = math.random(1,64)

color_int_val = reaper.GetThemeColor("group_" .. randomNumber)

R = color_int_val & 255;
G = (color_int_val >> 8) & 255;
B = (color_int_val >> 16) & 255;

return R, G, B

end


-------


function main()

local window, segment, details = reaper.BR_GetMouseCursorContext()

  if details == nil then
    colorMedia()
    else
    colorTracks()
  end
end


-------


main()
