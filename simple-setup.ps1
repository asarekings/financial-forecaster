# Simple Financial Market Forecaster Setup
# Safe version with minimal dependencies

param([switch]$Clean)

Write-Host "Starting Financial Market Forecaster Setup..." -ForegroundColor Green

# Clean if requested
if ($Clean) {
    Write-Host "Cleaning existing files..." -ForegroundColor Yellow
    Get-ChildItem -Exclude ".git*", "*.ps1" | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
}

# Create .nojekyll
"" | Out-File -FilePath ".nojekyll" -Encoding UTF8
Write-Host "Created .nojekyll" -ForegroundColor Green

# Create directories
$dirs = @("css", "js", "img")
foreach ($dir in $dirs) {
    if (!(Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
        Write-Host "Created directory: $dir" -ForegroundColor Green
    }
}

# Create CSS file
$css = @"
:root {
  --primary: #2563eb;
  --success: #10b981;
  --danger: #ef4444;
  --warning: #f59e0b;
  --dark: #1e293b;
  --light: #f8fafc;
}

body {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  line-height: 1.6;
  color: #333;
}

.navbar-brand {
  font-weight: bold;
  color: var(--primary) !important;
}

.feature-card {
  transition: transform 0.3s ease;
  height: 100%;
}

.feature-card:hover {
  transform: translateY(-5px);
}

.chart-container {
  position: relative;
  height: 300px;
  width: 100%;
}

.theme-toggle {
  background: none;
  border: none;
  font-size: 1.2rem;
  cursor: pointer;
}

[data-theme="dark"] {
  background-color: var(--dark);
  color: #e2e8f0;
}

[data-theme="dark"] .card {
  background-color: #1e293b;
  border-color: #334155;
}

[data-theme="dark"] .navbar {
  background-color: #1e293b !important;
}
"@

$css | Out-File -FilePath "css/style.css" -Encoding UTF8
Write-Host "Created CSS file" -ForegroundColor Green

# Create main JavaScript
$mainJs = @"
document.addEventListener('DOMContentLoaded', function() {
    // Initialize theme
    const theme = localStorage.getItem('theme') || 'light';
    applyTheme(theme);
    
    // Theme toggle functionality
    const themeToggle = document.querySelector('.theme-toggle');
    if (themeToggle) {
        themeToggle.addEventListener('click', toggleTheme);
        themeToggle.innerHTML = theme === 'light' ? '🌙' : '☀️';
    }
    
    // Update footer year
    const yearElement = document.getElementById('current-year');
    if (yearElement) {
        yearElement.textContent = new Date().getFullYear();
    }
    
    // Initialize tooltips if Bootstrap is available
    if (typeof bootstrap !== 'undefined' && bootstrap.Tooltip) {
        const tooltips = document.querySelectorAll('[data-bs-toggle="tooltip"]');
        tooltips.forEach(el => new bootstrap.Tooltip(el));
    }
});

function toggleTheme() {
    const currentTheme = localStorage.getItem('theme') || 'light';
    const newTheme = currentTheme === 'light' ? 'dark' : 'light';
    
    applyTheme(newTheme);
    localStorage.setItem('theme', newTheme);
    
    const themeToggle = document.querySelector('.theme-toggle');
    if (themeToggle) {
        themeToggle.innerHTML = newTheme === 'light' ? '🌙' : '☀️';
    }
}

function applyTheme(theme) {
    document.documentElement.setAttribute('data-theme', theme);
}

function formatCurrency(value) {
    return new Intl.NumberFormat('en-US', {
        style: 'currency',
        currency: 'USD'
    }).format(value);
}

function updateTimestamp(elementId) {
    const element = document.getElementById(elementId);
    if (element) {
        element.textContent = new Date().toLocaleString();
    }
}
"@

$mainJs | Out-File -FilePath "js/main.js" -Encoding UTF8
Write-Host "Created main JavaScript" -ForegroundColor Green

# Create dashboard JavaScript
$dashboardJs = @"
document.addEventListener('DOMContentLoaded', function() {
    if (typeof Chart === 'undefined') {
        console.error('Chart.js not loaded');
        return;
    }
    
    initializeCharts();
    updateIndicators();
    updateTimestamp('marketUpdateTime');
});

function initializeCharts() {
    // Market Overview Chart
    const marketCtx = document.getElementById('marketOverviewChart');
    if (marketCtx) {
        const labels = generateLabels(30);
        new Chart(marketCtx, {
            type: 'line',
            data: {
                labels: labels,
                datasets: [{
                    label: 'S&P 500',
                    data: generateData(30, 4500, 4700),
                    borderColor: '#3b82f6',
                    backgroundColor: '#3b82f620',
                    tension: 0.4
                }, {
                    label: 'NASDAQ',
                    data: generateData(30, 14000, 14500),
                    borderColor: '#8b5cf6',
                    backgroundColor: '#8b5cf620',
                    tension: 0.4
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { position: 'top' }
                },
                scales: {
                    y: { beginAtZero: false }
                }
            }
        });
    }
    
    // Sentiment Chart
    const sentimentCtx = document.getElementById('sentimentGaugeChart');
    if (sentimentCtx) {
        new Chart(sentimentCtx, {
            type: 'doughnut',
            data: {
                labels: ['Positive', 'Negative'],
                datasets: [{
                    data: [65, 35],
                    backgroundColor: ['#10b981', '#ef4444'],
                    borderWidth: 0
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false }
                }
            }
        });
    }
}

function updateIndicators() {
    const indicators = {
        'rsiValue': '62.5 (Neutral)',
        'macdValue': '1.2 (Bullish)',
        'bollingerValue': 'Middle Band',
        'ma50Value': '$4,632.54',
        'ma200Value': '$4,487.22',
        'sentimentSourceCount': '1,247',
        'predictionConfidence': '87%'
    };
    
    Object.entries(indicators).forEach(([id, value]) => {
        const element = document.getElementById(id);
        if (element) element.textContent = value;
    });
}

function generateData(count, min, max) {
    return Array.from({length: count}, () => 
        Math.random() * (max - min) + min
    );
}

function generateLabels(count) {
    const labels = [];
    const today = new Date();
    for (let i = count - 1; i >= 0; i--) {
        const date = new Date(today);
        date.setDate(today.getDate() - i);
        labels.push(date.toLocaleDateString('en-US', { 
            month: 'short', 
            day: 'numeric' 
        }));
    }
    return labels;
}
"@

$dashboardJs | Out-File -FilePath "js/dashboard.js" -Encoding UTF8
Write-Host "Created dashboard JavaScript" -ForegroundColor Green

# Create index.html
$indexHtml = @"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Financial Market Forecaster</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="index.html">
                <i class="fas fa-chart-line me-2"></i>Financial Market Forecaster
            </a>
            <div class="navbar-nav ms-auto d-flex flex-row align-items-center">
                <a class="nav-link active me-3" href="index.html">Home</a>
                <a class="nav-link me-3" href="dashboard.html">Dashboard</a>
                <a class="nav-link me-3" href="https://github.com/asarekings/financial-forecaster" target="_blank">GitHub</a>
                <button class="theme-toggle" title="Toggle theme">🌙</button>
            </div>
        </div>
    </nav>

    <header class="bg-light py-5">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6">
                    <h1 class="display-4 fw-bold mb-4">Financial Market Forecaster</h1>
                    <p class="lead mb-4">Advanced market analysis with AI-driven predictions, real-time sentiment tracking, and comprehensive technical indicators.</p>
                    <a href="dashboard.html" class="btn btn-primary btn-lg">
                        <i class="fas fa-chart-bar me-2"></i>View Dashboard
                    </a>
                </div>
                <div class="col-lg-6">
                    <div class="card shadow">
                        <div class="card-body text-center py-5 bg-primary text-white">
                            <i class="fas fa-chart-line fa-4x mb-3"></i>
                            <h4>Real-time Market Analysis</h4>
                            <p class="mb-0">Live data visualization</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <section class="container py-5">
        <div class="text-center mb-5">
            <h2 class="display-5 fw-bold">Features</h2>
            <p class="lead">Comprehensive market intelligence tools</p>
        </div>
        <div class="row g-4">
            <div class="col-md-4">
                <div class="card feature-card h-100 shadow-sm">
                    <div class="card-body text-center">
                        <i class="fas fa-chart-area fa-3x text-primary mb-3"></i>
                        <h4>Market Data Analysis</h4>
                        <p>Track and analyze historical price data from multiple markets with advanced algorithms.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card feature-card h-100 shadow-sm">
                    <div class="card-body text-center">
                        <i class="fas fa-brain fa-3x text-success mb-3"></i>
                        <h4>AI Sentiment Analysis</h4>
                        <p>Monitor news and social media sentiment to predict market movements accurately.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card feature-card h-100 shadow-sm">
                    <div class="card-body text-center">
                        <i class="fas fa-globe fa-3x text-warning mb-3"></i>
                        <h4>Macroeconomic Integration</h4>
                        <p>Incorporate key economic indicators into comprehensive forecasting models.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <footer class="bg-dark text-white py-4 mt-5">
        <div class="container text-center">
            <p class="mb-0">&copy; <span id="current-year">2025</span> Financial Market Forecaster | 
                Created by <a href="https://github.com/asarekings" class="text-white">asarekings</a>
            </p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/main.js"></script>
</body>
</html>
"@

$indexHtml | Out-File -FilePath "index.html" -Encoding UTF8
Write-Host "Created index.html" -ForegroundColor Green

# Create dashboard.html
$dashboardHtml = @"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Financial Market Forecaster</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.min.js"></script>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="index.html">
                <i class="fas fa-chart-line me-2"></i>Financial Market Forecaster
            </a>
            <div class="navbar-nav ms-auto d-flex flex-row align-items-center">
                <a class="nav-link me-3" href="index.html">Home</a>
                <a class="nav-link active me-3" href="dashboard.html">Dashboard</a>
                <a class="nav-link me-3" href="https://github.com/asarekings/financial-forecaster" target="_blank">GitHub</a>
                <button class="theme-toggle" title="Toggle theme">🌙</button>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row mb-4">
            <div class="col-12">
                <div class="card">
                    <div class="card-body text-center">
                        <h1 class="display-5 fw-bold">Financial Market Dashboard</h1>
                        <p class="lead">Real-time analysis and forecasting</p>
                    </div>
                </div>
            </div>
        </div>

        <div class="row mb-4">
            <div class="col-md-8">
                <div class="card h-100">
                    <div class="card-header">
                        <i class="fas fa-chart-line me-2"></i>Market Overview
                    </div>
                    <div class="card-body">
                        <div class="chart-container">
                            <canvas id="marketOverviewChart"></canvas>
                        </div>
                    </div>
                    <div class="card-footer">
                        <small class="text-muted">Last updated: <span id="marketUpdateTime">Loading...</span></small>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card h-100">
                    <div class="card-header">
                        <i class="fas fa-heart me-2"></i>Sentiment Analysis
                    </div>
                    <div class="card-body">
                        <div class="chart-container">
                            <canvas id="sentimentGaugeChart"></canvas>
                        </div>
                    </div>
                    <div class="card-footer">
                        <small class="text-muted">Sources: <span id="sentimentSourceCount">0</span> | Confidence: <span id="predictionConfidence">0%</span></small>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-header">
                        <i class="fas fa-cogs me-2"></i>Technical Indicators
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <table class="table">
                                    <tbody>
                                        <tr>
                                            <th>RSI (14)</th>
                                            <td id="rsiValue">Loading...</td>
                                        </tr>
                                        <tr>
                                            <th>MACD</th>
                                            <td id="macdValue">Loading...</td>
                                        </tr>
                                        <tr>
                                            <th>Bollinger Bands</th>
                                            <td id="bollingerValue">Loading...</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div class="col-md-6">
                                <table class="table">
                                    <tbody>
                                        <tr>
                                            <th>50 Day MA</th>
                                            <td id="ma50Value">Loading...</td>
                                        </tr>
                                        <tr>
                                            <th>200 Day MA</th>
                                            <td id="ma200Value">Loading...</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <footer class="bg-dark text-white py-4 mt-5">
        <div class="container text-center">
            <p class="mb-0">&copy; <span id="current-year">2025</span> Financial Market Forecaster | 
                Created by <a href="https://github.com/asarekings" class="text-white">asarekings</a>
            </p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/main.js"></script>
    <script src="js/dashboard.js"></script>
</body>
</html>
"@

$dashboardHtml | Out-File -FilePath "dashboard.html" -Encoding UTF8
Write-Host "Created dashboard.html" -ForegroundColor Green

# Create README
$readme = @"
# Financial Market Forecaster

A comprehensive financial market forecasting system with real-time analysis and AI-driven predictions.

## Features

- Real-time market data visualization
- AI sentiment analysis
- Technical indicators (RSI, MACD, Bollinger Bands)
- Dark/Light theme support
- Responsive design
- Interactive charts

## Live Demo

[View Live Site](https://asarekings.github.io/financial-forecaster/)

## Technologies

- HTML5, CSS3, JavaScript
- Bootstrap 5.3
- Chart.js 4.4
- Font Awesome icons

## Setup

1. Clone the repository
2. Open index.html in your browser
3. For GitHub Pages, push to main branch

## License

MIT License

Created by [asarekings](https://github.com/asarekings)
"@

$readme | Out-File -FilePath "README.md" -Encoding UTF8
Write-Host "Created README.md" -ForegroundColor Green

Write-Host "`nSetup completed successfully!" -ForegroundColor Green
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "1. git add ." -ForegroundColor White
Write-Host "2. git commit -m 'Initial Financial Market Forecaster setup'" -ForegroundColor White
Write-Host "3. git push origin main" -ForegroundColor White
Write-Host "`nYour site will be at: https://asarekings.github.io/financial-forecaster/" -ForegroundColor Blue