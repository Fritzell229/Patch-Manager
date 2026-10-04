$cheminFichier = Join-Path $PSScriptRoot "..\config\computers.txt"
$machines = Import-Csv -Path $cheminFichier -Delimiter ';' -Header Nom,IP

$resultats = foreach ($m in $machines) {
    $ok = Test-Connection -ComputerName $m.IP -Count 1 -Quiet
    [PSCustomObject]@{
        Poste = $m.Nom
        IP    = $m.IP
        Etat  = if ($ok) { 'Accessible' } else { 'Inaccessible' }
    }
}

$resultats | Format-Table -AutoSize