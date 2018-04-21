@ECHO OFF

REM Author          David Freer [soulshined@me.com]
REM Build Date      4/20/2017
REM Version         1.0

REM $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
REM $$$$$$$$$$$$$$$$   INTRODUCTION   $$$$$$$$$$$$$$$$$$$$$
REM $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
:: THIS PROGRAM SEARCHES A SPECIFIED FOLDER FOR DIFFERENT
:: EXTENSION TYPES AND MOVES THEM TO THEIR OWN RESPECTIVE
:: SUB-FOLDER BASED ON YOUR NEEDS. IT'S INTENTION WAS TO
:: HELP DECLUTTER MY DOWNLOADS FOLDER AND ORGANIZE IT IN
:: A WAY THAT ALL RELATED FILES WERE GROUPED. BUT TO EACH
:: THEIR OWN
::
:: RECOMMENDATIONS; ADD A NEW WINDOWS TASK
:: IN THE TASK SCHEDULRE FOR IT TO CONTINUALLY RUN AND ORGANIZE
:: YOUR FILES

:: IF YOU WANT TO RUN THIS IN THE TASK SCHEDULER AS A HIDDEN WINDOW
:: LINK THE TASK TO THE INCLUDED DOWNLOADS-ORGANIZER-INVISIBLE.VBS SCRIPT INSTEAD OF THIS ONE

REM $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
REM $$$$$$$$$$$$$$$$   CONFIGURATIONS  $$$$$$$$$$$$$$$$$$$$
REM $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

::SET IS_DEBUG TO 'TRUE' IF YOU WANT TO DISPLAY SCRIPT RESULTS IN CONSOLE
SET "IS_DEBUG="

:: DIR_PATH IS THE DIRECTORY/FOLDER TO MONITOR. DO NOT INCLUDE TRAILING "\"
SET DIR_PATH="D:\Your User Name\Downloads"

:: THE FOLLOWING DIRECTORIES ARE WHERE YOU WANT FOUND EXTENSION FILES TO GO
:: THIS ASSUMES THEY WILL BE A SUB DIRECTORY OF THE DIR_PATH LISTED ABOVE.
:: IF THE DIR PATH IS NOT FOUND, IT WILL CREATE THE FOLDER

:: IF THE SUBDIR PATHS BELOW ARE OMITTED AND LEFT AS IS,
:: NO FILES WILL BE MOVED FOR THAT TYPE, EVEN IF THE EXTENSION TYPES ARE SPECIFIED

:: WHEN THERE ARE MANY FILE EXTENSIONS, THEY SHOULD BE APPENDED WITH ONLY A SPACE
::PDF FILES
SET PDF_SUBDIR=""

::PRODUCTIVITY FILES
SET OFFICE_SUBDIR="Office"
SET OFFICE_FILTER="*.doc *.docx *.msg *.wpd *.wps *.pps *.ppt *.pptx *.pptm *.potx *.ppam *.ppsx *.ppsm *.sldx *.sldm *.xlr *.xls *.xlt *.xlm *.xlsx *.xlsm *.xltx *.xltm"

SET IMAGE_SUBDIR="Photos"
SET IMAGE_FILTER="*.png *.jpg *.jpeg *.gif *.tiff *.tif *.bmp *.svg *.psd *.pspimage"

SET MOVIE_SUBDIR="Movies"
SET MOVIE_FILTER="*.avi *.flv *.m4v *.mov *.mp4 *.mpg *.rm *.srt *.swf *.vob *.wmv"

SET AUDIO_SUBDIR="Audio"
SET AUDIO_FILTER="*.mp3 *.wav *.aif *.mpa *.wma"

::PROGRAM / APPS
SET EXE_SUBDIR=""
SET EXE_FILTER="*.apk *.app *.bat *.cgi *.com *.exe *.jar"

REM $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
REM $$$$$$$$$$$$$$   END CONFIGURATIONS  $$$$$$$$$$$$$$$$$$
REM $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

:: DO NOT EDIT CODE BELOW THIS POINT UNLESS YOUR COMFORTABLE WITH THE SYNTAX
:: DO NOT EDIT CODE BELOW THIS POINT UNLESS YOUR COMFORTABLE WITH THE SYNTAX
:: DO NOT EDIT CODE BELOW THIS POINT UNLESS YOUR COMFORTABLE WITH THE SYNTAX
:: DO NOT EDIT CODE BELOW THIS POINT UNLESS YOUR COMFORTABLE WITH THE SYNTAX
:: DO NOT EDIT CODE BELOW THIS POINT UNLESS YOUR COMFORTABLE WITH THE SYNTAX
:: DO NOT EDIT CODE BELOW THIS POINT UNLESS YOUR COMFORTABLE WITH THE SYNTAX
:: DO NOT EDIT CODE BELOW THIS POINT UNLESS YOUR COMFORTABLE WITH THE SYNTAX

REM $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
REM $$$$$$$$$$$$$$$$$$$$$   BEGIN    $$$$$$$$$$$$$$$$$$$$$$
REM $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
SET REDEF_DIR_PATH=%DIR_PATH:"=%\
IF NOT EXIST "%REDEF_DIR_PATH%" GOTO HANDLE_NO_DIR

CD /D "%REDEF_DIR_PATH%"

