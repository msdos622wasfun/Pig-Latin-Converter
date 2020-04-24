#RESOURCE VERSIONINFO

#IF %DEF(%BETAVERSION)
    #RESOURCE FILEFLAGS %VS_FF_PRERELEASE
#ELSE
    #RESOURCE FILEFLAGS 0
#ENDIF

#RESOURCE FILEVERSION 1, 0, 2, 0
#RESOURCE PRODUCTVERSION 1, 0, 2, 0

#RESOURCE STRINGINFO "0409", "04B0"

#RESOURCE VERSION$ "CompanyName",      "Erich Kohl"
#RESOURCE VERSION$ "FileDescription",  "Pig Latin Converter"
#RESOURCE VERSION$ "FileVersion",      "01.02.0000"
#RESOURCE VERSION$ "InternalName",     "PIGLATIN"
#RESOURCE VERSION$ "OriginalFilename", "PIGLATIN.EXE"
#RESOURCE VERSION$ "LegalCopyright",   "Copyleft 2020 by Erich Kohl"
#RESOURCE VERSION$ "ProductName",      "Pig Latin Converter"
#RESOURCE VERSION$ "ProductVersion",   "01.02.0000"
#RESOURCE VERSION$ "Comments",         "Enjoy this utility."
