import std/unittest

import kraut/private/utils


suite "Utils":
  test "Components":
    check "/users/{userId}/".components == @["", "users", "{userId}", ""]
    check "users/{userId}".components == @["", "users", "{userId}", ""]
    check "#/users/123/".components == @["", "users", "123", ""]
    check "#users/123".components == @["", "users", "123", ""]

  test "Placeholders":
    check "{userId}".isPlaceholder
    check not "users".isPlaceholder

    check placeholderName("{userId}") == "userId"

