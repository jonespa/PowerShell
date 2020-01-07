<# Give you timeleft before NewYear
Wish you an happy NewYear if 1st january #>

Function Get-HappyNewYear {
    # Variables
    $Now = Get-Date
    $ActualYear = $Now.Year
    $NextYear = $ActualYear + 1
    $TimeLeft = New-TimeSpan -Start $Now -End ("01-01-$NextYear" -as [datetime])

    $d = $TimeLeft.Days
    $m = $TimeLeft.Minutes
    $s = $TimeLeft.Seconds
    $Totalh = [math]::Round($TimeLeft.TotalHours)

    # Job
    if ($now.day -eq 1 -and $now.month -eq 1) {

        Write-Host "HAPPY NEW YEAR $ActualYear!!!" -ForegroundColor Red -BackgroundColor Yellow
        Write-Host "*    *
        *         '       *       .  *   '     .           * *
                                                                    '
            *                *'          *          *        '
        .           *               |               /
                    '.         |    |      '       |   '     *
                      \*        \   \             /
            '          \     '* |    |  *        |*                *  *
                 *      `.       \   |     *     /    *      '
        .                  \      |   \          /               *
          *'  *     '      \      \   '.       |
             -._            `                  /         *
        ' '      ``._   *                           '          .      '
        *           *\*          * .   .      *
        *  '        *    `-._                       .         _..:='        *
                  .  '      *       *    *   .       _.:--'
               *           .     .     *         .-'         *
        .               '             . '   *           *         .
        *       ___.-=--..-._     *                '               '
                                       *       *
                     *        _.'  .'       `.        '  *             *
          *              *_.-'   .'            `.               *
                        .'                       `._             *  '
        '       '                        .       .  `.     .
            .                      *                  `
                    *        '             '                          .
          .                          *        .           *  *
                  *        .                                    '" -ForegroundColor Red -BackgroundColor Yellow

    }
    else {
        if ($d -gt 1 -and $m -gt 1 -and $s -gt 1) {
            Write-Host "There are $d days, $m minutes and $s seconds left before the New Year!"
        }
        elseif ($d -gt 1 -and $m -gt 1 -and $s -le 1) {
            Write-Host "There are $d days, $m minutes and $s second left before the New Year!"
        }
        elseif ($d -gt 1 -and $m -le 1 -and $s -le 1) {
            Write-Host "There are $d days, $m minute and $s second left before the New Year!"
        }
        elseif ($d -le 1 -and $m -le 1 -and $s -le 1) {
            Write-Host "There is $d day, $m minute and $s second left before the New Year!"
        }
        elseif ($d -le 1 -and $m -le 1 -and $s -gt 1) {
            Write-Host "There is $d day, $m minute and $s seconds left before the New Year!"
        }
        elseif ($d -le 1 -and $m -gt 1 -and $s -gt 1) {
            Write-Host "There is $d day, $m minutes and $s seconds left before the New Year!"
        }

        if (($Totalh -gt 1) -and ($m -gt 1)) {
            Write-Host "So... Be patient, the new year is in $Totalh hours and $m minutes!"
        }
        elseif (($Totalh -eq 1) -and ($m -gt 1)) {
            Write-Host "So... Be patient, the new year is in $Totalh hour and $m minutes!"
        }
        elseif (($Totalh -eq 1) -and ($m -eq 1)) {
            Write-Host "So... Be patient, the new year is in $Totalh hour and $m minute!"
        }
        elseif (($Totalh -gt 1) -and ($m -eq 0)) {
            Write-Host "So... Be patient, the new year is in $Totalh hours!"
        }
        elseif (($Totalh -eq 1) -and ($m -eq 0)) {
            Write-Host "So... Be patient, the new year is in $Totalh hour!"
        }
        elseif (($Totalh -eq 0) -and ($m -gt 1)) {
            Write-Host "So... Be patient, the new year is in $m minutes!"
        }
        elseif (($Totalh -eq 0) -and ($m -eq 1)) {
            Write-Host "So... Be patient, the new year is in $m minute!"
        }
    }
}

Do {
    Clear
    Get-HappyNewYear
    sleep 1
}
While ($true)