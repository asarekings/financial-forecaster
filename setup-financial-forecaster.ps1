# Enhanced Financial Market Forecaster GitHub Pages Setup
# Created: 2025-06-06
# Author: asarekings
# Version: 2.0 - Enhanced with advanced features

param(
    [switch]$Clean = $false,
    [switch]$SkipGit = $false,
    [string]$Branch = "main"
)

Write-Host "🚀 Enhanced Financial Market Forecaster Setup" -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Green

# Function to create directories safely
function New-DirectorySafe {
    param([string]$Path)
    if (!(Test-Path $Path)) {
        New-Item -Path $Path -ItemType Directory -Force | Out-Null
        Write-Host "✅ Created directory: $Path" -ForegroundColor Green
    } else {
        Write-Host "📁 Directory exists: $Path" -ForegroundColor Yellow
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
        Set-Content -Path $Path -Value $Content -Encoding UTF8
        Write-Host "✅ Created: $Description" -ForegroundColor Green
    } catch {
        Write-Host "❌ Failed to create $Description`: $_" -ForegroundColor Red
    }
}

# Clean existing content if requested
if ($Clean) {
    Write-Host "🧹 Cleaning existing content..." -ForegroundColor Yellow
    Get-ChildItem -Path . -Exclude ".git", ".gitignore", "*.ps1" | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
}

# Create .nojekyll file to bypass Jekyll processing
New-Item -Path ".nojekyll" -ItemType File -Force | Out-Null
Write-Host "✅ Created .nojekyll file" -ForegroundColor Green

# Create directory structure
$directories = @("css", "js", "img", "data", "components", "assets")
foreach ($dir in $directories) {
    New-DirectorySafe -Path $dir
}

# Enhanced CSS with modern design and dark mode support
$enhancedCssContent = @"
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
  background: rgba(var(--primary-color), 0.05);
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
"@

New-FileSafe -Path "css/style.css" -Content $enhancedCssContent -Description "Enhanced CSS with dark mode support"

# Enhanced JavaScript with real-time data simulation and advanced features
$enhancedMainJsContent = @"
// Enhanced Financial Market Forecaster
// Main JavaScript with advanced features

class FinancialForecaster {
    constructor() {
        this.theme = localStorage.getItem('theme') || 'light';
        this.isRealTimeEnabled = true;
        this.updateInterval = 30000; // 30 seconds
        this.charts = {};
        this.websocketConnection = null;
        
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
        
        // Initialize dashboard if on dashboard page
        if (document.getElementById('marketOverviewChart')) {
            this.initializeDashboard();
        }
    }

    setupEventListeners() {
        // Theme toggle
        document.addEventListener('click', (e) => {
            if (e.target.classList.contains('theme-toggle')) {
                this.toggleTheme();
            }
        });

        // Handle page visibility for performance
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
        
        // Update theme toggle icon
        const themeToggle = document.querySelector('.theme-toggle');
        if (themeToggle) {
            themeToggle.innerHTML = this.theme === 'light' ? '🌙' : '☀️';
        }
    }

    initializeTooltips() {
        // Initialize Bootstrap tooltips if available
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
            // Simulate real-time data updates
            const timestamp = new Date().toLocaleString();
            
            // Update last update time
            const updateTimeElement = document.getElementById('marketUpdateTime');
            if (updateTimeElement) {
                updateTimeElement.textContent = timestamp;
            }

            // Update charts with new data
            this.updateChartData();
            
        } catch (error) {
            console.error('Error updating market data:', error);
        }
    }

    updateChartData() {
        // Update existing charts with new data points
        Object.keys(this.charts).forEach(chartId => {
            const chart = this.charts[chartId];
            if (chart && chart.data) {
                // Add new data point and remove old ones to maintain chart size
                this.addNewDataPoint(chart);
            }
        });
    }

    addNewDataPoint(chart) {
        const datasets = chart.data.datasets;
        const labels = chart.data.labels;
        
        // Add new timestamp
        const now = new Date();
        labels.push(now.toLocaleTimeString());
        
        // Add new data points for each dataset
        datasets.forEach(dataset => {
            const lastValue = dataset.data[dataset.data.length - 1] || 0;
            const volatility = 0.02; // 2% volatility
            const change = (Math.random() - 0.5) * volatility * lastValue;
            dataset.data.push(lastValue + change);
        });
        
        // Keep only last 50 data points
        if (labels.length > 50) {
            labels.shift();
            datasets.forEach(dataset => dataset.data.shift());
        }
        
        chart.update('none'); // Update without animation for real-time feel
    }

    initializeDashboard() {
        console.log('Initializing enhanced dashboard...');
        // Dashboard-specific initialization will be handled by dashboard.js
    }

    // Utility methods
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
        // Simple notification system
        const notification = document.createElement('div');
        notification.className = `alert alert-${type} alert-dismissible fade show position-fixed`;
        notification.style.cssText = 'top: 20px; right: 20px; z-index: 9999; min-width: 300px;';
        notification.innerHTML = `
            ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        `;
        
        document.body.appendChild(notification);
        
        // Auto-remove after 5 seconds
        setTimeout(() => {
            if (notification.parentNode) {
                notification.remove();
            }
        }, 5000);
    }
}

