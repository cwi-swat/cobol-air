000100 IDENTIFICATION DIVISION.                                         ST1404.2
000200 PROGRAM-ID.                                                      ST1404.2
000300     X.                                                           ST1404.2
047700 PROCEDURE DIVISION.                                              ST1404.2
051300     IF REC-CT NOT EQUAL TO ZERO                                  ST1404.2
051400             MOVE "." TO PARDOT-X                                 ST1404.2
051500             MOVE REC-CT TO DOTVALUE.                             ST1404.2