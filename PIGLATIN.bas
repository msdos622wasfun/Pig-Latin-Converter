' *********************************
'
' Pig Latin Converter
' Version 1.02
' Copyleft 2020 by Erich Kohl
'
' *********************************

#COMPILE EXE
#CONSOLE ON
#DIM ALL

#INCLUDE "Version_Info.inc"

%TRUE = 1
%FALSE = 0

FUNCTION PBMAIN () AS LONG

    DIM a AS INTEGER
    DIM lin AS STRING
    DIM c AS STRING
    DIM nextWord AS STRING

    RANDOMIZE

    CON.STDOUT ""

    IF INSTR(UCASE$(COMMAND$), "/NOTITLE") = 0 THEN
        CON.STDOUT "---------------------------"
        CON.STDOUT " Pig Latin Converter v1.02"
        CON.STDOUT "Copyleft 2020 by Erich Kohl"
        CON.STDOUT "---------------------------"
        CON.STDOUT ""
        CON.STDOUT "Syntax:"
        CON.STDOUT ""
        CON.STDOUT "PIGLATIN < FILENAME [/NOTITLE]"
        CON.STDOUT ""
        CON.STDOUT "Omit filename to type into standard input using keyboard (/QUIT to stop)."
        CON.STDOUT "Use /NOTITLE to suppress title, version number, and copyleft date."
        CON.STDOUT ""
        CON.STDOUT "---------------------------"
        CON.STDOUT ""
    END IF

    DO
        CON.STDIN.LINE TO lin
        IF TRIM$(UCASE$(lin)) = "/QUIT" THEN EXIT DO
        nextWord = ""
        FOR a = 1 TO LEN(lin)
            c = MID$(lin, a, 1)
            IF (ASC(c) >= 65 AND ASC(c) <= 90) OR (ASC(c) >= 97 AND ASC(c) <= 122) THEN
                nextWord = nextWord + c
            ELSE
                IF LEN(nextWord) THEN CON.STDOUT Translation(nextWord);
                CON.STDOUT c;
                nextWord = ""
            END IF
        NEXT a
        IF LEN(nextWord) THEN CON.STDOUT Translation(nextWord);
        CON.STDOUT ""
        IF CON.STDEOF THEN EXIT DO
    LOOP

END FUNCTION

