Add-Type -AssemblyName System.Collections.Generic

[int16]$global:oldheight
[int16]$global:oldwidth

[byte]$global:screenheight = 43
[byte]$global:screenwidth = 83

[string]$global:mapstate = "local"

$global:tileset = @{ # tileset which corresponds to numeric value stored in the grid array
    0 = @{
        symbol = "~~"
        background = "darkblue"
        foreground = "blue"
        tilename = "water"
        walkable = $false
    }
    1 = @{
        symbol = "´,"
        background = "green"
        foreground = "darkgreen"
        tilename = "grass"
        walkable = $true
    }
    2 = @{
        symbol = "⇞⇞"
        background = "green"
        foreground = "darkgreen"
        tilename = "pinetrees"
        walkable = $false
    }
}

# these are used to translate human-readable coordinates to array coordinates and vice versa
[string[]]$global:xaxis = @("A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y")
[string[]]$global:yaxis = @("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25")

$global:world = @( #temp
    @(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0),
    @(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1),
    @(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1),
    @(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1),
    @(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1),
    @(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1),
    @(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1),
    @(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1),
    @(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1),
    @(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1),
    @(1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1),
    @(1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,1),
    @(1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1),
    @(1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1),
    @(1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1),
    @(1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),
    @(1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),
    @(1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),
    @(1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),
    @(1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),
    @(1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),
    @(1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),
    @(1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),
    @(1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),
    @(0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1)
)

$global:map = @( #temp
    @(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),
    @(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),
    @(1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,1,1,1,1,1,1,1,1),
    @(1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,2,2,2,1,1,1,1,1,1,1),
    @(1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,2,2,2,1,1,1,1,1,1,1),
    @(1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,1,1,1,1,1,1,1,1),
    @(1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,1,1,1,1,1,1,1,1),
    @(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),
    @(1,1,1,1,1,1,2,2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),
    @(1,1,1,1,1,1,2,2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),
    @(1,1,1,1,1,1,2,2,1,1,1,1,1,1,1,1,2,2,1,1,1,1,1,1,1),
    @(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,1,1,1,1),
    @(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,2,2,2,1,1,1,1),
    @(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),
    @(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),
    @(1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,1,1,1,1),
    @(1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,1,1,0,0,0,0,1,1,1,1),
    @(1,1,2,2,2,2,2,2,2,1,1,1,1,0,0,1,1,0,0,0,1,1,1,1,1),
    @(1,2,2,2,2,2,2,2,2,1,1,1,1,0,0,0,0,0,0,0,1,1,1,1,1),
    @(1,2,0,2,2,2,2,2,1,1,1,1,1,1,0,0,0,0,0,1,1,1,1,1,1),
    @(1,1,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),
    @(1,1,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),
    @(1,1,1,0,0,0,0,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),
    @(1,1,1,1,0,2,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),
    @(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1)
)

$global:grid = $global:map

[string[]]$global:sidebar = @(
    "sample sidebar line #1"
    "sample sidebar line #2"
    "sample sidebar line #3"
    "sample sidebar line #4"
    "sample sidebar line #5"
    "sample sidebar line #6"
    "sample sidebar line #7"
    "sample sidebar line #8"
    "sample sidebar line #9"
    "sample sidebar line #10"
    "sample sidebar line #11"
    "sample sidebar line #12"
    "sample sidebar line #13"
    "sample sidebar line #14"
    "sample sidebar line #15"
    "sample sidebar line #16"
    "sample sidebar line #17"
    "sample sidebar line #18"
    "sample sidebar line #19"
    "sample sidebar line #20"
    "sample sidebar line #21"
    "sample sidebar line #22"
    "sample sidebar line #23"
    "sample sidebar line #24"
    "sample sidebar line #25"
)

[string[]]$global:log = @()

for ($i = 0; $i -lt 10; $i++) { # fill log with empty lines
    $global:log += " "
}

function ToLog($message) { # add message to log
    $global:log += $message
    $global:log = $global:log[1..10]
}

