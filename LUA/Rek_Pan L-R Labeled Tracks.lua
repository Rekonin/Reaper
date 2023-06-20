reaper.Undo_BeginBlock();
reaper.PreventUIRefresh(1);

if reaper.CountTracks(0) ~= nil then
  for i = 1, reaper.CountTracks(0) do
    tr = reaper.GetTrack(0, i-1)
    _, tr_name = reaper.GetSetMediaTrackInfo_String(tr, 'P_NAME', '', false)
    tr_name_last_sym = string.upper(string.sub(tr_name, -1))
    if tr_name_last_sym == 'L' then
      reaper.SetMediaTrackInfo_Value(tr, 'D_PAN', -1) end
    if tr_name_last_sym == 'R' then
      reaper.SetMediaTrackInfo_Value(tr, 'D_PAN', 1) end
  end
end

reaper.PreventUIRefresh(-1);
reaper.Undo_EndBlock('Pan L-R Labeled Tracks', -1);
