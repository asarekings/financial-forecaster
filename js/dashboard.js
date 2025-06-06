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
        'ma50Value': ',632.54',
        'ma200Value': ',487.22',
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
