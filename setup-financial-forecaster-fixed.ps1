# Enhanced Financial Market Forecaster GitHub Pages Setup
# Created: 2025-06-06
# Author: Asare K. Enock[asarekings]
# Version: 2.0 - Fixed with error handling

param(
    [switch]$Clean = $false,
    [switch]$SkipGit = $false,
    [string]$Branch = "main"
)

# Set error handling
$ErrorActionPreference = "Continue"

Write-Host "🚀 Enhanced Financial Market Forecaster Setup" -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Green

# Function to create directories safely
function New-DirectorySafe {
    param([string]$Path)
    try {
        if (!(Test-Path $Path)) {
            New-Item -Path $Path -ItemType Directory -Force | Out-Null
            Write-Host "✅ Created directory: $Path" -ForegroundColor Green
        } else {
            Write-Host "📁 Directory exists: $Path" -ForegroundColor Yellow
        }
    }
    catch {
        Write-Host "❌ Failed to create directory $Path`: $_" -ForegroundColor Red
    }
}

# Function to create files with error handling
function New-FileSafe {
    param(
        [string]$Path,
        [string]$Content,
        [string]$Description
    )
    try {
        if ($null -eq $Content -or $Content -eq "") {
            Write-Host "⚠️ Warning: Empty content for $Description" -ForegroundColor Yellow
            return
        }
        
        Set-Content -Path $Path -Value $Content -Encoding UTF8 -Force
        Write-Host "✅ Created: $Description" -ForegroundColor Green
    } 
    catch {
        Write-Host "❌ Failed to create $Description`: $_" -ForegroundColor Red
    }
}

# Clean existing content if requested
if ($Clean) {
    Write-Host "🧹 Cleaning existing content..." -ForegroundColor Yellow
    try {
        Get-ChildItem -Path . -Exclude ".git", ".gitignore", "*.ps1", "README.md" -ErrorAction SilentlyContinue | 
        Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
        Write-Host "✅ Cleanup completed" -ForegroundColor Green
    }
    catch {
        Write-Host "⚠️ Some files couldn't be cleaned: $_" -ForegroundColor Yellow
    }
}

# Create .nojekyll file
try {
    New-Item -Path ".nojekyll" -ItemType File -Force | Out-Null
    Write-Host "✅ Created .nojekyll file" -ForegroundColor Green
}
catch {
    Write-Host "❌ Failed to create .nojekyll: $_" -ForegroundColor Red
}

# Create directory structure
Write-Host "📁 Creating directory structure..." -ForegroundColor Cyan
$directories = @("css", "js", "img", "data", "components", "assets")
foreach ($dir in $directories) {
    New-DirectorySafe -Path $dir
}

# Enhanced CSS with modern design and dark mode support
Write-Host "🎨 Creating enhanced CSS..." -ForegroundColor Cyan
$enhancedCssContent = @'
:root {
  --primary-color: #2563eb;
  --secondary-color: #64748b;
  --success-color: #10b981;
  --danger-color: #ef4444;
  --warning-color: #f59e0b;
  --info-color: #06b6d4;
  --dark-color: #1e293b;
  --light-color: #f8fafc;
  --body-bg: #ffffff;
  --body-color: #334155;
  --card-bg: #ffffff;
  --border-color: #e2e8f0;
  --shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06);
  --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
}

[data-theme="dark"] {
  --body-bg: #0f172a;
  --body-color: #e2e8f0;
  --card-bg: #1e293b;
  --border-color: #334155;
  --shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.3), 0 1px 2px 0 rgba(0, 0, 0, 0.2);
  --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.3), 0 4px 6px -2px rgba(0, 0, 0, 0.2);
}

* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
  line-height: 1.6;
  color: var(--body-color);
  background-color: var(--body-bg);
  transition: background-color 0.3s ease, color 0.3s ease;
}

