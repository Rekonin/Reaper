function createFaderSend(source, destination)
    local sendID = reaper.CreateTrackSend(source, destination)
end

function main()
    local trackCount = reaper.CountSelectedTracks(0)
    if trackCount <= 1 then
        reaper.ShowMessageBox('No tracks selected. Select at least two tracks.', 'Error', 0)
        return
    end

    local targetTrack = reaper.GetLastTouchedTrack()

    sourceTracks = {}
    for i = 0, trackCount-1 do
        local track = reaper.GetSelectedTrack(0, i)
        if track ~= targetTrack then
            table.insert(sourceTracks, track)
        end
    end

    reaper.Main_OnCommand('40297', 0) --Track: Unselect (clear selection of) all tracks

    for i = 1, #sourceTracks do
        local track = sourceTracks[i]
        createFaderSend(track, targetTrack)
    end
end

reaper.Undo_BeginBlock()
reaper.PreventUIRefresh(1)

main()

reaper.PreventUIRefresh(-1)
reaper.Undo_EndBlock('Create Sends Track Select Order', -1)
