# Open README.md and replace the conflict section
$content = Get-Content README.md -Raw
$fixedContent = $content -replace "<<<<<<< HEAD\r?\n# Financial Market Forecaster\r?\n=======\r?\n# financial-forecaster\r?\n>>>>>>> 254994a0dbed598946d4bfda1bd9f55b25ab5f00", "# Financial Market Forecaster"
Set-Content -Path README.md -Value $fixedContent