000100 IDENTIFICATION DIVISION.                                         ST1404.2
000200 PROGRAM-ID.                                                      ST1404.2
000300     ST140A.                                                      ST1404.2
011100 ENVIRONMENT DIVISION.                                            ST1404.2
011200 CONFIGURATION SECTION.                                           ST1404.2
011300 SOURCE-COMPUTER.                                                 ST1404.2
011400     Linux.                                                       ST1404.2
011500 OBJECT-COMPUTER.                                                 ST1404.2
011600     Linux.                                                       ST1404.2
011700 SPECIAL-NAMES.                                                   ST1404.2
011800     ALPHABET MY-FAVORITE-ALPHABET IS STANDARD-1.                 ST1404.2
011900 INPUT-OUTPUT SECTION.                                            ST1404.2
014500 I-O-CONTROL.                                                     ST1404.2
014600     SAME SORT AREA FOR SQ-FS1 ST-FS1,                            ST1404.2
014700     MULTIPLE FILE TAPE CONTAINS SQ-FS1 POSITION 1                ST1404.2
014800     SQ-FS3 POSITION 2.                                           ST1404.2
014900 DATA DIVISION.                                                   ST1404.2
015000 FILE SECTION.                                                    ST1404.2
