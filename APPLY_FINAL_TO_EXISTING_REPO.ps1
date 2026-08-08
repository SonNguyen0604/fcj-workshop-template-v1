Add-Type -AssemblyName System.Windows.Forms

$source = Join-Path $PSScriptRoot 'fcj-workshop-template-v1-main'
if (-not (Test-Path $source)) {
    [System.Windows.Forms.MessageBox]::Show('Khong tim thay thu muc source da chinh sua.', 'FCAJ Workshop') | Out-Null
    exit 1
}

$dialog = New-Object System.Windows.Forms.FolderBrowserDialog
$dialog.Description = 'Chon thu muc repo GitHub Desktop: fcj-workshop-template-v1'
$dialog.ShowNewFolderButton = $false
$result = $dialog.ShowDialog()
if ($result -ne [System.Windows.Forms.DialogResult]::OK) { exit 0 }

$target = $dialog.SelectedPath
if ((Split-Path $target -Leaf) -ne 'fcj-workshop-template-v1') {
    [System.Windows.Forms.MessageBox]::Show('Ban phai chon dung thu muc fcj-workshop-template-v1. Khong co file nao bi thay doi.', 'FCAJ Workshop') | Out-Null
    exit 1
}

if (-not (Test-Path (Join-Path $target '.git'))) {
    [System.Windows.Forms.MessageBox]::Show('Thu muc da chon khong co .git. Hay chon repo da clone bang GitHub Desktop.', 'FCAJ Workshop') | Out-Null
    exit 1
}

$confirm = [System.Windows.Forms.MessageBox]::Show(
    "Se xoa cac file cu/thua trong repo (giu nguyen .git) va thay bang ban FINAL sach. Tiep tuc?`n`n$target",
    'FCAJ Workshop',
    [System.Windows.Forms.MessageBoxButtons]::YesNo,
    [System.Windows.Forms.MessageBoxIcon]::Warning
)
if ($confirm -ne [System.Windows.Forms.DialogResult]::Yes) { exit 0 }

# Remove everything except the Git metadata so stale template files cannot remain.
Get-ChildItem -LiteralPath $target -Force | Where-Object { $_.Name -ne '.git' } | Remove-Item -Recurse -Force

# Copy every clean source item, including dotfiles such as .github and .gitignore.
Get-ChildItem -LiteralPath $source -Force | ForEach-Object {
    Copy-Item -LiteralPath $_.FullName -Destination $target -Recurse -Force
}

[System.Windows.Forms.MessageBox]::Show(
    'Da cap nhat repo local thanh ban FINAL sach. Mo GitHub Desktop -> Commit to main -> Push origin.',
    'FCAJ Workshop'
) | Out-Null
