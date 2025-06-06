# Fix messy content - Clean Financial Market Forecaster Setup
# Date: 2025-06-06

Write-Host "🔧 Fixing messy content issues..." -ForegroundColor Yellow

# Clean and recreate with proper structure
Write-Host "📁 Cleaning and restructuring..." -ForegroundColor Cyan

# Remove problematic files but keep git
Get-ChildItem -Exclude ".git*", "*.ps1" | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue

# Create clean directory structure
$dirs = @("css", "js", "assets", "img")
foreach ($dir in $dirs) {
    New-Item -ItemType Directory -Path $dir -Force | Out-Null
}

# Create .nojekyll for GitHub Pages
"" | Out-File -FilePath ".nojekyll" -Encoding UTF8

# Create clean, working CSS
$cleanCSS = @'
/* Financial Market Forecaster - Clean CSS */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

:root {
    --primary: #2563eb;
    --secondary: #64748b;
    --success: #10b981;
    --danger: #ef4444;
    --warning: #f59e0b;
    --info: #06b6d4;
    --light: #f8fafc;
    --dark: #1e293b;
    --bg-light: #ffffff;
    --bg-dark: #0f172a;
    --text-light: #334155;
    --text-dark: #e2e8f0;
    --border-light: #e2e8f0;
    --border-dark: #334155;
}

body {
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
    line-height: 1.6;
    color: var(--text-light);
    background-color: var(--bg-light);
    transition: all 0.3s ease;
}

/* Dark theme */
[data-theme="dark"] {
    --bg-light: var(--bg-dark);
    --text-light: var(--text-dark);
    --border-light: var(--border-dark);
}

[data-theme="dark"] body {
    background-color: var(--bg-dark);
    color: var(--text-dark);
}

[data-theme="dark"] .navbar {
    background-color: var(--dark) !important;
}

[data-theme="dark"] .card {
    background-color: var(--dark);
    border-color: var(--border-dark);
    color: var(--text-dark);
}

[data-theme="dark"] .bg-light {
    background-color: var(--dark) !important;
}

/* Navigation */
.navbar {
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    transition: all 0.3s ease;
}

.navbar-brand {
    font-weight: 700;
    font-size: 1.25rem;
}

.theme-toggle {
    background: none;
    border: 1px solid rgba(255,255,255,0.2);
    color: rgba(255,255,255,0.8);
    padding: 0.375rem 0.75rem;
    border-radius: 0.375rem;
    cursor: pointer;
    transition: all 0.3s ease;
    font-size: 0.875rem;
}

.theme-toggle:hover {
    background-color: rgba(255,255,255,0.1);
    color: white;
}

/* Hero section */
.hero-section {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    padding: 4rem 0;
}

.hero-content h1 {
    font-size: 3rem;
    font-weight: 800;
    margin-bottom: 1.5rem;
}

.hero-visual {
    position: relative;
}

.chart-placeholder {
    background: rgba(255,255,255,0.1);
    backdrop-filter: blur(10px);
    border-radius: 1rem;
    padding: 3rem;
    text-align: center;
    border: 1px solid rgba(255,255,255,0.2);
}

/* Cards */
.card {
    border: 1px solid var(--border-light);
    border-radius: 0.75rem;
    box-shadow: 0 1px 3px rgba(0,0,0,0.1);
    transition: all 0.3s ease;
    background-color: var(--bg-light);
}

.card:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(0,0,0,0.15);
}

.feature-card {
    height: 100%;
}

.feature-icon {
    font-size: 3rem;
    margin-bottom: 1rem;
}

/* Charts */
.chart-container {
    position: relative;
    height: 300px;
    width: 100%;
    padding: 1rem;
}

.chart-loading {
    display: flex;
    align-items: center;
    justify-content: center;
    height: 100%;
    color: var(--secondary);
    font-style: italic;
}

/* Dashboard specific */
.dashboard-header {
    background: linear-gradient(135deg, var(--primary) 0%, var(--info) 100%);
    color: white;
    border-radius: 1rem;
    padding: 2rem;
    margin-bottom: 2rem;
}

.indicator-table th {
    color: var(--secondary);
    font-weight: 600;
    border-bottom: 2px solid var(--border-light);
}

.indicator-table td {
    font-weight: 500;
}

/* Status colors */
.status-positive { color: var(--success); }
.status-negative { color: var(--danger); }
.status-neutral { color: var(--warning); }

/* Footer */
footer {
    margin-top: 4rem;
    padding: 2rem 0;
    border-top: 1px solid var(--border-light);
    background-color: var(--bg-light);
}

