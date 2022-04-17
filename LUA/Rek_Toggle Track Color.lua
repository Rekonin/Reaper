selTrackCount = reaper.CountSelectedTracks(0)

for i = 0, selTrackCount-1 do

  mediaTrack = reaper.GetSelectedTrack(0, i)
  _, curTrackLayout = reaper.GetSetMediaTrackInfo_String(mediaTrack, 'P_TCP_LAYOUT', '', false)
  if curTrackLayout == "Color" then
    reaper.GetSetMediaTrackInfo_String(mediaTrack, 'P_TCP_LAYOUT', 'Default', true)
    else
    reaper.GetSetMediaTrackInfo_String(mediaTrack, 'P_TCP_LAYOUT', 'Color', true)
  end

end