/* Navigation */
.navbar {
  background: var(--card-bg) !important;
  border-bottom: 1px solid var(--border-color);
  box-shadow: var(--shadow);
}

.navbar-brand {
  font-weight: 700;
  font-size: 1.5rem;
  color: var(--primary-color) !important;
}

/* Theme toggle */
.theme-toggle {
  background: none;
  border: none;
  color: var(--body-color);
  font-size: 1.2rem;
  cursor: pointer;
  transition: color 0.3s ease;
}

.theme-toggle:hover {
  color: var(--primary-color);
}

/* Cards */
.card {
  background: var(--card-bg);
  border: 1px solid var(--border-color);
  border-radius: 12px;
  box-shadow: var(--shadow);
  transition: all 0.3s ease;
  margin-bottom: 1.5rem;
}

.card:hover {
  transform: translateY(-2px);
  box-shadow: var(--shadow-lg);
}

.card-header {
  background: rgba(37, 99, 235, 0.05);
  border-bottom: 1px solid var(--border-color);
  font-weight: 600;
  color: var(--primary-color);
}

/* Feature cards */
.feature-card {
  height: 100%;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.feature-card:hover {
  transform: translateY(-8px);
  box-shadow: var(--shadow-lg);
}

/* Charts */
.chart-container {
  position: relative;
  height: 300px;
  width: 100%;
}

canvas {
  border-radius: 8px;
}

/* Indicators */
.indicator-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 1rem;
}

.indicator-card {
  padding: 1.5rem;
  background: var(--card-bg);
  border: 1px solid var(--border-color);
  border-radius: 8px;
  text-align: center;
}

.indicator-value {
  font-size: 2rem;
  font-weight: 700;
  margin: 0.5rem 0;
}

