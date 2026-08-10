# Shared exit helper for Stellar Xeno tools.
# portrait-pipeline.ps1 sets STELLAR_DOGOS_INPROCESS=1 and invokes tools with & so
# name + xenotype prompts share the same console. In that mode, bare `exit` would
# kill the whole pipeline — use Exit-SdTool then `return` instead.
#
# STELLAR_DOGOS_PIPELINE=1 means the end-to-end creator owns player-facing messages;
# child tools stay quiet except for prompts/errors.

function Test-SdPipelineMode {
    return ($env:STELLAR_DOGOS_PIPELINE -eq "1")
}

function Exit-SdTool {
    param(
        [int]$Code = 0
    )

    $global:STELLAR_DOGOS_EXITCODE = $Code
    if ($env:STELLAR_DOGOS_INPROCESS -ne "1") {
        exit $Code
    }
}

function Write-SdHost {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0)]
        [object]$Object = "",
        [switch]$NoNewline,
        [ConsoleColor]$ForegroundColor
    )

    if (Test-SdPipelineMode) { return }

    if ($PSBoundParameters.ContainsKey("ForegroundColor")) {
        if ($NoNewline) {
            Write-Host -Object $Object -NoNewline -ForegroundColor $ForegroundColor
        } else {
            Write-Host -Object $Object -ForegroundColor $ForegroundColor
        }
    } else {
        if ($NoNewline) {
            Write-Host -Object $Object -NoNewline
        } else {
            Write-Host -Object $Object
        }
    }
}