FUNCTION Translation (s AS STRING) AS STRING

    DIM allVowels AS INTEGER
    DIM allY AS INTEGER
    DIM allCons AS INTEGER
    DIM allUpper AS INTEGER
    DIM allLower AS INTEGER
    DIM capitalized AS INTEGER
    DIM firstVowelPos AS INTEGER
    DIM temp AS STRING
    DIM a AS INTEGER

    IF LEN(s) = 1 THEN
        ' Only one letter in length
        Translation = s
        EXIT FUNCTION
    END IF

    allVowels = %TRUE

    FOR a = 1 TO LEN(s)
        IF INSTR("AEIOUY", UCASE$(MID$(s, a, 1))) = 0 THEN
            allVowels = %FALSE
            EXIT FOR
        END IF
    NEXT a

    IF allVowels = %TRUE AND UCASE$(LEFT$(s, 1)) <> "Y" THEN
        Translation = s
        EXIT FUNCTION
    END IF

    IF allVowels = %TRUE THEN
        allY = %TRUE
        FOR a = 2 TO LEN(s)
            IF UCASE$(MID$(s, a, 1)) <> "Y" THEN
                allY = %FALSE
                EXIT FOR
            END IF
        NEXT a
        IF allY = %TRUE THEN
            Translation = s
            EXIT FUNCTION
        END IF
    END IF

    allCons = %TRUE

    FOR a = 1 TO LEN(s)
        IF INSTR("BCDFGHJKLMNPQRSTVWXZ", UCASE$(MID$(s, a, 1))) = 0 THEN
            allCons = %FALSE
            EXIT FOR
        END IF
    NEXT a

    IF allCons = %TRUE THEN
        Translation = s
        EXIT FUNCTION
    END IF

    allUpper = %TRUE

    FOR a = 1 TO LEN(s)
        IF ASC(MID$(s, a, 1)) >= 97 THEN
            allUpper = %FALSE
            EXIT FOR
        END IF
    NEXT a

    IF allUpper = %FALSE THEN
        allLower = %TRUE
        FOR a = 1 TO LEN(s)
            IF ASC(MID$(s, a, 1)) <= 90 THEN
                allLower = %FALSE
                EXIT FOR
            END IF
        NEXT a
    END IF

    IF allUpper = %FALSE AND allLower = %FALSE THEN
        capitalized = %TRUE
        IF ASC(LEFT$(s, 1)) <= 90 THEN
            FOR a = 2 TO LEN(s)
                IF ASC(MID$(s, a, 1)) <= 90 THEN
                    capitalized = %FALSE
                    EXIT FOR
                END IF
            NEXT a
        ELSE
            capitalized = %FALSE
        END IF
    END IF

    IF allUpper = %TRUE OR allLower = %TRUE THEN
        IF allLower = %TRUE THEN s = UCASE$(s)
        IF INSTR("AEIOU", MID$(s, 1, 1)) THEN
            IF INSTR("AEIOU", MID$(s, LEN(s), 1)) THEN
                SELECT CASE RND(1, 2)
                    CASE 1
                        temp = s + "WAY"
                    CASE 2
                        temp = s + "YAY"
                END SELECT
            ELSE
                SELECT CASE RND(1, 3)
                    CASE 1
                        temp = s + "AY"
                    CASE 2
                        temp = s + "WAY"
                    CASE 3
                        temp = s + "YAY"
                END SELECT
            END IF
        ELSE
            firstVowelPos = 0
            FOR a = 2 TO LEN(s)
                IF INSTR("AEIOUY", MID$(s, a, 1)) THEN
                    firstVowelPos = a
                    EXIT FOR
                END IF
            NEXT a
            IF firstVowelPos = 0 THEN
                temp = RIGHT$(s, LEN(s) - 1) + LEFT$(s, 1) + "AY"
            ELSE
                temp = RIGHT$(s, LEN(s) - firstVowelPos + 1) + LEFT$(s, firstVowelPos - 1) + "AY"
            END IF
        END IF
        IF allLower = %TRUE THEN temp = LCASE$(temp)
    ELSE
        s = LCASE$(s)
        IF INSTR("aeiou", MID$(s, 1, 1)) THEN
            IF INSTR("aeiou", MID$(s, LEN(s), 1)) THEN
                SELECT CASE RND(1, 2)
                    CASE 1
                        temp = s + "way"
                    CASE 2
                        temp = s + "yay"
                END SELECT
            ELSE
                SELECT CASE RND(1, 3)
                    CASE 1
                        temp = s + "ay"
                    CASE 2
                        temp = s + "way"
                    CASE 3
                        temp = s + "yay"
                END SELECT
            END IF
        ELSE
            firstVowelPos = 0
            FOR a = 2 TO LEN(s)
                IF INSTR("aeiouy", MID$(s, a, 1)) THEN
                    firstVowelPos = a
                    EXIT FOR
                END IF
            NEXT a
            IF firstVowelPos = 0 THEN
                temp = RIGHT$(s, LEN(s) - 1) + LEFT$(s, 1) + "ay"
            ELSE
                temp = RIGHT$(s, LEN(s) - firstVowelPos + 1) + LEFT$(s, firstVowelPos - 1) + "ay"
            END IF
        END IF
        MID$(temp, 1, 1) = CHR$(ASC(MID$(temp, 1, 1)) - 32)
        IF capitalized = %FALSE THEN
            ' Mixed case; convert to all upper
            temp = UCASE$(temp)
        END IF
    END IF

    Translation = temp

END FUNCTION