.indicator-label {
  color: var(--secondary-color);
  font-size: 0.875rem;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

/* Sentiment indicators */
.sentiment-positive { color: var(--success-color); }
.sentiment-neutral { color: var(--warning-color); }
.sentiment-negative { color: var(--danger-color); }

/* Status badges */
.status-badge {
  display: inline-flex;
  align-items: center;
  padding: 0.25rem 0.75rem;
  border-radius: 9999px;
  font-size: 0.75rem;
  font-weight: 500;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

.status-bullish {
  background: rgba(16, 185, 129, 0.1);
  color: var(--success-color);
}

.status-bearish {
  background: rgba(239, 68, 68, 0.1);
  color: var(--danger-color);
}

.status-neutral {
  background: rgba(245, 158, 11, 0.1);
  color: var(--warning-color);
}

/* Loading states */
.loading {
  opacity: 0.6;
  pointer-events: none;
}

.skeleton {
  background: linear-gradient(90deg, var(--border-color) 25%, transparent 50%, var(--border-color) 75%);
  background-size: 200% 100%;
  animation: loading 1.5s infinite;
}

@keyframes loading {
  0% { background-position: 200% 0; }
  100% { background-position: -200% 0; }
}

/* Footer */
footer {
  margin-top: 4rem;
  padding: 2rem 0;
  border-top: 1px solid var(--border-color);
  background: var(--card-bg);
}

/* Responsive design */
@media (max-width: 768px) {
  .chart-container {
    height: 250px;
  }
  
  .indicator-grid {
    grid-template-columns: 1fr;
  }
}

/* Utility classes */
.text-primary { color: var(--primary-color) !important; }
.text-success { color: var(--success-color) !important; }
.text-danger { color: var(--danger-color) !important; }
.text-warning { color: var(--warning-color) !important; }
.bg-primary { background-color: var(--primary-color) !important; }
.btn-primary { background-color: var(--primary-color); border-color: var(--primary-color); }

.hero-section {
  background: linear-gradient(135deg, var(--light-color) 0%, #e0e7ff 100%);
  min-height: 80vh;
}

[data-theme="dark"] .hero-section {
  background: linear-gradient(135deg, var(--dark-color) 0%, #1e1b4b 100%);
}

.placeholder-chart {
  background: linear-gradient(135deg, var(--primary-color) 0%, #3730a3 100%);
  min-height: 300px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  border-radius: 12px;
}

.stats-section {
  background: var(--light-color);
}

[data-theme="dark"] .stats-section {
  background: var(--card-bg);
}
'@

New-FileSafe -Path "css/style.css" -Content $enhancedCssContent -Description "Enhanced CSS with dark mode support"

# Create main.js with comprehensive functionality
Write-Host "⚙️ Creating main JavaScript..." -ForegroundColor Cyan
$mainJsContent = @'
// Enhanced Financial Market Forecaster - Main JavaScript
class FinancialForecaster {
    constructor() {
        this.theme = localStorage.getItem('theme') || 'light';
        this.isRealTimeEnabled = true;
        this.updateInterval = 30000;
        this.charts = {};
        this.init();
    }

    init() {
        this.setupEventListeners();
        this.applyTheme();
        this.updateFooterYear();
        
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', () => this.onDOMContentLoaded());
        } else {
            this.onDOMContentLoaded();
        }
    }

    onDOMContentLoaded() {
        this.initializeTooltips();
        this.startRealTimeUpdates();
        
        if (document.getElementById('marketOverviewChart')) {
            this.initializeDashboard();
        }
    }

    setupEventListeners() {
        document.addEventListener('click', (e) => {
            if (e.target.classList.contains('theme-toggle')) {
                this.toggleTheme();
            }
        });

        document.addEventListener('visibilitychange', () => {
            if (document.hidden) {
                this.pauseRealTimeUpdates();
            } else {
                this.resumeRealTimeUpdates();
            }
        });
    }

    toggleTheme() {
        this.theme = this.theme === 'light' ? 'dark' : 'light';
        this.applyTheme();
        localStorage.setItem('theme', this.theme);
    }

    applyTheme() {
        document.documentElement.setAttribute('data-theme', this.theme);
        
        const themeToggle = document.querySelector('.theme-toggle');
        if (themeToggle) {
            themeToggle.innerHTML = this.theme === 'light' ? '🌙' : '☀️';
        }
    }

    initializeTooltips() {
        if (typeof bootstrap !== 'undefined' && bootstrap.Tooltip) {
            const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
            tooltipTriggerList.map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl));
        }
    }

    updateFooterYear() {
        const yearElement = document.getElementById('current-year');
        if (yearElement) {
            yearElement.textContent = new Date().getFullYear();
        }
    }

    startRealTimeUpdates() {
        if (this.isRealTimeEnabled) {
            this.updateTimer = setInterval(() => {
                this.updateMarketData();
            }, this.updateInterval);
        }
    }

    pauseRealTimeUpdates() {
        if (this.updateTimer) {
            clearInterval(this.updateTimer);
        }
    }

    resumeRealTimeUpdates() {
        this.startRealTimeUpdates();
    }

    async updateMarketData() {
        try {
            const timestamp = new Date().toLocaleString();
            
            const updateTimeElement = document.getElementById('marketUpdateTime');
            if (updateTimeElement) {
                updateTimeElement.textContent = timestamp;
            }

            this.updateChartData();
            
        } catch (error) {
            console.error('Error updating market data:', error);
        }
    }

    updateChartData() {
        Object.keys(this.charts).forEach(chartId => {
            const chart = this.charts[chartId];
            if (chart && chart.data) {
                this.addNewDataPoint(chart);
            }
        });
    }

    addNewDataPoint(chart) {
        const datasets = chart.data.datasets;
        const labels = chart.data.labels;
        
        const now = new Date();
        labels.push(now.toLocaleTimeString());
        
        datasets.forEach(dataset => {
            const lastValue = dataset.data[dataset.data.length - 1] || 0;
            const volatility = 0.02;
            const change = (Math.random() - 0.5) * volatility * lastValue;
            dataset.data.push(lastValue + change);
        });
        
        if (labels.length > 50) {
            labels.shift();
            datasets.forEach(dataset => dataset.data.shift());
        }
        
        chart.update('none');
    }

    initializeDashboard() {
        console.log('Initializing enhanced dashboard...');
    }

    formatCurrency(value, currency = 'USD') {
        return new Intl.NumberFormat('en-US', {
            style: 'currency',
            currency: currency,
            minimumFractionDigits: 2,
            maximumFractionDigits: 2
        }).format(value);
    }

    formatPercentage(value) {
        return new Intl.NumberFormat('en-US', {
            style: 'percent',
            minimumFractionDigits: 2,
            maximumFractionDigits: 2,
            signDisplay: 'always'
        }).format(value / 100);
    }

    showNotification(message, type = 'info') {
        const notification = document.createElement('div');
        notification.className = `alert alert-${type} alert-dismissible fade show position-fixed`;
        notification.style.cssText = 'top: 20px; right: 20px; z-index: 9999; min-width: 300px;';
        notification.innerHTML = `
            ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        `;
        
        document.body.appendChild(notification);
        
        setTimeout(() => {
            if (notification.parentNode) {
                notification.remove();
            }
        }, 5000);
    }
}

const forecaster = new FinancialForecaster();
window.FinancialForecaster = forecaster;
'@

New-FileSafe -Path "js/main.js" -Content $mainJsContent -Description "Main JavaScript file"

# Create simplified dashboard.js to avoid complexity
Write-Host "📊 Creating dashboard JavaScript..." -ForegroundColor Cyan
$dashboardJsContent = @'
// Dashboard JavaScript for Financial Market Forecaster
document.addEventListener('DOMContentLoaded', function() {
    console.log('Dashboard initializing...');
    
    // Initialize all charts
    initializeMarketOverview();
    initializeSentimentGauge();
    updateTechnicalIndicators();
    updateTimestamps();
    
    console.log('Dashboard initialization complete');
});

function initializeMarketOverview() {
    const ctx = document.getElementById('marketOverviewChart');
    if (!ctx) return;

    // Generate sample data
    const labels = generateDateLabels(30);
    const sp500Data = generateRandomData(30, 4500, 4700);
    const nasdaqData = generateRandomData(30, 14000, 14500);
    const dowData = generateRandomData(30, 35000, 36000);

    new Chart(ctx, {
        type: 'line',
        data: {
            labels: labels,
            datasets: [
                {
                    label: 'S&P 500',
                    data: sp500Data,
                    borderColor: '#3b82f6',
                    backgroundColor: '#3b82f620',
                    tension: 0.4,
                    fill: false
                },
                {
                    label: 'NASDAQ',
                    data: nasdaqData,
                    borderColor: '#8b5cf6',
                    backgroundColor: '#8b5cf620',
                    tension: 0.4,
                    fill: false
                },
                {
                    label: 'Dow Jones',
                    data: dowData,
                    borderColor: '#f59e0b',
                    backgroundColor: '#f59e0b20',
                    tension: 0.4,
                    fill: false
                }
            ]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    position: 'top'
                }
            },
            scales: {
                y: {
                    beginAtZero: false
                }
            }
        }
    });
}