function SpawnEntity($id, $type, $spawnx, $spawny) { # spawn entities
    if (-not $global:entities) {
        $global:entities = @{}
    }
    switch ($type) { # dictionary of all possible entities
        "player" {
            $global:entities[$id] = @{
                name = "Player"
                symbol = "Ť"
                color = "red"
                behavior = "player"
                health = 10
                attack = 1
                defense = 0
                ap = 5
                x = $spawnx
                y = $spawny
            }
        }
        "chest" {
            $global:entities[$id] = @{
                name = "Chest"
                symbol = "Ħ"
                color = "darkyellow"
                behavior = "none"
                health = 10
                attack = 0
                defense = 0
                ap = 0
                x = $spawnx
                y = $spawny
            }
        }
        "hog" {
            $global:entities[$id] = @{
                name = "Hog"
                symbol = "Ώ"
                color = "red"
                behavior = "rushdown"
                health = 10
                attack = 3
                defense = 1
                ap = 7
                x = $spawnx
                y = $spawny
            }
        }
    }
}

$global:highlightYellow = [System.Collections.Generic.List[System.Tuple[int16,int16]]]::new()

function RemoveEntity($id) {
    Remove-Item $global:entities[$id]
}

function GetEntityByBehavior($behavior) { # entities are retrieved by behavior
    foreach ($entity in $global:entities.Values) {
        if ($entity.behavior -eq $behavior) {
            return $entity
        }
    }
    return $null
}

$global:entities = @()

SpawnEntity 1 "player" (4 - 1) (16 - 1) # temp player spawnpoint
$global:player = GetEntityByBehavior("player")

SpawnEntity ($global:entities.Count + 1) "chest" (11 - 1) (23- 1)
SpawnEntity ($global:entities.Count + 1) "hog" (21 - 1) (5 - 1)

Clear-Host


function DrawMenu([string]$ml1, [string]$ml2, [string]$ml3, [byte]$height, [byte]$width) # temp
{
    [float]$ml1_spaces = ($width - $ml1.Length) / 2 - 1
    [float]$ml2_spaces = ($width - $ml2.Length) / 2 - 1
    [float]$ml3_spaces = ($width - $ml3.Length) / 2 - 1
    [float]$blank_height = ($height - 3) / 2
    Write-Host ("X" + ("-" * ($width - 2)) + "X")
    if (($blank_height % 2) -ne 1) {
        for (($temp1 = $blank_height - 2); $temp1 -gt 0; $temp1 --) { Write-Host ("|" + (" " * ($width - 2)) + "|") }
    } else {
        for (($temp1 = $blank_height - 1); $temp1 -gt 0; $temp1 --) { Write-Host ("|" + (" " * ($width - 2)) + "|") }
    }
    Write-Host ("|" + (" " * [math]::Floor($ml1_spaces)) + $ml1 + (" " * [math]::ceiling($ml1_spaces)) + "|")
    Write-Host ("|" + (" " * [math]::Floor($ml2_spaces)) + $ml2 + (" " * [math]::ceiling($ml2_spaces)) + "|")
    Write-Host ("|" + (" " * [math]::Floor($ml3_spaces)) + $ml3 + (" " * [math]::ceiling($ml3_spaces)) + "|")
    for (($temp2 = $blank_height - 1); $temp2 -gt 0; $temp2 --) { Write-Host ("|" + (" " * ($width - 2)) + "|") }
    Write-Host ("X" + ("-" * ($width - 2)) + "X")
}

function Init() {
    if ($IsWindows -eq $true) { # only works in v6+ powershell core
        $phost = Get-Host
        $global:oldheight = $phost.ui.rawui.windowsize.height
        $global:oldwidth = $phost.ui.rawui.windowsize.width
        $phost.ui.rawui.windowsize.height = $global:screenheight
        $phost.ui.rawui.windowsize.width = $global:screenwidth
        Clear-Host
    }else {
        Clear-Host
        DrawMenu -ml1 "This game is intended to run on Windows in PWSH core v6+" -ml2 "Running it in other system configurations may cause unforseen bugs" -ml3 "Enter 'Yes' to proceed anyway or 'No' to exit" -height ($global:screenheight - 1) -width ($global:screenwidth)
        $agree = Read-Host "Acknowledge?"
        if($agree -eq "Yes") {
            return($true)
        }elseif ($agree -eq "No") {
            Quit
        }else {
            Init
        }
    }
}

