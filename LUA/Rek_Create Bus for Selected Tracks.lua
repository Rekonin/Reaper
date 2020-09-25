local first_sel = reaper.GetSelectedTrack(0, 0)
if not first_sel then return end

reaper.Undo_BeginBlock()
reaper.PreventUIRefresh(1)

local _,name = reaper.GetSetMediaTrackInfo_String(first_sel, 'P_NAME', '', 0);

local idx = reaper.GetMediaTrackInfo_Value(first_sel, 'IP_TRACKNUMBER') - 1
reaper.InsertTrackAtIndex(idx, true)
local bus = reaper.GetTrack(0, idx)

reaper.GetSetMediaTrackInfo_String(bus, 'P_NAME', name, 1);
reaper.SetMediaTrackInfo_Value(bus, 'D_PANLAW', 1.0)

for i = 0, reaper.CountSelectedTracks(0) - 1 do
local tr = reaper.GetSelectedTrack(0, i)
reaper.SetMediaTrackInfo_Value(tr, 'B_MAINSEND', 0)

local send = reaper.CreateTrackSend(tr, bus)
reaper.SetTrackSendInfo_Value(tr, 0, send, 'D_VOL', 1)
reaper.SetTrackSendInfo_Value(tr, 0, send, 'I_SENDMODE', 0)
end

reaper.Main_OnCommand(reaper.NamedCommandLookup('_SWS_TRACKRANDCOL'), 0)

local HasExtState = reaper.HasExtState('Color BUS', 'COLOR_BUS');
if HasExtState then;
reaper.DeleteExtState('Color BUS', 'COLOR_BUS', false);
end;
local Color = reaper.GetMediaTrackInfo_Value(first_sel, 'I_CUSTOMCOLOR');
reaper.SetExtState('Color BUS', 'COLOR_BUS', Color, false);

reaper.Main_OnCommand(reaper.NamedCommandLookup('_XENAKIOS_SELFIRSTOFSELTRAX'), 0)
reaper.Main_OnCommand(reaper.NamedCommandLookup('_XENAKIOS_SELPREVTRACK'), 0)
reaper.SetMediaTrackInfo_Value(bus, 'I_CUSTOMCOLOR', Color);
reaper.Main_OnCommand(reaper.NamedCommandLookup('_XENAKIOS_INSTRACKLABSUFF'), 0)
reaper.Main_OnCommand(reaper.NamedCommandLookup('_SWSAUTOCOLOR_APPLY'), 0)

reaper.PreventUIRefresh(-1)
reaper.TrackList_AdjustWindows(false)
reaper.UpdateArrange()
reaper.Undo_EndBlock('Create bus before selected tracks and reroute them', 0)
