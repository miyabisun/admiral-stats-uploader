import unittest, times, ../../src/modules/isundermaintenance

suite "modules/isundermaintenance":
  let base_time = initDateTime(22, mMay, 2018, 1, 59, 59)
  test "2018-05-22(tue) 01:59:59 is false":
    check(isundermaintenance(base_time) == false)
  test "2018-05-22(tue) 02:00:00 is true":
    let time = base_time + 1.seconds
    check(isundermaintenance(time) == true)
  test "2018-05-22(tue) 06:59:59 is true":
    let time = base_time + 5.hours
    check(isundermaintenance(time) == true)
  test "2018-05-22(tue) 07:00:00 is false":
    let time = base_time + 5.hours + 1.seconds
    check(isundermaintenance(time) == false)
  test "2018-05-23(wed) 02:00:00 is false":
    let time = base_time + 1.seconds + 1.days
    check(isundermaintenance(time) == false)

