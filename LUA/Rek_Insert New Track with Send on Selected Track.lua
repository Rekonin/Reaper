local MIDI_Bus =  nil
local MIDI_Chan = nil

if not tonumber(MIDI_Bus) or MIDI_Bus < 0 or MIDI_Bus > 16 then MIDI_Bus = nil end;
if not tonumber(MIDI_Chan)or MIDI_Chan< 0 or MIDI_Chan> 16 then MIDI_Chan= nil end;

local function PACK_I_RECINPUT_MIDI(MIDI_Bus, MIDI_Chan);
  if not tonumber(MIDI_Bus) or MIDI_Bus < 0 or MIDI_Bus > 16 then MIDI_Bus = 0 end;
  if not tonumber(MIDI_Chan)or MIDI_Chan< 0 or MIDI_Chan> 16 then MIDI_Chan= 0 end;
  local MIDI_Flags = MIDI_Bus | (MIDI_Chan << 5);
  return MIDI_Flags;
end;

local function InsertTrack();
  local Track = reaper.GetLastTouchedTrack();
  if not Track then;
  Track = reaper.GetTrack(0,reaper.CountTracks(0)-1);
end;
        
local numbTr;
  if Track then;
  numbTr = reaper.GetMediaTrackInfo_Value(Track,'IP_TRACKNUMBER');
  else;
  numbTr = reaper.CountTracks(0);
end;

if not tonumber(numbTr) or numbTr < 0 then numbTr = reaper.CountTracks(0) end;
  reaper.InsertTrackAtIndex(numbTr,true);
  local NewTrack = reaper.GetTrack(0,numbTr);
  return NewTrack;
end;

reaper.Undo_BeginBlock();
reaper.PreventUIRefresh(1);
    
local NewTrack = InsertTrack();
    
reaper.SetMediaTrackInfo_Value(NewTrack,'I_SELECTED',1);

local CountSelTrack = reaper.CountSelectedTracks(0);
  if CountSelTrack > 0 then;
  for i = 1,CountSelTrack do;
  local SelTrack = reaper.GetSelectedTrack(0,i-1);
  if SelTrack and SelTrack ~= NewTrack then;
local Send = reaper.CreateTrackSend(NewTrack,SelTrack);

  if MIDI_Bus and MIDI_Chan then;
local midiFlags = PACK_I_RECINPUT_MIDI(MIDI_Bus,MIDI_Chan);
reaper.SetTrackSendInfo_Value(NewTrack,0,Send,'I_MIDIFLAGS',midiFlags);
      end;
    end;
  end;
end;
    
reaper.PreventUIRefresh(-1);
reaper.Undo_EndBlock('Insert New Track with Send on Selected Track',-1);
