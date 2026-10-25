-- Filtered trade data by selected product codes, aggregated export and import volumes and values, and grouped results by product name.

SELECT code
	, product
	, SUM(export_t) AS export_tons
    , SUM(export_usd) AS export_usd
    , SUM(import_t) AS import_tons
    , SUM(import_usd) AS import_usd
FROM september
WHERE code IN (102, 201, 202)
GROUP BY product
ORDER BY code ASC;

-- Ranked export destination countries by total export value for live cattle using aggregation and sorting.

SELECT country
    , SUM(export_usd) AS export_usd
FROM september
WHERE code IN (102)
GROUP BY country
ORDER BY export_usd ASC
LIMIT 10;

-- Combined export data from three monthly tables by country and product code using SQL joins to create a unified dataset for further analysis in Power BI.

SELECT
    s.country,
    s.code,
    s.product,
    j.export_usd AS july,
    a.export_usd AS august,
    s.export_usd AS september
FROM september AS s
LEFT JOIN august AS a
    ON s.country = a.country
    AND s.code = a.code
LEFT JOIN july AS j
    ON s.country = j.country
    AND s.code = j.code
WHERE s.code IN (
		102, 201, 202, 401, 402, 403, 404, 405, 406, 2105, 3501
);