/* Responsive */
@media (max-width: 768px) {
    .hero-content h1 {
        font-size: 2rem;
    }
    
    .chart-container {
        height: 250px;
    }
    
    .navbar-nav {
        margin-top: 1rem;
    }
    
    .theme-toggle {
        margin-top: 0.5rem;
    }
}

/* Utility classes */
.text-primary { color: var(--primary) !important; }
.text-success { color: var(--success) !important; }
.text-danger { color: var(--danger) !important; }
.text-warning { color: var(--warning) !important; }
.text-info { color: var(--info) !important; }

.btn-primary {
    background-color: var(--primary);
    border-color: var(--primary);
}

.btn-primary:hover {
    background-color: #1d4ed8;
    border-color: #1d4ed8;
}

/* Loading animation */
.loading {
    opacity: 0.6;
}

.spinner {
    width: 2rem;
    height: 2rem;
    border: 2px solid transparent;
    border-top: 2px solid var(--primary);
    border-radius: 50%;
    animation: spin 1s linear infinite;
}

@keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
}
'@

$cleanCSS | Out-File -FilePath "css/style.css" -Encoding UTF8
Write-Host "✅ Created clean CSS" -ForegroundColor Green

# Create robust JavaScript
$cleanJS = @'
// Financial Market Forecaster - Clean JavaScript
(function() {
    'use strict';
    
    // App state
    const App = {
        theme: localStorage.getItem('theme') || 'light',
        charts: {},
        updateInterval: null
    };
    
    // Initialize when DOM is ready
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }
    
    function init() {
        console.log('Initializing Financial Market Forecaster...');
        
        setupTheme();
        setupEventListeners();
        updateFooterYear();
        initializeTooltips();
        
        // Initialize charts if on dashboard
        if (document.getElementById('marketOverviewChart')) {
            initializeDashboard();
        }
        
        console.log('Initialization complete');
    }
    
    function setupTheme() {
        applyTheme(App.theme);
        updateThemeToggle();
    }
    
    function setupEventListeners() {
        // Theme toggle
        const themeToggle = document.querySelector('.theme-toggle');
        if (themeToggle) {
            themeToggle.addEventListener('click', toggleTheme);
        }
        
        // Handle page visibility
        document.addEventListener('visibilitychange', () => {
            if (document.hidden) {
                stopUpdates();
            } else {
                startUpdates();
            }
        });
    }
    
    function toggleTheme() {
        App.theme = App.theme === 'light' ? 'dark' : 'light';
        applyTheme(App.theme);
        updateThemeToggle();
        localStorage.setItem('theme', App.theme);
    }
    
    function applyTheme(theme) {
        document.documentElement.setAttribute('data-theme', theme);
    }
    
    function updateThemeToggle() {
        const toggle = document.querySelector('.theme-toggle');
        if (toggle) {
            toggle.textContent = App.theme === 'light' ? '🌙 Dark' : '☀️ Light';
        }
    }
    
    function updateFooterYear() {
        const yearElement = document.getElementById('current-year');
        if (yearElement) {
            yearElement.textContent = new Date().getFullYear();
        }
    }
    
    function initializeTooltips() {
        if (typeof bootstrap !== 'undefined' && bootstrap.Tooltip) {
            const tooltips = document.querySelectorAll('[data-bs-toggle="tooltip"]');
            tooltips.forEach(el => new bootstrap.Tooltip(el));
        }
    }
    
    function initializeDashboard() {
        console.log('Initializing dashboard...');
        
        // Wait for Chart.js to load
        if (typeof Chart === 'undefined') {
            console.warn('Chart.js not loaded, retrying...');
            setTimeout(initializeDashboard, 1000);
            return;
        }
        
        try {
            createMarketChart();
            createSentimentChart();
            updateIndicators();
            updateTimestamps();
            startUpdates();
        } catch (error) {
            console.error('Dashboard initialization error:', error);
        }
    }
    
    function createMarketChart() {
        const ctx = document.getElementById('marketOverviewChart');
        if (!ctx) return;
        
        const labels = generateDateLabels(30);
        const data = {
            labels: labels,
            datasets: [
                {
                    label: 'S&P 500',
                    data: generateMarketData(30, 4500, 4700),
                    borderColor: '#2563eb',
                    backgroundColor: 'rgba(37, 99, 235, 0.1)',
                    tension: 0.4,
                    fill: false
                },
                {
                    label: 'NASDAQ',
                    data: generateMarketData(30, 14000, 14500),
                    borderColor: '#8b5cf6',
                    backgroundColor: 'rgba(139, 92, 246, 0.1)',
                    tension: 0.4,
                    fill: false
                },
                {
                    label: 'Dow Jones',
                    data: generateMarketData(30, 35000, 36000),
                    borderColor: '#f59e0b',
                    backgroundColor: 'rgba(245, 158, 11, 0.1)',
                    tension: 0.4,
                    fill: false
                }
            ]
        };
        
        App.charts.market = new Chart(ctx, {
            type: 'line',
            data: data,
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'top',
                        labels: {
                            usePointStyle: true,
                            padding: 20
                        }
                    },
                    tooltip: {
                        mode: 'index',
                        intersect: false
                    }
                },
                scales: {
                    x: {
                        grid: { display: false }
                    },
                    y: {
                        beginAtZero: false,
                        grid: { color: 'rgba(0,0,0,0.1)' }
                    }
                },
                interaction: {
                    intersect: false,
                    mode: 'index'
                }
            }
        });
    }
    
    function createSentimentChart() {
        const ctx = document.getElementById('sentimentGaugeChart');
        if (!ctx) return;
        
        App.charts.sentiment = new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: ['Bullish', 'Bearish', 'Neutral'],
                datasets: [{
                    data: [65, 20, 15],
                    backgroundColor: [
                        '#10b981',
                        '#ef4444',
                        '#f59e0b'
                    ],
                    borderWidth: 0,
                    cutout: '60%'
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom',
                        labels: {
                            padding: 20,
                            usePointStyle: true
                        }
                    }
                }
            }
        });
    }
    
    function updateIndicators() {
        const indicators = {
            'rsiValue': '62.5 (Neutral)',
            'macdValue': '1.2 (Bullish)',
            'bollingerValue': 'Middle Band (Neutral)',
            'ma50Value': '$4,632.54 (Above)',
            'ma200Value': '$4,487.22 (Below)',
            'sentimentSourceCount': '1,247',
            'predictionConfidence': '87%'
        };
        
        Object.entries(indicators).forEach(([id, value]) => {
            const element = document.getElementById(id);
            if (element) {
                element.textContent = value;
                
                // Add status colors
                if (value.includes('Bullish') || value.includes('Above')) {
                    element.className = 'status-positive';
                } else if (value.includes('Bearish') || value.includes('Below')) {
                    element.className = 'status-negative';
                } else {
                    element.className = 'status-neutral';
                }
            }
        });
    }
    
    function updateTimestamps() {
        const now = new Date();
        const timestamp = now.toLocaleString('en-US', {
            year: 'numeric',
            month: 'short',
            day: 'numeric',
            hour: '2-digit',
            minute: '2-digit'
        });
        
        const updateElement = document.getElementById('marketUpdateTime');
        if (updateElement) {
            updateElement.textContent = timestamp;
        }
    }
    
    function startUpdates() {
        if (App.updateInterval) return;
        
        App.updateInterval = setInterval(() => {
            updateTimestamps();
            if (App.charts.market) {
                simulateMarketUpdate();
            }
        }, 30000); // Update every 30 seconds
    }
    
    function stopUpdates() {
        if (App.updateInterval) {
            clearInterval(App.updateInterval);
            App.updateInterval = null;
        }
    }
    
    function simulateMarketUpdate() {
        // Add small random movements to charts
        Object.values(App.charts).forEach(chart => {
            if (chart.data && chart.data.datasets) {
                chart.data.datasets.forEach(dataset => {
                    if (dataset.data.length > 0) {
                        const lastValue = dataset.data[dataset.data.length - 1];
                        const change = (Math.random() - 0.5) * 0.02 * lastValue;
                        dataset.data.push(lastValue + change);
                        
                        // Keep only last 50 points
                        if (dataset.data.length > 50) {
                            dataset.data.shift();
                        }
                    }
                });
                
                // Update labels
                if (chart.data.labels.length >= 50) {
                    chart.data.labels.shift();
                }
                chart.data.labels.push(new Date().toLocaleTimeString());
                
                chart.update('none');
            }
        });
    }
    
    // Utility functions
    function generateMarketData(count, min, max) {
        const data = [];
        let current = min + (max - min) * Math.random();
        
        for (let i = 0; i < count; i++) {
            const change = (Math.random() - 0.5) * 0.02 * current;
            current += change;
            data.push(Math.round(current * 100) / 100);
        }
        
        return data;
    }
    
    function generateDateLabels(count) {
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
    
    // Expose utilities globally
    window.FinancialForecaster = {
        theme: App.theme,
        charts: App.charts,
        updateIndicators: updateIndicators,
        updateTimestamps: updateTimestamps
    };
    
})();
'@

$cleanJS | Out-File -FilePath "js/main.js" -Encoding UTF8
Write-Host "✅ Created clean JavaScript" -ForegroundColor Green

# Create