reaper.Main_OnCommand(41173, 0); --Item navigation: Move cursor to start of items

    local Indent = 0.10;
    local Vertically_Zoom = true
    local function no_undo()reaper.defer(function()end)end;

    local itemF_SourceT;
    local filename = ({reaper.get_action_context()})[2]:upper();
    if filename:match('^.*(SOURCE).-%.%s-LUA%s-$')then;
        itemF_SourceT = true;
    end;

    local TOGGLE;
    if filename:match('.+[/\\](.+)'):match('^ARCHIE_VAR;%s-TOGGLE')then;
        TOGGLE = true;
    end;

    local TimeSel;
    if filename:match('%(%s-TIME%s-SELECTION%s-%).*%.%s-LUA%s-$')then;
        TimeSel = true;
    end;

    local function OpenMIDI_editor_and_zoom_to_content(itemF_SourceT,TimeSel)
        local ZoomProj = 40726; --Envelope: Insert 4 envelope points at time selection
        local OpenMIDI = 40153; --Item: Open in built-in MIDI editor (set default behavior in preferences)
        local ZoomCont = 40473; --Screenset: Save track view #03

        if not tonumber(Indent) then Indent = 0 end;

        reaper.Main_OnCommand(OpenMIDI,0);

        local MIDIEditor = reaper.MIDIEditor_GetActive();
        if not MIDIEditor then no_undo() return end;

        local Take = reaper.MIDIEditor_GetTake(MIDIEditor);
        local rate = reaper.GetMediaItemTakeInfo_Value(Take,'D_PLAYRATE');
        local Item = reaper.GetMediaItemTake_Item(Take);
        local posItem = reaper.GetMediaItemInfo_Value(Item, "D_POSITION");
        local lenItem = reaper.GetMediaItemInfo_Value(Item, "D_LENGTH");
        local endPosItem = posItem + lenItem;
        local StartLoop,EndLoop = reaper.GetSet_LoopTimeRange(0,1,0,0,0);
        local timeSelStart,timeSelEnd = reaper.GetSet_LoopTimeRange(0,0,0,0,0);
        if timeSelStart==timeSelEnd then timeSelStart=math.huge timeSelEnd=math.huge end;

        local source = reaper.GetMediaItemTake_Source(Take);
        local retval,lengthIsQN = reaper.GetMediaSourceLength(source);
        local TimeFromQN = reaper.TimeMap2_QNToTime(0,retval)/rate;

        reaper.PreventUIRefresh(1);

        if Vertically_Zoom == true then;
            reaper.MIDIEditor_OnCommand(MIDIEditor,ZoomCont);
        end;


        local TimeSelTRUE;
        if TimeSel == true then;
            if posItem < timeSelEnd and endPosItem > timeSelStart then;
                if posItem >= timeSelStart then Spos = posItem else Spos = timeSelStart end;
                if endPosItem <= timeSelEnd then Epos = endPosItem else Epos = timeSelEnd end;
                if Indent >= (Epos-Spos)/2 then Indent = 0 end;
                reaper.GetSet_LoopTimeRange(1,1,Spos+Indent,Epos-Indent,0);
                reaper.GetSet_LoopTimeRange(1,0,Spos+Indent,Epos-Indent,0);
                TimeSelTRUE = true;
            end;
        end;


        if not TimeSelTRUE then;
            if itemF_SourceT == true then;
               local EndPosSrc = (posItem+TimeFromQN);
               if EndPosSrc > endPosItem then EndPosSrc = endPosItem end;
               if Indent >= (EndPosSrc-posItem)/2 then Indent = 0 end;
               reaper.GetSet_LoopTimeRange(1,1,posItem+Indent,EndPosSrc-Indent,0);
               reaper.GetSet_LoopTimeRange(1,0,posItem+Indent,EndPosSrc-Indent,0);
            else;
                if Indent >= lenItem/2 then Indent = 0 end;
                reaper.GetSet_LoopTimeRange(1,1,posItem+Indent,endPosItem-Indent,0);
                reaper.GetSet_LoopTimeRange(1,0,posItem+Indent,endPosItem-Indent,0);
            end;
        end;

        reaper.MIDIEditor_OnCommand(MIDIEditor,ZoomProj);
        reaper.GetSet_LoopTimeRange(1,1,StartLoop,EndLoop,0);
        reaper.GetSet_LoopTimeRange(1,0,timeSelStart,timeSelEnd,0);

        reaper.PreventUIRefresh(-1);
        reaper.UpdateTimeline();
        no_undo();
    end;

    if TOGGLE == true then;
        local MIDIEditor = reaper.MIDIEditor_GetActive();
        if MIDIEditor then;
            reaper.MIDIEditor_OnCommand(MIDIEditor,2);
            no_undo();
        else;
            OpenMIDI_editor_and_zoom_to_content(itemF_SourceT,TimeSel);
        end;
    else;
        OpenMIDI_editor_and_zoom_to_content(itemF_SourceT,TimeSel);
    end;
