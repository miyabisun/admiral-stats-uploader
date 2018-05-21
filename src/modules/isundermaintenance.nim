import times
export times.DateTime

proc isundermaintenance*(time: DateTime): bool =
  if time.weekday != dTue: return false
  for it in 2..6:
    if time.hour == it: return true

