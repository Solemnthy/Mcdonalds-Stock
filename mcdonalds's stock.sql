-- 1. Find the highest and lowest stock prices in the dataset
select 
    max(close) as highest_close_price, 
    min(close) as lowest_close_price 
from mcd;

-- 2. Calculate the average trading volume per year
select 
    substr(date, 1, 4) as year, 
    avg(volume) as avg_volume 
from mcd 
group by year 
order by year;

-- 3. Identify periods of significant price changes (volatility)
select 
    date, 
    close, 
    (close - lag(close, 1) over (order by date)) / lag(close, 1) over (order by date) * 100 as price_change_percentage 
from mcd
where abs((close - lag(close, 1) over (order by date)) / lag(close, 1) over (order by date) * 100) > 5;

-- 4. Determine the best month to invest based on historical performance (average close price)
select 
    substr(date, 6, 2) as month, 
    avg(close) as avg_close_price 
from mcd 
group by month 
order by avg_close_price desc;

-- 5. Calculate the moving averages (50-day, 200-day) to detect trends for traders
select 
    date, 
    close, 
    avg(close) over (order by date rows between 49 preceding and current row) as moving_avg_50_day, 
    avg(close) over (order by date rows between 199 preceding and current row) as moving_avg_200_day 
from mcd
where date >= '2023-01-01';

-- 6. Identify the best-performing years based on the adjusted close price
select 
    substr(date, 1, 4) as year, 
    avg(adj_close) as avg_adj_close 
from mcd 
group by year 
order by avg_adj_close desc;

-- 7. Compare McDonald’s stock performance before and after major economic events (e.g., 2008 financial crisis)
select 
    case 
        when date between '2007-01-01' and '2009-12-31' then 'during crisis' 
        else 'other periods' 
    end as period, 
    avg(close) as avg_close_price 
from mcd 
group by period;

-- 8. Analyze stock performance on a yearly basis for stakeholders to assess long-term growth
select 
    substr(date, 1, 4) as year, 
    max(close) - min(close) as price_range, 
    avg(volume) as avg_volume_per_year 
from mcd 
group by year 
order by year;