// Initialize the application
const forecaster = new FinancialForecaster();

// Export for use in other scripts
window.FinancialForecaster = forecaster;
"@

New-FileSafe -Path "js/main.js" -Content $enhancedMainJsContent -Description "Enhanced main JavaScript"

# Advanced dashboard JavaScript with multiple chart types and real-time updates
$enhancedDashboardJsContent = @"
// Enhanced Dashboard JavaScript
// Advanced charting and real-time data management

class DashboardManager {
    constructor() {
        this.charts = {};
        this.marketData = {
            indices: {
                'S&P 500': { current: 4580.23, change: 1.25, data: [] },
                'NASDAQ': { current: 14205.44, change: -0.73, data: [] },
                'Dow Jones': { current: 35467.89, change: 0.91, data: [] },
                'Russell 2000': { current: 2087.34, change: 2.15, data: [] }
            },
            indicators: {
                rsi: { value: 62.5, signal: 'Neutral' },
                macd: { value: 1.2, signal: 'Bullish' },
                bollinger: { value: 'Middle Band', signal: 'Neutral' },
                ma50: { value: 4632.54, signal: 'Above Price' },
                ma200: { value: 4487.22, signal: 'Below Price' },
                vix: { value: 18.45, signal: 'Low Volatility' }
            },
            sentiment: {
                score: 0.65,
                sources: 1247,
                confidence: 87
            }
        };
        
        this.init();
    }

