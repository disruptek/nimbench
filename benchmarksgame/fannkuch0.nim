import os, strutils, sequtils, algorithm

proc main() =
  let N = parseInt(paramStr(1))
  var s = toSeq(0 ..< N)
  var P = s # Re-used mutable permutation

  proc nFlips(): int {.inline.} =
    copyMem(addr P[0], addr s[0], N * sizeof(s[0])) # set P[] to current perm
    var i = 1
    while true:
      reverse(P, 0, P[0])
      inc(i)
      if P[P[0]] == 0:
        break
    return i

  var maxflips = 0
  var checksum = 0
  var sign = +1
  while true:
    if s[0] != 0:
      let nF = if s[s[0]] != 0: nFlips() else: 1
      maxflips = max(maxflips, nF)
      inc(checksum, sign * nF)
    if not nextPermutation(s):
      break # IT.ORDER=>DIFF CHECKSUM; CALC RETAINED TO BE FAIR
    sign = -sign
  echo checksum
  echo "Pfannkuchen(", N, ") = ", maxflips
main()