function DrawGrid() { # main function for drawing the grid
    Write-Host "    A B C D E F G H I J K L M N O P Q R S T U V W X Y "
    Write-Host "   X--------------------------------------------------X X-------------------------X"
    for ($y = 0; $y -lt 25; $y++) {
        if ($y -lt 9) {
            Write-Host ("0" + ([string]($y + 1)) + " |") -NoNewline
        } else {
            Write-Host ([string]($y + 1) + " |") -NoNewline
        }
        for ($x = 0; $x -lt 25; $x++) {
            $tile = $global:grid[$y][$x]
            $tileProperties = $global:tileset[$tile]
            $entityDrawn = $false
            foreach ($id in $global:entities.Keys) {
                $entity = $global:entities[$id]
                if ($entity.x -eq $x -and $entity.y -eq $y) {
                    [string]$halftile = $tileProperties.symbol.substring(0,1)
                    Write-Host $halftile -backgroundcolor $tileProperties.background -foregroundcolor $tileProperties.foreground -NoNewline
                    Write-Host $entity.symbol -backgroundcolor $tileProperties.background -foregroundcolor $entity.color -NoNewline
                    $entityDrawn = $true
                    break
                }
            }
            if (-not $entityDrawn) {
                $coordinates = [System.Tuple[int16,int16]]::new($x, $y)
                if ($global:highlightYellow.Contains($coordinates)) {
                    Write-Host $tileProperties.symbol -backgroundcolor yellow -foregroundcolor $tileProperties.foreground -NoNewline
                } else {
                    Write-Host $tileProperties.symbol -backgroundcolor $tileProperties.background -foregroundcolor $tileProperties.foreground -NoNewline
                }
            }
        }
        Write-Host "| | " -NoNewline
        [byte]$sidebarSpaces = (24 - $global:sidebar[$y].Length)
        Write-Host ($global:sidebar[$y] + (" " * $sidebarSpaces)) -NoNewline
        Write-Host "|"
    }
    Write-Host "   X--------------------------------------------------X X-------------------------X"
    Write-Host ""
    Write-Host "   X------------------------------------------------------------------------------X"
    for ($i = 0; $i -lt 10; $i++) {
            Write-Host ("   | " + $global:log[$i]) -NoNewline
            [byte]$logSpaces = (77 - $global:log[$i].Length)
            Write-Host (" " * $logSpaces) -NoNewline
            Write-Host "|"
    }
    Write-Host "   X------------------------------------------------------------------------------X"
}

function Redraw() { # utilitarian function that calls other redraw functions
    Clear-Host
    Write-Host "   " -NoNewline
    Write-Host "Map State: " -NoNewline
    if ($global:mapstate -eq "local") {
        Write-Host "local" -foregroundcolor red -NoNewline
    }else {
        Write-Host "global" -foregroundcolor blue -NoNewline
    }
    Write-Host " " -NoNewline
    Write-Host "Player Location: " -NoNewline
    Write-Host ($global:xaxis[$global:player.x] + $global:yaxis[$global:player.y]) -foregroundcolor green -NoNewline
    Write-Host ""
    DrawGrid
    Write-Host ""
}

function MovePlayer() { # uses MoveEntity to move player char
    Write-Host "   " -NoNewline
    [string]$newlocation = Read-Host "Enter new location in XYY format"
    [string]$newx = $newlocation.substring(0,1)
    if ($newlocation.length -eq 2) { [string]$newy = "0" + $newlocation.substring(1,1) } else { [string]$newy = $newlocation.substring(1,2) }
    [byte]$newx = [array]::indexof($global:xaxis,$newx)
    [byte]$newy = [array]::indexof($global:yaxis,$newy)

    ToLog "Moving to $newlocation..."
    if ($newx -eq $global:player.x -and $newy -eq $global:player.y) {
        ToLog "Already at destination!"
        Redraw
        return
    } elseif ($newx -lt 0 -or $newx -gt 24 -or $newy -lt 0 -or $newy -gt 24) {
        ToLog "Destination out of bounds!"
        Redraw
        return
    } elseif ($global:tileset[$global:grid[$newy][$newx]].walkable -eq $false) {
        ToLog "Invalid Destination!"
        Redraw
        return
    }
    foreach ($entity in $global:entities.Values) {
        if ($entity.x -eq $newx -and $entity.y -eq $newy) {
            ToLog ("There is a " + $entity.name + " at the destination!")
            Redraw
            return
        }
    }

    $path = [System.Collections.Generic.List[System.Tuple[int16,int16]]]::new()
    $path = MoveEntity $global:player.x $global:player.y $newx $newy

    if ($path.Count -eq 0) {
        ToLog "No path found!"
        Redraw
        return
    }

    foreach ($tile in $path) {
        $global:highlightYellow.Add($tile)
    }
    foreach ($tile in $path) {
        $global:highlightYellow.Remove($tile)
        $global:player.x = $tile.Item1
        $global:player.y = $tile.Item2
        Redraw
        Start-Sleep 1s
    }
    ToLog "Destination reached!"
    Redraw
}