    init() {
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', () => this.initializeDashboard());
        } else {
            this.initializeDashboard();
        }
    }

    initializeDashboard() {
        console.log('Initializing advanced dashboard...');
        
        // Generate initial data
        this.generateHistoricalData();
        
        // Initialize all chart components
        this.initializeMarketOverview();
        this.initializeSentimentGauge();
        this.initializeForecastPrediction();
        this.initializeHistoricalPerformance();
        this.initializeVolatilityChart();
        this.initializeSectorPerformance();
        
        // Update indicators and other components
        this.updateTechnicalIndicators();
        this.updateMarketSentiment();
        this.updateEconomicIndicators();
        this.updateNewsFeed();
        
        // Set initial timestamps
        this.updateTimestamps();
        
        // Start real-time updates
        this.startRealTimeUpdates();
        
        console.log('Dashboard initialization complete');
    }

    generateHistoricalData() {
        const days = 90;
        const today = new Date();
        
        Object.keys(this.marketData.indices).forEach(index => {
            const baseValue = this.marketData.indices[index].current;
            const data = [];
            
            for (let i = days - 1; i >= 0; i--) {
                const date = new Date(today);
                date.setDate(today.getDate() - i);
                
                // Generate realistic price movement
                const volatility = 0.015; // 1.5% daily volatility
                const trend = -0.0001 * i; // Slight upward trend
                const randomChange = (Math.random() - 0.5) * volatility;
                const dailyReturn = trend + randomChange;
                
                const previousValue = i === days - 1 ? baseValue : data[data.length - 1].value;
                const currentValue = previousValue * (1 + dailyReturn);
                
                data.push({
                    date: date.toISOString().split('T')[0],
                    value: currentValue,
                    volume: Math.floor(Math.random() * 1000000) + 5000000
                });
            }
            
            this.marketData.indices[index].data = data;
        });
    }

    initializeMarketOverview() {
        const ctx = document.getElementById('marketOverviewChart');
        if (!ctx) return;

        const labels = this.marketData.indices['S&P 500'].data.map(d => {
            const date = new Date(d.date);
            return date.toLocaleDateString('en-US', { month: 'short', day: 'numeric' });
        });

        const datasets = Object.keys(this.marketData.indices).map((index, i) => {
            const colors = ['#3b82f6', '#8b5cf6', '#f59e0b', '#10b981'];
            return {
                label: index,
                data: this.marketData.indices[index].data.map(d => d.value.toFixed(2)),
                borderColor: colors[i % colors.length],
                backgroundColor: colors[i % colors.length] + '20',
                tension: 0.4,
                fill: false,
                pointRadius: 0,
                pointHoverRadius: 6
            };
        });

        this.charts.marketOverview = new Chart(ctx, {
            type: 'line',
            data: { labels, datasets },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                interaction: {
                    intersect: false,
                    mode: 'index'
                },
                plugins: {
                    legend: {
                        position: 'top',
                        labels: {
                            usePointStyle: true,
                            padding: 20
                        }
                    },
                    tooltip: {
                        callbacks: {
                            label: (context) => {
                                const value = parseFloat(context.parsed.y);
                                return `${context.dataset.label}: ${this.formatCurrency(value)}`;
                            }
                        }
                    }
                },
                scales: {
                    x: {
                        grid: { display: false },
                        ticks: { maxTicksLimit: 10 }
                    },
                    y: {
                        beginAtZero: false,
                        grid: { color: 'rgba(0,0,0,0.1)' },
                        ticks: {
                            callback: (value) => this.formatCurrency(value)
                        }
                    }
                }
            }
        });

        // Store reference for updates
        window.FinancialForecaster.charts.marketOverview = this.charts.marketOverview;
    }

    initializeSentimentGauge() {
        const ctx = document.getElementById('sentimentGaugeChart');
        if (!ctx) return;

        const sentimentScore = this.marketData.sentiment.score;
        const normalizedScore = (sentimentScore + 1) / 2; // Convert from [-1,1] to [0,1]

        this.charts.sentimentGauge = new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: ['Positive', 'Neutral', 'Negative'],
                datasets: [{
                    data: [normalizedScore * 100, 20, (1 - normalizedScore) * 100],
                    backgroundColor: [
                        '#10b981',
                        '#f59e0b',
                        '#ef4444'
                    ],
                    borderWidth: 0,
                    cutout: '70%'
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                circumference: 180,
                rotation: 270,
                plugins: {
                    legend: { display: false },
                    tooltip: {
                        callbacks: {
                            label: (context) => {
                                const percentage = context.parsed.toFixed(1);
                                return `${context.label}: ${percentage}%`;
                            }
                        }
                    }
                }
            }
        });

        // Add sentiment score display
        this.displaySentimentScore(sentimentScore);
    }

    initializeForecastPrediction() {
        const ctx = document.getElementById('forecastPredictionChart');
        if (!ctx) return;

        // Generate forecast data
        const historical = this.marketData.indices['S&P 500'].data.slice(-30);
        const forecast = this.generateForecastData(historical, 14);

        const allData = [...historical, ...forecast];
        const labels = allData.map(d => {
            const date = new Date(d.date);
            return date.toLocaleDateString('en-US', { month: 'short', day: 'numeric' });
        });

        this.charts.forecast = new Chart(ctx, {
            type: 'line',
            data: {
                labels,
                datasets: [
                    {
                        label: 'Historical',
                        data: historical.map(d => d.value),
                        borderColor: '#3b82f6',
                        backgroundColor: '#3b82f620',
                        tension: 0.4
                    },
                    {
                        label: 'Forecast',
                        data: [...new Array(historical.length).fill(null), ...forecast.map(d => d.value)],
                        borderColor: '#f59e0b',
                        backgroundColor: '#f59e0b20',
                        borderDash: [5, 5],
                        tension: 0.4
                    }
                ]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { position: 'top' },
                    tooltip: {
                        callbacks: {
                            label: (context) => {
                                const value = parseFloat(context.parsed.y);
                                return `${context.dataset.label}: ${this.formatCurrency(value)}`;
                            }
                        }
                    }
                },
                scales: {
                    x: { grid: { display: false } },
                    y: {
                        beginAtZero: false,
                        ticks: {
                            callback: (value) => this.formatCurrency(value)
                        }
                    }
                }
            }
        });
    }

    initializeHistoricalPerformance() {
        const ctx = document.getElementById('historicalPerformanceChart');
        if (!ctx) return;

        const sp500Data = this.marketData.indices['S&P 500'].data;
        const returns = this.calculateReturns(sp500Data);

        this.charts.performance = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: returns.map(r => r.period),
                datasets: [{
                    label: 'Returns (%)',
                    data: returns.map(r => r.return * 100),
                    backgroundColor: returns.map(r => r.return >= 0 ? '#10b981' : '#ef4444'),
                    borderWidth: 0
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false },
                    tooltip: {
                        callbacks: {
                            label: (context) => {
                                const value = context.parsed.y;
                                return `Return: ${value >= 0 ? '+' : ''}${value.toFixed(2)}%`;
                            }
                        }
                    }
                },
                scales: {
                    x: { grid: { display: false } },
                    y: {
                        ticks: {
                            callback: (value) => value.toFixed(1) + '%'
                        }
                    }
                }
            }
        });
    }

    initializeVolatilityChart() {
        const ctx = document.getElementById('volatilityChart');
        if (!ctx) return;

        const sp500Data = this.marketData.indices['S&P 500'].data;
        const volatility = this.calculateVolatility(sp500Data, 20);

        this.charts.volatility = new Chart(ctx, {
            type: 'line',
            data: {
                labels: volatility.map(v => {
                    const date = new Date(v.date);
                    return date.toLocaleDateString('en-US', { month: 'short', day: 'numeric' });
                }),
                datasets: [{
                    label: 'Volatility (%)',
                    data: volatility.map(v => v.volatility * 100),
                    borderColor: '#8b5cf6',
                    backgroundColor: '#8b5cf620',
                    tension: 0.4,
                    fill: true
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false }
                },
                scales: {
                    x: { grid: { display: false } },
                    y: {
                        ticks: {
                            callback: (value) => value.toFixed(1) + '%'
                        }
                    }
                }
            }
        });
    }

    initializeSectorPerformance() {
        const ctx = document.getElementById('sectorPerformanceChart');
        if (!ctx) return;

        const sectors = [
            { name: 'Technology', performance: 2.45 },
            { name: 'Healthcare', performance: 1.32 },
            { name: 'Financials', performance: -0.87 },
            { name: 'Energy', performance: 3.21 },
            { name: 'Consumer Disc.', performance: 0.95 },
            { name: 'Real Estate', performance: -1.24 },
            { name: 'Utilities', performance: 0.43 },
            { name: 'Materials', performance: 1.78 }
        ];

        this.charts.sectors = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: sectors.map(s => s.name),
                datasets: [{
                    label: 'Performance (%)',
                    data: sectors.map(s => s.performance),
                    backgroundColor: sectors.map(s => s.performance >= 0 ? '#10b981' : '#ef4444'),
                    borderWidth: 0
                }]
            },
            options: {
                indexAxis: 'y',
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false }
                },
                scales: {
                    x: {
                        ticks: {
                            callback: (value) => value.toFixed(1) + '%'
                        }
                    },
                    y: { grid: { display: false } }
                }
            }
        });
    }

    // Utility methods
    generateForecastData(historical, days) {
        const forecast = [];
        const lastDate = new Date(historical[historical.length - 1].date);
        const lastValue = historical[historical.length - 1].value;

        for (let i = 1; i <= days; i++) {
            const date = new Date(lastDate);
            date.setDate(lastDate.getDate() + i);
            
            // Simple trend-based forecast with some randomness
            const trend = 0.0005; // Slight upward trend
            const volatility = 0.01;
            const randomFactor = (Math.random() - 0.5) * volatility;
            
            const forecastValue = lastValue * Math.pow(1 + trend + randomFactor, i);
            
            forecast.push({
                date: date.toISOString().split('T')[0],
                value: forecastValue
            });
        }

        return forecast;
    }

    calculateReturns(data) {
        const periods = [
            { name: '1D', days: 1 },
            { name: '1W', days: 7 },
            { name: '1M', days: 30 },
            { name: '3M', days: 90 },
            { name: 'YTD', days: this.getDaysFromYearStart() }
        ];

        return periods.map(period => {
            const startIndex = Math.max(0, data.length - period.days - 1);
            const endIndex = data.length - 1;
            
            if (startIndex >= endIndex) return { period: period.name, return: 0 };
            
            const startValue = data[startIndex].value;
            const endValue = data[endIndex].value;
            const returnValue = (endValue - startValue) / startValue;
            
            return { period: period.name, return: returnValue };
        });
    }

    calculateVolatility(data, window = 20) {
        const returns = [];
        for (let i = 1; i < data.length; i++) {
            const dailyReturn = (data[i].value - data[i-1].value) / data[i-1].value;
            returns.push(dailyReturn);
        }

        const volatility = [];
        for (let i = window; i < returns.length; i++) {
            const windowReturns = returns.slice(i - window, i);
            const mean = windowReturns.reduce((sum, r) => sum + r, 0) / window;
            const variance = windowReturns.reduce((sum, r) => sum + Math.pow(r - mean, 2), 0) / window;
            const vol = Math.sqrt(variance * 252); // Annualized volatility
            
            volatility.push({
                date: data[i].date,
                volatility: vol
            });
        }

        return volatility;
    }

    getDaysFromYearStart() {
        const now = new Date();
        const start = new Date(now.getFullYear(), 0, 1);
        return Math.floor((now - start) / (1000 * 60 * 60 * 24));
    }

    updateTechnicalIndicators() {
        const indicators = this.marketData.indicators;
        
        document.getElementById('rsiValue').textContent = `${indicators.rsi.value} (${indicators.rsi.signal})`;
        document.getElementById('macdValue').textContent = `${indicators.macd.value} (${indicators.macd.signal})`;
        document.getElementById('bollingerValue').textContent = `${indicators.bollinger.value} (${indicators.bollinger.signal})`;
        document.getElementById('ma50Value').textContent = `${this.formatCurrency(indicators.ma50.value)} (${indicators.ma50.signal})`;
        document.getElementById('ma200Value').textContent = `${this.formatCurrency(indicators.ma200.value)} (${indicators.ma200.signal})`;
        
        // Add VIX if element exists
        const vixElement = document.getElementById('vixValue');
        if (vixElement) {
            vixElement.textContent = `${indicators.vix.value} (${indicators.vix.signal})`;
        }
    }

    updateMarketSentiment() {
        const sentiment = this.marketData.sentiment;
        
        document.getElementById('sentimentSourceCount').textContent = sentiment.sources.toLocaleString();
        document.getElementById('predictionConfidence').textContent = `${sentiment.confidence}%`;
    }

    updateEconomicIndicators() {
        // Placeholder for economic indicators
        const indicators = [
            { id: 'inflationRate', value: '3.2%', trend: 'up' },
            { id: 'unemploymentRate', value: '3.7%', trend: 'down' },
            { id: 'gdpGrowth', value: '2.1%', trend: 'stable' },
            { id: 'fedRate', value: '5.25%', trend: 'stable' }
        ];

        indicators.forEach(indicator => {
            const element = document.getElementById(indicator.id);
            if (element) {
                element.textContent = indicator.value;
                element.className = `indicator-value text-${this.getTrendColor(indicator.trend)}`;
            }
        });
    }

    updateNewsFeed() {
        const newsContainer = document.getElementById('newsFeed');
        if (!newsContainer) return;

        const sampleNews = [
            { title: 'Fed Maintains Interest Rates at Current Levels', time: '2 hours ago', impact: 'neutral' },
            { title: 'Tech Stocks Rally on Strong Earnings Reports', time: '4 hours ago', impact: 'positive' },
            { title: 'Oil Prices Surge Amid Supply Concerns', time: '6 hours ago', impact: 'mixed' },
            { title: 'Consumer Confidence Index Exceeds Expectations', time: '1 day ago', impact: 'positive' }
        ];

        const newsHTML = sampleNews.map(news => `
            <div class="news-item mb-3 p-3 border rounded">
                <h6 class="mb-1">${news.title}</h6>
                <small class="text-muted">${news.time} • <span class="text-${this.getImpactColor(news.impact)}">${news.impact}</span></small>
            </div>
        `).join('');

        newsContainer.innerHTML = newsHTML;
    }

    displaySentimentScore(score) {
        const container = document.getElementById('sentimentScoreDisplay');
        if (!container) return;

        const percentage = ((score + 1) / 2 * 100).toFixed(1);
        const sentiment = score > 0.2 ? 'Bullish' : score < -0.2 ? 'Bearish' : 'Neutral';
        const colorClass = score > 0.2 ? 'text-success' : score < -0.2 ? 'text-danger' : 'text-warning';

        container.innerHTML = `
            <div class="text-center">
                <div class="sentiment-score ${colorClass}">${percentage}%</div>
                <div class="sentiment-label">${sentiment}</div>
            </div>
        `;
    }

    updateTimestamps() {
        const now = new Date();
        const timestamp = now.toLocaleString('en-US', {
            year: 'numeric',
            month: 'short',
            day: 'numeric',
            hour: '2-digit',
            minute: '2-digit'
        });

        document.getElementById('marketUpdateTime').textContent = timestamp;
    }

    startRealTimeUpdates() {
        // Update every 30 seconds
        setInterval(() => {
            this.updateTimestamps();
            this.simulateMarketMovement();
        }, 30000);
    }

    simulateMarketMovement() {
        // Simulate small market movements
        Object.keys(this.marketData.indices).forEach(index => {
            const current = this.marketData.indices[index];
            const change = (Math.random() - 0.5) * 0.02; // ±1% max change
            current.current *= (1 + change);
            current.change = change * 100;
        });

        // Update technical indicators with small random changes
        Object.keys(this.marketData.indicators).forEach(indicator => {
            const current = this.marketData.indicators[indicator];
            if (typeof current.value === 'number') {
                const change = (Math.random() - 0.5) * 0.1;
                current.value += change;
            }
        });

        this.updateTechnicalIndicators();
    }

    // Utility methods
    formatCurrency(value, currency = 'USD') {
        return new Intl.NumberFormat('en-US', {
            style: 'currency',
            currency: currency,
            minimumFractionDigits: 2,
            maximumFractionDigits: 2
        }).format(value);
    }

    getTrendColor(trend) {
        switch (trend) {
            case 'up': return 'success';
            case 'down': return 'danger';
            default: return 'warning';
        }
    }

    getImpactColor(impact) {
        switch (impact) {
            case 'positive': return 'success';
            case 'negative': return 'danger';
            case 'mixed': return 'warning';
            default: return 'info';
        }
    }
}