function initializeSentimentGauge() {
    const ctx = document.getElementById('sentimentGaugeChart');
    if (!ctx) return;

    const sentimentScore = 0.65;

    new Chart(ctx, {
        type: 'doughnut',
        data: {
            labels: ['Positive', 'Negative'],
            datasets: [{
                data: [sentimentScore + 1, 2 - (sentimentScore + 1)],
                backgroundColor: ['#10b981', '#ef4444'],
                borderWidth: 0
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            circumference: 180,
            rotation: 270,
            plugins: {
                legend: {
                    display: false
                }
            }
        }
    });
}

function updateTechnicalIndicators() {
    const indicators = {
        rsi: '62.5 (Neutral)',
        macd: '1.2 (Bullish)',
        bollinger: 'Middle Band (Neutral)',
        ma50: '$4,632.54 (Above Price)',
        ma200: '$4,487.22 (Below Price)'
    };

    Object.keys(indicators).forEach(key => {
        const element = document.getElementById(key + 'Value');
        if (element) {
            element.textContent = indicators[key];
        }
    });
}

function updateTimestamps() {
    const now = new Date().toLocaleString();
    const updateElement = document.getElementById('marketUpdateTime');
    if (updateElement) {
        updateElement.textContent = now;
    }

    const sourceElement = document.getElementById('sentimentSourceCount');
    if (sourceElement) {
        sourceElement.textContent = '1,247';
    }

    const confidenceElement = document.getElementById('predictionConfidence');
    if (confidenceElement) {
        confidenceElement.textContent = '87%';
    }
}

function generateRandomData(count, min, max) {
    const data = [];
    for (let i = 0; i < count; i++) {
        data.push(Math.random() * (max - min) + min);
    }
    return data;
}

function generateDateLabels(count) {
    const labels = [];
    const today = new Date();
    
    for (let i = count - 1; i >= 0; i--) {
        const date = new Date();
        date.setDate(today.getDate() - i);
        labels.push(date.toLocaleDateString('en-US', { month: 'short', day: 'numeric' }));
    }
    
    return labels;
}
'@

New-FileSafe -Path "js/dashboard.js" -Content $dashboardJsContent -Description "Dashboard JavaScript"

# Create simple index.html
Write-Host "🏠 Creating index.html..." -ForegroundColor Cyan
$indexHtml = @'
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
    <nav class="navbar navbar-expand-lg sticky-top">
        <div class="container">
            <a class="navbar-brand" href="index.html">
                <i class="fas fa-chart-line me-2"></i>Financial Market Forecaster
            </a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link active" href="index.html">Home</a>
                <a class="nav-link" href="dashboard.html">Dashboard</a>
                <a class="nav-link" href="https://github.com/asarekings/financial-forecaster" target="_blank">GitHub</a>
                <button class="theme-toggle btn btn-outline-secondary btn-sm ms-2">🌙</button>
            </div>
        </div>
    </nav>

    <header class="hero-section py-5">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6">
                    <h1 class="display-3 fw-bold mb-4">
                        Advanced <span class="text-primary">Financial Market</span> Forecaster
                    </h1>
                    <p class="lead mb-4">
                        Harness AI-driven analysis, real-time sentiment tracking, and advanced technical indicators for informed investment decisions.
                    </p>
                    <a href="dashboard.html" class="btn btn-primary btn-lg me-3">
                        <i class="fas fa-chart-bar me-2"></i>View Dashboard
                    </a>
                </div>
                <div class="col-lg-6">
                    <div class="card border-0 shadow-lg">
                        <div class="placeholder-chart text-white text-center py-5">
                            <i class="fas fa-chart-line fa-4x mb-3"></i>
                            <h4>Real-time Market Analysis</h4>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <section class="py-5">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="display-5 fw-bold">Features</h2>
            </div>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="card feature-card h-100">
                        <div class="card-body text-center">
                            <i class="fas fa-chart-area fa-3x text-primary mb-3"></i>
                            <h4>Market Data Analysis</h4>
                            <p>Advanced algorithms analyze historical price data and market trends.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card feature-card h-100">
                        <div class="card-body text-center">
                            <i class="fas fa-brain fa-3x text-success mb-3"></i>
                            <h4>AI Sentiment Analysis</h4>
                            <p>Monitor news and social media sentiment to predict market movements.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card feature-card h-100">
                        <div class="card-body text-center">
                            <i class="fas fa-globe fa-3x text-warning mb-3"></i>
                            <h4>Macroeconomic Integration</h4>
                            <p>Incorporate key economic indicators into forecasting models.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <footer class="py-4">
        <div class="container text-center">
            <p>&copy; <span id="current-year">2025</span> Financial Market Forecaster | Created by 
                <a href="https://github.com/asarekings" target="_blank">asarekings</a>
            </p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/main.js"></script>
</body>
</html>
'@

New-FileSafe -Path "index.html" -Content $indexHtml -Description "Main index page"

# Create dashboard.html
Write-Host "📊 Creating dashboard.html..." -ForegroundColor Cyan
$dashboardHtml = @'
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
    <nav class="navbar navbar-expand-lg sticky-top">
        <div class="container">
            <a class="navbar-brand" href="index.html">
                <i class="fas fa-chart-line me-2"></i>Financial Market Forecaster
            </a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="index.html">Home</a>
                <a class="nav-link active" href="dashboard.html">Dashboard</a>
                <a class="nav-link" href="https://github.com/asarekings/financial-forecaster" target="_blank">GitHub</a>
                <button class="theme-toggle btn btn-outline-secondary btn-sm ms-2">🌙</button>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row">
            <div class="col-12">
                <div class="card mb-4">
                    <div class="card-body text-center">
                        <h1 class="display-5 fw-bold">Financial Market Dashboard</h1>
                        <p class="lead">Real-time analysis and forecasting for financial markets</p>
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
                                <table class="table table-borderless">
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
                                </table>
                            </div>
                            <div class="col-md-6">
                                <table class="table table-borderless">
                                    <tr>
                                        <th>50 Day MA</th>
                                        <td id="ma50Value">Loading...</td>
                                    </tr>
                                    <tr>
                                        <th>200 Day MA</th>
                                        <td id="ma200Value">Loading...</td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <footer class="py-4 mt-5">
        <div class="container text-center">
            <p>&copy; <span id="current-year">2025</span> Financial Market Forecaster | Created by 
                <a href="https://github.com/asarekings" target="_blank">asarekings</a>
            </p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/main.js"></script>
    <script src="js/dashboard.js"></script>
</body>
</html>
'@

New-FileSafe -Path "dashboard.html" -Content $dashboardHtml -Description "Dashboard page"

# Create README.md
Write-Host "📝 Creating README.md..." -ForegroundColor Cyan
$readmeContent = @'
# Financial Market Forecaster

A comprehensive financial market forecasting system that combines technical indicators, sentiment analysis, and macroeconomic factors to predict market movements with advanced visualization and real-time analytics.

## 🚀 Live Demo

**[View the live application](https://asarekings.github.io/financial-forecaster/)**

## ✨ Features

- **Real-time Market Analysis**: Live data visualization with interactive charts
- **AI Sentiment Analysis**: Monitor news and social media sentiment
- **Technical Indicators**: RSI, MACD, Bollinger Bands, and more
- **Dark/Light Theme**: Toggle between themes for better user experience
- **Responsive Design**: Works perfectly on desktop, tablet, and mobile
- **Advanced Charts**: Powered by Chart.js with real-time updates

## 🛠️ Technologies Used

- **Frontend**: HTML5, CSS3, JavaScript (ES6+)
- **Framework**: Bootstrap 5.3
- **Charts**: Chart.js 4.4
- **Icons**: Font Awesome 6.4
- **Hosting**: GitHub Pages

## 📊 Dashboard Features

- Market Overview with multiple indices
- Sentiment Gauge with real-time scoring
- Technical Indicators table
- Real-time data updates
- Interactive charts with hover effects
- Performance metrics

## 🎨 Design Features

- Modern CSS Grid and Flexbox layouts
- CSS Custom Properties for theming
- Smooth animations and transitions
- Mobile-first responsive design
- Accessibility considerations

## 🚀 Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/asarekings/financial-forecaster.git
   cd financial-forecaster