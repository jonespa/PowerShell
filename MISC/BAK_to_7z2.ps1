##############################################################################################################
#																							                 #
#                                      Daily scripts for .BAK to .7Z files                                   #
#                                                         									                 #
##############################################################################################################

##############################################################################################################
# Uses 7zip to compress each BAK file to a high compression level .7z file.                                  #
##############################################################################################################

Get-ChildItem *.bak | ForEach-Object { & "C:\Program Files\7-Zip\7z.exe" a -t7z -mx3 ($_.Name+".7z") $_.Name }
Get-ChildItem *.properties | ForEach-Object { & "C:\Program Files\7-Zip\7z.exe" a -t7z -mx3 ($_.Name+".7z") $_.Name }

##############################################################################################################
# Line 1 - Creates a new folder and keeps the location as a constant for this instance of the script, named  #
# for the current date, in format yyyy-MM-dd.                                                                #
# Line 2 - Copies the .7z files to the folder yyyy-MM-dd.                                                    #
# Line 3 - Copies the folder, including contents to the DR site                                              #
##############################################################################################################

$Folder = New-Item -ItemType Directory -Path "E:\Backup\Daily\$((Get-Date).AddDays(-1).ToString('yyyy-MM-dd'))"

Get-ChildItem 'E:\Backup\HFOE01\openedge\*.7z' | Copy-Item -Destination $Folder

Copy-Item $Folder \\DRBACKUP01\D$\Backups\daily\ -Recurse

##############################################################################################################
# Copies BAK files from original location to an archive location                                             #
##############################################################################################################

Copy-Item E:\Backup\HFOE01\openedge\*.BAK E:\Backup\HFOE01\openedge\Old\

##############################################################################################################
# Removes BAK file from original location                                                                    #
##############################################################################################################

Remove-Item E:\Backup\HFOE01\openedge\*.BAK

##############################################################################################################
# Removes 7z file from original location                                                                     #
##############################################################################################################

Remove-Item E:\Backup\HFOE01\openedge\*.7z