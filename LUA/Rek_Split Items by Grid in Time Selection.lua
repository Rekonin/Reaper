local IGNORE_CROSSFADE = true
local IGNORE_FADE = true

local function no_undo()reaper.defer(function()end)end;

local CountSelItem = reaper.CountSelectedMediaItems(0);

if CountSelItem == 0 then;
  reaper.MB('No selected items','Alert',0);
  no_undo() return;
end;

if IGNORE_CROSSFADE ~= true then IGNORE_CROSSFADE = nil end;
if IGNORE_FADE ~= true then IGNORE_FADE = nil end;

local crossfadePREF;
if IGNORE_CROSSFADE == true then;
  crossfadePREF = reaper.GetToggleCommandStateEx(0,40041);
  if crossfadePREF == 1 then;
    reaper.Main_OnCommand(40041,0);
  end;
end;

local fadePREF;
if IGNORE_FADE == true then;
  fadePREF = reaper.SNM_GetIntConfigVar("splitautoxfade",0);
  if fadePREF&8 == 0 then;
    reaper.SNM_SetIntConfigVar("splitautoxfade",(fadePREF|8));
  end;
end;

local timeSelStart,timeSelEnd = reaper.GetSet_LoopTimeRange(0,0,0,0,0);
if timeSelStart == timeSelEnd then;
  reaper.Main_OnCommand(40932,0);
  else;
  local selItemTimeSel;
  for i = reaper.CountSelectedMediaItems(0)-1,0,-1 do;
  local item = reaper.GetSelectedMediaItem(0,i);
  local pos = reaper.GetMediaItemInfo_Value(item,'D_POSITION');
  local len = reaper.GetMediaItemInfo_Value(item,'D_LENGTH');
  if pos+len>timeSelStart and pos<timeSelEnd then;
    selItemTimeSel = true;break;
  end;
end;

if not selItemTimeSel then;
  local MB = reaper.MB('No selected items in time selection\nSplit items out of time selection? - Ok\n\n','Alert',1);
  if MB == 1 then;
    reaper.Main_OnCommand(40932,0);
    end;
    else;
    reaper.Undo_BeginBlock();
    reaper.Main_OnCommand(40061,0);
    for i = reaper.CountSelectedMediaItems(0)-1,0,-1 do;
    local item = reaper.GetSelectedMediaItem(0,i);
    local pos = reaper.GetMediaItemInfo_Value(item,'D_POSITION');
    local len = reaper.GetMediaItemInfo_Value(item,'D_LENGTH');
    if pos >= timeSelEnd or pos+len <= timeSelStart then;
      reaper.SetMediaItemInfo_Value(item,'B_UISEL',0);
    end;
  end;
  reaper.Main_OnCommand(40932,0);
  reaper.Undo_EndBlock("Split items at grid (Time Selection)",-1);
  end;
end;

if IGNORE_CROSSFADE == true then;
  if crossfadePREF == 1 then;
    reaper.Main_OnCommand(40041,0);
  end;
end;

if IGNORE_FADE == true then;
  reaper.SNM_SetIntConfigVar("splitautoxfade",fadePREF);
end;


reaper.UpdateArrange();