function MoveEntity([byte]$oldx, [byte]$oldy, [byte]$newx, [byte]$newy) { # takes set of old and new coordinates and returns a list of coordinates between them
    $queue = [System.Collections.Generic.List[System.Tuple[int16,int16]]]::new() # x&y tuple (queue of tiles to iterate through)
    $previous = @(@(), @()) # x&y of current, x&y of previous (list of preferred tile connections)
    $distances = @(@(), @()) # x&y tuple, distance (list of tiles and their distances from start)
    $visited = @(@(), @()) # x, y (list of every tile that has been checked)

    for ($y = 0; $y -lt 25; $y++) { # init $distances
        for ($x = 0; $x -lt 25; $x++) {
            if ($y -eq $oldy -and $x -eq $oldx) {
                $distances[0] += [System.Tuple[int16,int16]]::new($x, $y)
                $distances[1] += 0
            } else {
                $distances[0] += [System.Tuple[int16,int16]]::new($x, $y)
                $distances[1] += 9999
            }
        }
    }

    $queue.Add([System.Tuple[int16,int16]]::new($oldx, $oldy)) # add starting tile to queue

    while ($queue.Count -gt 0) { # iterate through $queue until it's empty or destination is reached
        $currentTileX = $queue[0].Item1
        $currentTileY = $queue[0].Item2

        if ($currentTileX -eq $newx -and $currentTileY -eq $newy) { break }

        $visited[0] += $currentTileX
        $visited[1] += $currentTileY

        $queue.RemoveAt(0) # removes current tile from queue (first element)

        foreach ($neighbor in (GetNeighbors $currentTileX $currentTileY)) { # iterate through neighbors of current tile
            if ($visited[0] -contains $neighbor.Item1 -and $visited[1][[array]::indexof($visited[0], $neighbor.Item1)] -eq $neighbor.Item2) { continue } # break loop if neighbor has been visited
            if ($neighbor.Item1 -eq $currentTileX -or $neighbor.Item2 -eq $currentTileY) { $distance = 1 } else { $distance = 1.7 } # if neighbor is diagonal distance is 1.7, otherwise 1
            if (($distance + $distances[1][[array]::indexof($distances[0], [System.Tuple[int16,int16]]::new($currentTileX, $currentTileY))]) -lt $distances[1][[array]::indexof($distances[0], [System.Tuple[int16,int16]]::new($neighbor.Item1, $neighbor.Item2))]) {
                $distances[1][[array]::indexof($distances[0], [System.Tuple[int16,int16]]::new($neighbor.Item1, $neighbor.Item2))] = ($distance + $distances[1][[array]::indexof($distances[0], [System.Tuple[int16,int16]]::new($currentTileX, $currentTileY))])
                $queue.Add($neighbor) # if the distance from the current tile + distance to current tile from start is greater than the old distance to the neighbor, replace it, add neighbor to queue, and add current tile to previous for this neighbor
                if ($previous[0] -contains $neighbor -eq $true) {
                    $previous[1][[array]::indexof($previous[0], $neighbor)] = [System.Tuple[int16,int16]]::new($currentTileX, $currentTileY)
                } else {
                    $previous[0] += $neighbor
                    $previous[1] += [System.Tuple[int16,int16]]::new($currentTileX, $currentTileY)
                }
            }
        }
    }

    $path = [System.Collections.Generic.List[System.Tuple[int16,int16]]]::new() # builds complete path based on $previous array
    $tile = [System.Tuple[int16,int16]]::new($newx, $newy)

    if ($distances[1][[array]::indexof($distances[0], [System.Tuple[int16,int16]]::new($newx, $newy))] -eq 9999) { # if destination is unreachable, return empty list
        return $path
    }

    while ($true) {
        $path.Add([System.Tuple[int16,int16]]::new($tile.Item1, $tile.Item2))
        if ($tile -eq ([System.Tuple[int16,int16]]::new($oldx, $oldy))) { break }
        $tile = $previous[1][[array]::indexof($previous[0], $tile)]
    }
    $path.Reverse()
    return $path
}

