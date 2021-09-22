currentBPM, _ = reaper.GetProjectTimeSignature2(0)

_, newBPM = reaper.GetUserInputs("Set Tempo", 1, "BPM", currentBPM)

reaper.SetCurrentBPM(0, newBPM, false)

reaper.UpdateArrange();