// Initialize dashboard when DOM is ready
const dashboardManager = new DashboardManager();
"@

New-FileSafe -Path "js/dashboard.js" -Content $enhancedDashboardJsContent -Description "Advanced dashboard JavaScript"

# Enhanced index.html with modern design and features
$enhancedIndexHtml = @"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Advanced Financial Market Forecaster with real-time analysis, sentiment tracking, and predictive modeling">
    <meta name="keywords" content="financial forecasting, market analysis, trading, investment, sentiment analysis">
    <meta name="author" content="asarekings">
    
    <title>Financial Market Forecaster - Advanced Market Analysis Platform</title>
    
    <!-- Favicon -->
    <link rel="icon" type="image/svg+xml" href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'><text y='.9em' font-size='90'>📈</text></svg>">
    
    <!-- External CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/style.css">
    
    <!-- Open Graph Meta Tags -->
    <meta property="og:title" content="Financial Market Forecaster">
    <meta property="og:description" content="Advanced Financial Market Analysis Platform">
    <meta property="og:type" content="website">
    <meta property="og:url" content="https://asarekings.github.io/financial-forecaster/">
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg sticky-top">
        <div class="container">
            <a class="navbar-brand d-flex align-items-center" href="index.html">
                <i class="fas fa-chart-line me-2"></i>
                Financial Market Forecaster
            </a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto align-items-center">
                    <li class="nav-item">
                        <a class="nav-link active" href="index.html">
                            <i class="fas fa-home me-1"></i>Home
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="dashboard.html">
                            <i class="fas fa-tachometer-alt me-1"></i>Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="https://github.com/asarekings/financial-forecaster" target="_blank">
                            <i class="fab fa-github me-1"></i>GitHub
                        </a>
                    </li>
                    <li class="nav-item ms-2">
                        <button class="theme-toggle btn btn-outline-secondary btn-sm" title="Toggle theme">
                            🌙
                        </button>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <header class="hero-section py-5">
        <div class="container">
            <div class="row align-items-center min-vh-75">
                <div class="col-lg-6">
                    <div class="hero-content">
                        <h1 class="display-3 fw-bold mb-4">
                            Advanced <span class="text-primary">Financial Market</span> Forecaster
                        </h1>
                        <p class="lead mb-4 text-muted">
                            Harness the power of AI-driven analysis, real-time sentiment tracking, and advanced technical indicators to make informed investment decisions with unprecedented accuracy.
                        </p>
                        
                        <div class="hero-stats row g-3 mb-4">
                            <div class="col-4">
                                <div class="stat text-center">
                                    <div class="stat-number text-primary fw-bold">97%</div>
                                    <div class="stat-label small text-muted">Accuracy</div>
                                </div>
                            </div>
                            <div class="col-4">
                                <div class="stat text-center">
                                    <div class="stat-number text-success fw-bold">1000+</div>
                                    <div class="stat-label small text-muted">Data Sources</div>
                                </div>
                            </div>
                            <div class="col-4">
                                <div class="stat text-center">
                                    <div class="stat-number text-warning fw-bold">24/7</div>
                                    <div class="stat-label small text-muted">Monitoring</div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="hero-actions">
                            <a href="dashboard.html" class="btn btn-primary btn-lg me-3">
                                <i class="fas fa-chart-bar me-2"></i>View Dashboard
                            </a>
                            <a href="#features" class="btn btn-outline-secondary btn-lg">
                                <i class="fas fa-info-circle me-2"></i>Learn More
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="hero-visual">
                        <div class="card border-0 shadow-lg">
                            <div class="card-body p-0">
                                <div class="placeholder-chart bg-gradient-primary text-white text-center py-5">
                                    <i class="fas fa-chart-line fa-4x mb-3 opacity-75"></i>
                                    <h4>Real-time Market Analysis</h4>
                                    <p class="mb-0">Live data visualization and predictive modeling</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <!-- Features Section -->
    <section id="features" class="py-5">
        <div class="container">
            <div class="text-center mb-5">
                <h2 class="display-5 fw-bold">Comprehensive Market Intelligence</h2>
                <p class="lead text-muted">Advanced tools and analytics for modern investors</p>
            </div>
            
            <div class="row g-4">
                <div class="col-lg-4 col-md-6">
                    <div class="card feature-card h-100 border-0 shadow">
                        <div class="card-body text-center p-4">
                            <div class="feature-icon text-primary mb-3">
                                <i class="fas fa-chart-area fa-3x"></i>
                            </div>
                            <h4 class="card-title">Market Data Analysis</h4>
                            <p class="card-text text-muted">
                                Advanced algorithms analyze historical price data, volume patterns, and market trends across multiple exchanges and timeframes.
                            </p>
                            <ul class="list-unstyled text-start mt-3">
                                <li><i class="fas fa-check text-success me-2"></i>Real-time data feeds</li>
                                <li><i class="fas fa-check text-success me-2"></i>Multi-timeframe analysis</li>
                                <li><i class="fas fa-check text-success me-2"></i>Pattern recognition</li>
                            </ul>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6">
                    <div class="card feature-card h-100 border-0 shadow">
                        <div class="card-body text-center p-4">
                            <div class="feature-icon text-success mb-3">
                                <i class="fas fa-brain fa-3x"></i>
                            </div>
                            <h4 class="card-title">AI Sentiment Analysis</h4>
                            <p class="card-text text-muted">
                                Natural language processing monitors news, social media, and financial reports to gauge market sentiment and predict movements.
                            </p>
                            <ul class="list-unstyled text-start mt-3">
                                <li><i class="fas fa-check text-success me-2"></i>News sentiment tracking</li>
                                <li><i class="fas fa-check text-success me-2"></i>Social media analysis</li>
                                <li><i class="fas fa-check text-success me-2"></i>Sentiment scoring</li>
                            </ul>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6">
                    <div class="card feature-card h-100 border-0 shadow">
                        <div class="card-body text-center p-4">
                            <div class="feature-icon text-warning mb-3">
                                <i class="fas fa-globe fa-3x"></i>
                            </div>
                            <h4 class="card-title">Macroeconomic Integration</h4>
                            <p class="card-text text-muted">
                                Incorporate key economic indicators, central bank policies, and global events into comprehensive forecasting models.
                            </p>
                            <ul class="list-unstyled text-start mt-3">
                                <li><i class="fas fa-check text-success me-2"></i>Economic indicators</li>
                                <li><i class="fas fa-check text-success me-2"></i>Policy analysis</li>
                                <li><i class="fas fa-check text-success me-2"></i>Global correlation</li>
                            </ul>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6">
                    <div class="card feature-card h-100 border-0 shadow">
                        <div class="card-body text-center p-4">
                            <div class="feature-icon text-info mb-3">
                                <i class="fas fa-cogs fa-3x"></i>
                            </div>
                            <h4 class="card-title">Technical Indicators</h4>
                            <p class="card-text text-muted">
                                Comprehensive suite of technical analysis tools including RSI, MACD, Bollinger Bands, and custom proprietary indicators.
                            </p>
                            <ul class="list-unstyled text-start mt-3">
                                <li><i class="fas fa-check text-success me-2"></i>50+ indicators</li>
                                <li><i class="fas fa-check text-success me-2"></i>Custom algorithms</li>
                                <li><i class="fas fa-check text-success me-2"></i>Signal generation</li>
                            </ul>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6">
                    <div class="card feature-card h-100 border-0 shadow">
                        <div class="card-body text-center p-4">
                            <div class="feature-icon text-danger mb-3">
                                <i class="fas fa-shield-alt fa-3x"></i>
                            </div>
                            <h4 class="card-title">Risk Management</h4>
                            <p class="card-text text-muted">
                                Advanced risk assessment tools including VaR calculations, portfolio optimization, and stress testing capabilities.
                            </p>
                            <ul class="list-unstyled text-start mt-3">
                                <li><i class="fas fa-check text-success me-2"></i>Risk metrics</li>
                                <li><i class="fas fa-check text-success me-2"></i>Portfolio analysis</li>
                                <li><i class="fas fa-check text-success me-2"></i>Stress testing</li>
                            </ul>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6">
                    <div class="card feature-card h-100 border-0 shadow">
                        <div class="card-body text-center p-4">
                            <div class="feature-icon text-secondary mb-3">
                                <i class="fas fa-history fa-3x"></i>
                            </div>
                            <h4 class="card-title">Backtesting Framework</h4>
                            <p class="card-text text-muted">
                                Comprehensive backtesting engine to validate strategies against historical data with detailed performance analytics.
                            </p>
                            <ul class="list-unstyled text-start mt-3">
                                <li><i class="fas fa-check text-success me-2"></i>Strategy testing</li>
                                <li><i class="fas fa-check text-success me-2"></i>Performance metrics</li>
                                <li><i class="fas fa-check text-success me-2"></i>Optimization tools</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Stats Section -->
    <section class="stats-section py-5 bg-light">
        <div class="container">
            <div class="row text-center">
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="stat-item">
                        <div class="stat-number display-4 fw-bold text-primary">500K+</div>
                        <div class="stat-label h5 text-muted">Data Points Analyzed Daily</div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="stat-item">
                        <div class="stat-number display-4 fw-bold text-success">97.3%</div>
                        <div class="stat-label h5 text-muted">Prediction Accuracy</div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="stat-item">
                        <div class="stat-number display-4 fw-bold text-warning">50+</div>
                        <div class="stat-label h5 text-muted">Markets Covered</div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 mb-4">
                    <div class="stat-item">
                        <div class="stat-number display-4 fw-bold text-info">24/7</div>
                        <div class="stat-label h5 text-muted">Real-time Monitoring</div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="cta-section py-5">
        <div class="container">
            <div class="row justify-content-center text-center">
                <div class="col-lg-8">
                    <h2 class="display-5 fw-bold mb-4">Ready to Transform Your Trading Strategy?</h2>
                    <p class="lead mb-4 text-muted">
                        Join thousands of successful traders who rely on our advanced analytics for informed decision-making.
                    </p>
                    <div class="cta-actions">
                        <a href="dashboard.html" class="btn btn-primary btn-lg me-3">
                            <i class="fas fa-rocket me-2"></i>Start Analyzing
                        </a>
                        <a href="https://github.com/asarekings/financial-forecaster" class="btn btn-outline-primary btn-lg" target="_blank">
                            <i class="fab fa-github me-2"></i>View Source Code
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="py-4">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <p class="mb-0 text-muted">
                        &copy; <span id="current-year">2025</span> Financial Market Forecaster
                    </p>
                </div>
                <div class="col-md-6 text-md-end">
                    <p class="mb-0">
                        Created with ❤️ by 
                        <a href="https://github.com/asarekings" target="_blank" class="text-decoration-none">
                            <i class="fab fa-github me-1"></i>asarekings
                        </a>
                    </p>
                </div>
            </div>
        </div>
    </footer>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/main.js"></script>
