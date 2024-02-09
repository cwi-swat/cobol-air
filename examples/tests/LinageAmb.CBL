000100 IDENTIFICATION DIVISION.                                         SQ2104.2
000200 PROGRAM-ID.                                                      SQ2104.2
000300     SQ210M.                                                      SQ2104.2
002200 ENVIRONMENT DIVISION.                                            SQ2104.2
014900 DATA DIVISION.                                                   ST1404.2
003800 FILE SECTION.                                                    SQ2104.2
005500 FD  PRINT-FILE                                                   SQ2104.2
005900     LINAGE IS LINAGE-CTR LINES                                   SQ2104.2
006000              TOP 5.                                              SQ2104.2
006100 01  PRINT-REC PICTURE X(120).                                    SQ2104.2
