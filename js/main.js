﻿// Financial Market Forecaster - Clean JavaScript
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
            toggle.textContent = App.theme === 'light' ? 'ðŸŒ™ Dark' : 'â˜€ï¸ Light';
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