function GetNeighbors([int16]$x, [int16]$y) { # will be modified later to only return neighbors that are valid and aren't occupied
    $directions = @(
        [System.Tuple[int16,int16]]::new(1,0),
        [System.Tuple[int16,int16]]::new(-1,0),
        [System.Tuple[int16,int16]]::new(0,1),
        [System.Tuple[int16,int16]]::new(0,-1),
        [System.Tuple[int16,int16]]::new(1,1),
        [System.Tuple[int16,int16]]::new(-1,-1),
        [System.Tuple[int16,int16]]::new(1,-1),
        [System.Tuple[int16,int16]]::new(-1,1)
    )
    $neighbors = foreach ($direction in $directions) {
        $neighbor = [System.Tuple[int16,int16]]::new($x+$direction.Item1, $y+$direction.Item2)
        if ($neighbor.Item1 -ge 0 -and $neighbor.Item1 -lt 25 -and $neighbor.Item2 -ge 0 -and $neighbor.Item2 -lt 25) { # if neighbor is within bounds of map
            foreach ($entity in $global:entities.Values) { if ($entity.x -eq $neighbor.Item1 -and $entity.y -eq $neighbor.Item2) { continue } } # if neighbor is occupied by an entity, skip to next neighbor
            if ($global:tileset[$global:grid[$neighbor.Item2][$neighbor.Item1]].walkable -eq $false) { continue } # if neighbor is not walkable, skip to next neighbor
            if ($direction.Item1 -ne 0 -and $direction.Item2 -ne 0) { # if neighbor is diagonal and either adjacent tile is not walkable, skip to next neighbor
                $adjacent1 = [System.Tuple[int16,int16]]::new($x+$direction.Item1, $y)
                $adjacent2 = [System.Tuple[int16,int16]]::new($x, $y+$direction.Item2)
                if ($global:tileset[$global:grid[$adjacent1.Item2][$adjacent1.Item1]].walkable -eq $false -or $global:tileset[$global:grid[$adjacent2.Item2][$adjacent2.Item1]].walkable -eq $false) {
                    continue
                }
            }
            $neighbor
        }
    }
    return $neighbors
}

function ToggleMap() {
    if ($global:localMap -eq $true) {
        $global:localMap = $false
        $global:grid = $global:world
    }else {
        $global:localMap = $true
        $global:grid = $global:map
    }
}

function GetTileset() { #debug
    Clear-Host
    Write-Host "tile test"
    foreach ($tile in $global:tileset.Keys) {
        Write-Host $global:tileset[$tile].symbol -backgroundcolor $global:tileset[$tile].background -foregroundcolor $global:tileset[$tile].foreground -NoNewline
        Write-Host (" " + $global:tileset[$tile].tilename)
    }
    Start-Sleep 5s
}

function Quit() { # clean way of exiting the game, but frankly unnecessary
    Clear-Host # can be updated later to clear variable values and save game state
    if ($IsWindows -eq $true) {
    $phost.ui.rawui.windowsize.height = $global:oldheight
    $phost.ui.rawui.windowsize.width = $global:oldwidth
    }
    exit
}

function Prompt() { # calls any function by name with user input from command line; primary way of interacting with the game
    Write-Host "   " -NoNewline
    $command = Read-Host "Enter command"
    Redraw
    if ($true) { # if statement is placeholder for a command list (not all functions should be user-callable)
    $ScriptBlock = (get-item Function:\$command).ScriptBlock
    Invoke-Command -ScriptBlock $ScriptBlock
    }
    Redraw
}

Init
Redraw

while ($true) {
    #Prompt
    MovePlayer # prompt is replaced with MovePlayer for demo purposes
}

exit
