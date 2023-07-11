-- checking the first dataset

SELECT *
FROM public.all_stocks as2;

-- checking the second dataset

SELECT *
FROM public.sp500_constituents sc;

-- the top 10 companies based on avg number of shares traded in a day

SELECT alst."Name" AS ticker, 
	sp."Name", 
	round(avg(alst.volume), 2) AS avg_number_of_shares
FROM public.sp500_constituents AS sp
LEFT JOIN public.all_stocks AS alst
ON alst."Name" = sp.ticker 
WHERE alst."Name" IS NOT NULL 
	AND sp."Name" IS NOT NULL 
GROUP BY alst."Name", sp."Name"  
ORDER BY avg(alst.volume) DESC 
LIMIT 10;

-- the top 10 companies based on avg opening price

SELECT alst."Name" AS ticker, 
	sp."Name", 
	avg(alst."open") AS avg_open_price
FROM public.sp500_constituents AS sp
LEFT JOIN public.all_stocks AS alst
ON alst."Name" = sp.ticker 
WHERE alst."Name" IS NOT NULL 
	AND sp."Name" IS NOT NULL 
GROUP BY alst."Name", sp."Name"  
ORDER BY avg(alst.open) DESC 
LIMIT 10;

-- the top 10 companies based on avg closing price

SELECT alst."Name" AS ticker, 
	sp."Name", 
	avg(alst."close") AS avg_close_price
FROM public.sp500_constituents AS sp
LEFT JOIN public.all_stocks AS alst
ON alst."Name" = sp.ticker 
WHERE alst."Name" IS NOT NULL 
	AND sp."Name" IS NOT NULL 
GROUP BY alst."Name", sp."Name"  
ORDER BY avg(alst.close) DESC 
LIMIT 10;

-- showing top 10 volitile companies

SELECT alst."Name" AS ticker, 
	sp."Name", 
	avg(alst.high - alst.low) AS avg_volitility
FROM public.sp500_constituents AS sp
LEFT JOIN public.all_stocks AS alst
ON alst."Name" = sp.ticker 
WHERE alst."Name" IS NOT NULL 
	AND sp."Name" IS NOT NULL 
GROUP BY alst."Name", sp."Name"  
ORDER BY avg(alst.high - alst.low) DESC 
LIMIT 10;

-- top 10 differences of a stock's single day prices w/ dates

SELECT alst."date", 
	alst."Name" AS ticker, 
	sp."Name" AS company, 
	(alst.high - alst.low) AS price_diff
FROM public.sp500_constituents AS sp
LEFT JOIN public.all_stocks AS alst
ON alst."Name" = sp.ticker 
WHERE alst."Name" IS NOT NULL 
	AND sp."Name" IS NOT NULL 
	AND (alst.high - alst.low) IS NOT NULL 
GROUP BY alst."Name", sp."Name", alst."date", alst.high, alst.low
ORDER BY (alst.high - alst.low) DESC 
LIMIT 10;

-- top 10 industries based on total stocks traded

SELECT sp.industry, 
	sum(alst.volume) AS total_volume
FROM public.sp500_constituents AS sp
LEFT JOIN public.all_stocks AS alst
ON alst."Name" = sp.ticker 
WHERE alst.volume IS NOT NULL 
GROUP BY sp.industry 
ORDER BY sum(alst.volume) DESC 
LIMIT 10;

-- top 10 sub-industries based on total stocks traded

SELECT sp.industry, 
	sp."Sub-Industry", 
	sum(alst.volume) AS total_volume
FROM public.sp500_constituents AS sp
LEFT JOIN public.all_stocks AS alst
ON alst."Name" = sp.ticker 
WHERE alst.volume IS NOT NULL 
GROUP BY sp.industry, sp."Sub-Industry"
ORDER BY sum(alst.volume) DESC 
LIMIT 10;