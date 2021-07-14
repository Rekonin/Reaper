local function nothing() end; local function crFolder() reaper.defer(nothing) end

reaper.Undo_BeginBlock()
reaper.PreventUIRefresh(1)

function last_tr_in_folder (folder_tr)
  last = nil
  local dep = reaper.GetTrackDepth(folder_tr)
  local num = reaper.GetMediaTrackInfo_Value(folder_tr, 'IP_TRACKNUMBER')
  local tracks = reaper.CountTracks()
  for i = num+1, tracks do
    if reaper.GetTrackDepth(reaper.GetTrack(0,i-1)) <= dep then last = reaper.GetTrack(0, i-2) break end
  end
  if last == nil then last = reaper.GetTrack(0, tracks-1) end
  return last
end

sel_tracks = reaper.CountSelectedTracks()
if sel_tracks == 0 then crFolder() end

first_sel = reaper.GetSelectedTrack(0, 0)
tr_num = reaper.GetMediaTrackInfo_Value(first_sel, 'IP_TRACKNUMBER')

local _,name = reaper.GetSetMediaTrackInfo_String(first_sel, 'P_NAME', '', 0);

last_sel = reaper.GetSelectedTrack(0, sel_tracks-1)
last_sel_dep = reaper.GetMediaTrackInfo_Value(last_sel, 'I_FOLDERDEPTH')
if last_sel_dep == 1 then last_tr = last_tr_in_folder(last_sel) else last_tr = last_sel end

reaper.InsertTrackAtIndex(tr_num-1, 1)
reaper.TrackList_AdjustWindows(0)
tr = reaper.GetTrack(0, tr_num-1)

reaper.GetSetMediaTrackInfo_String(tr, 'P_NAME', name..' ', 1);
reaper.SetMediaTrackInfo_Value(tr, 'D_PANLAW', 1.0)
reaper.SetMediaTrackInfo_Value(tr, 'I_FOLDERDEPTH', 1)
reaper.SetMediaTrackInfo_Value(last_tr, 'I_FOLDERDEPTH', last_sel_dep-1)
reaper.SetOnlyTrackSelected(tr)

reaper.Main_OnCommand(40914, 0) --Track: Set first selected track as last touched track

--reaper.Main_OnCommand(40913, 0) --Track: Vertical scroll selected tracks into view
reaper.Main_OnCommand(reaper.NamedCommandLookup('_XENAKIOS_INSTRACKLABSUFF'), 0)
reaper.Main_OnCommand(reaper.NamedCommandLookup('_SWS_TRACKRANDCOL'), 0)
reaper.Main_OnCommand(reaper.NamedCommandLookup('_SWSAUTOCOLOR_APPLY'), 0)

--reaper.Main_OnCommand(40696, 0) --Track: Rename last touched track

reaper.PreventUIRefresh(-1)
reaper.Undo_EndBlock('Create folder from selected tracks', -1)

reaper.TrackList_AdjustWindows(false)
reaper.UpdateArrange()
