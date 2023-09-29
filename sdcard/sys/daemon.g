if state.status == "idle" || state.status == "paused"
  if global.stopTime != null && state.time - global.stopTime > 60
    M106 P0 S0; Abluft aus
    set global.stopTime = null