REM $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
REM $$$$$$$$$$$$$$$$$$$$$   MOVES    $$$$$$$$$$$$$$$$$$$$$$
REM $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
SET REDEF_PDF_DIR=%REDEF_DIR_PATH%%PDF_SUBDIR:"=%\
SET REDEF_OFFICE_DIR=%REDEF_DIR_PATH%%OFFICE_SUBDIR:"=%\
SET REDEF_IMAGE_DIR=%REDEF_DIR_PATH%%IMAGE_SUBDIR:"=%\
SET REDEF_AUDIO_DIR=%REDEF_DIR_PATH%%AUDIO_SUBDIR:"=%\
SET REDEF_MOVIE_DIR=%REDEF_DIR_PATH%%MOVIE_SUBDIR:"=%\
SET REDEF_EXE_DIR=%REDEF_DIR_PATH%%EXE_SUBDIR:"=%\

IF DEFINED IS_DEBUG (
  COLOR F9
  ECHO.
  ECHO.
  ECHO        =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  ECHO        #                                       #
  ECHO        #       DOWNLOADS ORGANIZER V1.0        #
  ECHO        #                                       #
  ECHO        =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  ECHO.
  ECHO.
)

CALL:ConsoleLogExtnCount "*.pdf" "PDF"
IF NOT %PDF_SUBDIR%=="" (
  IF DEFINED IS_DEBUG ECHO PDF SUB DIRECTORY IS DEFINED BY USER -- MOVING THE FOLLOWING PDF FILES:
  ECHO.
  IF NOT EXIST "%REDEF_PDF_DIR%" MKDIR %PDF_SUBDIR%
  IF EXIST *.pdf MOVE /Y *.pdf %PDF_SUBDIR%
)
CALL:PRINT_DIVIDER

CALL:ConsoleLogExtnCount %OFFICE_FILTER%, OFFICE
IF NOT %OFFICE_SUBDIR%=="" (
  ECHO.
  CALL:MoveFilesToDirForCategory %OFFICE_FILTER%, "%REDEF_OFFICE_DIR%", "OFFICE"
)
CALL:PRINT_DIVIDER

CALL:ConsoleLogExtnCount %IMAGE_FILTER%, IMAGE
IF NOT %IMAGE_SUBDIR%=="" (
  ECHO.
  CALL:MoveFilesToDirForCategory %IMAGE_FILTER%, "%REDEF_IMAGE_DIR%", "IMAGE"
)
CALL:PRINT_DIVIDER

CALL:ConsoleLogExtnCount %AUDIO_FILTER%, AUDIO
IF NOT %AUDIO_SUBDIR%=="" (
  ECHO.
  CALL:MoveFilesToDirForCategory %AUDIO_FILTER%, "%REDEF_AUDIO_DIR%", "AUDIO"
)
CALL:PRINT_DIVIDER

CALL:ConsoleLogExtnCount %MOVIE_FILTER%, MOVIE
IF NOT %MOVIE_SUBDIR%=="" (
  ECHO.
  CALL:MoveFilesToDirForCategory %MOVIE_FILTER%, "%REDEF_MOVIE_DIR%", "MOVIE"
)
CALL:PRINT_DIVIDER

CALL:ConsoleLogExtnCount %EXE_FILTER%, EXECUTABLE
IF NOT %EXE_SUBDIR%=="" (
  ECHO.
  CALL:MoveFilesToDirForCategory %EXE_FILTER%, "%REDEF_EXE_DIR%", "EXECUTABLE"
)
CALL:PRINT_DIVIDER

IF DEFINED IS_DEBUG PAUSE
EXIT /B 0

:HANDLE_NO_DIR
CALL:MsgBox "The specified directory to organize can not be found.\nPath to calling script: %~dp0" "16" "Downloads Organizer Error"
EXIT /B 1

REM $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
REM $$$$$$$$$$$$$$$$$$   FUNCTIONS    $$$$$$$$$$$$$$$$$$$$$
REM $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
:: THE BELOW SCRIPT HANDLES MOVING THE FILES AND VALIDATING EXISTENCE TO
:: THEIR RESPECTIVE SUBDIRECTORY
:MoveFilesToDirForCategory <Extn> <ToDir> <Cat>
IF DEFINED IS_DEBUG ECHO %~3 SUB DIRECTORY IS DEFINED BY USER -- MOVING THE FOLLOWING %~3 FILES:
ECHO.
IF NOT EXIST "%~2" MKDIR "%~2"
FOR %%? IN (%~1) DO (
  ECHO %%?
  MOVE /Y "%%?" "%~2"
)
EXIT /B

:: Below script counts the number of files in a directory based on a
:: passed extension (extension format should be: *.ext and can be compounded)
:: Ex: CALL:ConsoleLogExtnCount "*.png *.jpg"
:ConsoleLogExtnCount <Extn> <Cat>
ECHO [] %~2 CATEGORY
ECHO.
SETLOCAL ENABLEDELAYEDEXPANSION
SET /A cnt=0
FOR %%? IN (%~1) DO (
  ECHO %%~t?    %%~n?%%~x?
  SET /A cnt+=1
)
ECHO.
ECHO                        - FOUND %~2 ITEMS: !cnt!
ECHO.
ENDLOCAL
EXIT /B

:: Below script simply populates a windows alert box and displays
:: a message
:MsgBox <Msg> <Type> <Title>
ECHO MsgBox Replace("%~1","\n",vbCrLf),"%~2","%~3" > "a.vbs"
Cscript /nologo "a.vbs" & Del "a.vbs"
EXIT /B

::SIMPLY FOR ASETHETICS
:PRINT_DIVIDER
ECHO =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
ECHO.
