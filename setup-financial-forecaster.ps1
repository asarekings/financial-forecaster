# Financial Market Forecaster Project Setup Script
# Created by: asarekings
# Date: 2025-06-06 13:57:55

Write-Output "Creating Financial Market Forecaster project structure..."

# Create required directories
@(
    "_layouts", 
    "_includes", 
    "assets/css", 
    "assets/js", 
    "_data", 
    "models", 
    "market-data", 
    "sentiment", 
    "macro", 
    "backtest", 
    "risk", 
    "scripts"
) | ForEach-Object {
    New-Item -ItemType Directory -Path $_ -Force | Out-Null
    Write-Output "Created directory: $_"
}

# Create _config.yml
$configYml = @'
# Site settings
title: Financial Market Forecaster
email: your-email@example.com
description: >-
  A comprehensive financial market forecasting system combining technical indicators, 
  sentiment analysis and macroeconomic factors.
baseurl: "/financial-forecaster"
url: "https://asarekings.github.io"

# Build settings
markdown: kramdown
theme: minima
plugins:
  - jekyll-feed
  - jekyll-seo-tag
  - jekyll-sitemap

# Collections
collections:
  models:
    output: true
  indicators:
    output: true
  dashboards:
    output: true

# Defaults
defaults:
  - scope:
      path: ""
      type: "posts"
    values:
      layout: "post"
  - scope:
      path: ""
      type: "models"
    values:
      layout: "model"
  - scope:
      path: ""
      type: "indicators"
    values:
      layout: "indicator"
  - scope:
      path: ""
      type: "dashboards"
    values:
      layout: "dashboard"
  - scope:
      path: ""
    values:
      layout: "default"

# Exclude from processing
exclude:
  - Gemfile
  - Gemfile.lock
  - node_modules
  - vendor
  - .sass-cache
  - data_processing
  - scripts
  - README.md
  - LICENSE
  - requirements.txt
'@
Set-Content -Path "_config.yml" -Value $configYml
Write-Output "Created _config.yml"

# Create Gemfile
$gemfile = @'
source "https://rubygems.org"

gem "jekyll", "~> 4.2.0"
gem "minima", "~> 2.5"

group :jekyll_plugins do
  gem "jekyll-feed", "~> 0.12"
  gem "jekyll-seo-tag", "~> 2.7"
  gem "jekyll-sitemap", "~> 1.4"
end

# Windows and JRuby does not include zoneinfo files, so bundle the tzinfo-data gem
platforms :mingw, :x64_mingw, :mswin, :jruby do
  gem "tzinfo", "~> 1.2"
  gem "tzinfo-data"
end

# Performance-booster for watching directories on Windows
gem "wdm", "~> 0.1.1", :platforms => [:mingw, :x64_mingw, :mswin]
'@
Set-Content -Path "Gemfile" -Value $gemfile
Write-Output "Created Gemfile"

# Create requirements.txt
$requirements = @'
pandas==1.4.4
numpy==1.23.3
scikit-learn==1.1.2
matplotlib==3.6.0
seaborn==0.12.0
plotly==5.10.0
dash==2.6.2
yfinance==0.1.74
alpha_vantage==2.3.1
fredapi==0.5.0
tweepy==4.10.1
newsapi-python==0.2.6
nltk==3.7
textblob==0.17.1
statsmodels==0.13.2
pytest==7.1.3
'@
Set-Content -Path "requirements.txt" -Value $requirements
Write-Output "Created requirements.txt"

# Create README.md
$readme = @'
# Financial Market Forecaster

A comprehensive financial market forecasting system that combines technical indicators, sentiment analysis, and macroeconomic factors to predict market movements with advanced visualization and backtesting capabilities.

## Features

- **Market Data Analysis**: Track and analyze historical price data from multiple markets
- **Sentiment Analysis**: Monitor news and social media sentiment related to financial markets
- **Macroeconomic Integration**: Incorporate key economic indicators into forecasting models
- **Interactive Dashboard**: Visualize data and predictions through customizable charts
- **Backtesting Framework**: Test strategies against historical data
- **Risk Assessment**: Quantify risk metrics for potential investments

## Getting Started

### Prerequisites

- Ruby (for Jekyll)
- Python 3.8+ (for data processing)
- Git

### Installation

```bash
# Clone the repository
git clone https://github.com/asarekings/financial-forecaster.git
cd financial-forecaster

# Install Jekyll dependencies
bundle install

# Install Python dependencies
pip install -r requirements.txt

# Run the Jekyll site locally
bundle exec jekyll serve