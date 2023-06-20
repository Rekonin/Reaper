local Only_Items_In_Time_Selection = 0

    local function MODULE(file);
        local E,A=pcall(dofile,file);if not(E)then;reaper.ShowConsoleMsg('\n\nError - '..debug.getinfo(1,'S').source:match('.*[/\\](.+)')..'\nMISSING FILE / ОТСУТСТВУЕТ ФАЙЛ!\n'..file:gsub('\\','/'))return;end;
        if not A.VersArcFun('2.8.5',file,'')then;A=nil;return;end;return A;
    end; local Arc = MODULE((reaper.GetResourcePath()..'/Scripts/Archie-ReaScripts/Functions/Arc_Function_lua.lua'):gsub('\\','/'));
    if not Arc then return end;

    local CountSelItem = reaper.CountSelectedMediaItems(0);
    if CountSelItem == 0 then Arc.no_undo() return end;


    local startTime,endTime = reaper.GetSet_LoopTimeRange(0,0,0,0,0);

    reaper.PreventUIRefresh(1);
    reaper.Undo_BeginBlock();

    for i = 1,CountSelItem do;
        local sel_item = reaper.GetSelectedMediaItem(0,i-1);
        local item_pos = Arc.GetMediaItemInfo_Value(sel_item,'D_POSITION');
        -- local item_len = Arc.GetMediaItemInfo_Value(sel_item,'D_LENGTH');
        local item_end = Arc.GetMediaItemInfo_Value(sel_item,'D_END');

        if Only_Items_In_Time_Selection == 0 then;

            if item_end > startTime and item_pos < endTime then;
                if item_end <= endTime then;
                    reaper.SetMediaItemLength(sel_item,endTime-item_pos,true);
                    Arc.SetMediaItemLeftTrim2(startTime ,sel_item);
                else;
                    Arc.SetMediaItemLeftTrim2(startTime ,sel_item);
                    reaper.SetMediaItemLength(sel_item,endTime-startTime,true);
                end;
            end;

        elseif Only_Items_In_Time_Selection == 1 then;

            if item_end <= endTime then;
                reaper.SetMediaItemLength(sel_item,endTime-item_pos,true);
                Arc.SetMediaItemLeftTrim2(startTime ,sel_item);
            else;
                Arc.SetMediaItemLeftTrim2(startTime ,sel_item);
                reaper.SetMediaItemLength(sel_item,endTime-startTime,true);
            end;
       end;
    end;

reaper.Undo_EndBlock('Trim item to time selection',-1)
reaper.PreventUIRefresh(-1)
reaper.UpdateArrange()