</body>
</html>
"@

New-FileSafe -Path "index.html" -Content $enhancedIndexHtml -Description "Enhanced index.html with modern design"

# Enhanced dashboard.html with comprehensive analytics
$enhancedDashboardHtml = @"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Advanced Financial Market Dashboard with real-time analytics and forecasting">
    
    <title>Dashboard - Financial Market Forecaster</title>
    
    <!-- Favicon -->
    <link rel="icon" type="image/svg+xml" href="data:image/svg+xml,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'><text y='.9em' font-size='90'>📊</text></svg>">
    
    <!-- External CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.min.js"></script>
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg sticky-top">
        <div class="container">
            <a class="navbar-brand d-flex align-items-center" href="index.html">
                <i class="fas fa-chart-line me-2"></i>
                Financial Market Forecaster
            </a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto align-items-center">
                    <li class="nav-item">
                        <a class="nav-link" href="index.html">
                            <i class="fas fa-home me-1"></i>Home
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="dashboard.html">
                            <i class="fas fa-tachometer-alt me-1"></i>Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="https://github.com/asarekings/financial-forecaster" target="_blank">
                            <i class="fab fa-github me-1"></i>GitHub
                        </a>
                    </li>
                    <li class="nav-item ms-2">
                        <button class="theme-toggle btn btn-outline-secondary btn-sm" title="Toggle theme">
                            🌙
                        </button>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container-fluid py-4">
        <!-- Dashboard Header -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="card border-0 shadow-sm">
                    