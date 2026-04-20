USE finance;

-- ================================
-- SECTION 1: Basic SELECT (1–10)
-- ================================

-- 1. Retrieve all client records
-- Shows every column and row from the clients table
SELECT * FROM clients;


-- 2. List all unique gender IDs
-- Returns distinct gender categories stored in the clients table
SELECT DISTINCT GenderId FROM clients;


-- 3. Count total clients
-- Counts the total number of clients in the database
SELECT COUNT(*) AS total_clients FROM clients;


-- 4. List first 10 clients
-- Retrieves a sample of the first 10 client records
SELECT * FROM clients LIMIT 10;


-- 5. Count clients by gender
-- Groups clients by GenderId and counts how many are in each group
SELECT GenderId, COUNT(*) AS client_count
FROM clients
GROUP BY GenderId;


-- 6. List all banking relationships
-- Displays all records from the banking_relationships table
SELECT * FROM banking_relationships;


-- 7. Count distinct banking relationships
-- Counts the number of unique banking relationship types
SELECT COUNT(DISTINCT BRId) AS relationship_types 
FROM banking_relationships;


-- 8. List all investment advisors
-- Shows all investment advisors in the system
SELECT * FROM investment_advisors;


-- 9. Count total investment advisors
-- Counts how many investment advisors exist
SELECT COUNT(*) AS total_advisors 
FROM investment_advisors;


-- 10. Count clients per investment advisor
-- Groups clients by advisor ID and counts how many clients each advisor manages
SELECT IAId, COUNT(*) AS client_count
FROM clients
GROUP BY IAId;

-- ================================
-- SECTION 2: Filtering (11–20)
-- ================================

-- 11. Clients with specific gender
-- Retrieves all clients where GenderId = 1 (male)
SELECT * 
FROM clients 
WHERE GenderId = 1;


-- 12. Clients with specific advisor
-- Shows all clients assigned to investment advisor with ID 5
SELECT * 
FROM clients 
WHERE IAId = 5;


-- 13. Clients with multiple conditions (AND)
-- Returns clients who are male AND are managed by advisor ID 5
SELECT * 
FROM clients 
WHERE GenderId = 1 AND IAId = 5;


-- 14. Clients with multiple conditions (OR)
-- Returns clients who are either male OR managed by advisor ID 5
SELECT * 
FROM clients 
WHERE GenderId = 1 OR IAId = 5;


-- 15. Clients NOT with specific advisor
-- Retrieves clients who are not assigned to advisor ID 5
SELECT * 
FROM clients 
WHERE IAId != 5;

-- 16. Business Question: Show clients with advisor IDs between 3 and 7.
SELECT *
FROM clients
WHERE IAId BETWEEN 3 AND 7;

-- 17. Business Question: Show clients with advisor IDs 2, 5, or 8.
SELECT *
FROM clients
WHERE IAId IN (2,5,8);

-- 18. Business Question: How many female clients do we have?
SELECT COUNT(*)
FROM clients
WHERE GenderId = 2;

-- 19. Business Question: Show clients who DON'T work with advisors 1, 2, or 3.
SELECT *
FROM clients
WHERE IAId NOT IN(1,2,3);

-- 20. Business Question: How many clients don't have banking relationship ID 1?
SELECT *
FROM clients
WHERE BRId != 1;

-- ================================
-- SECTION 3: INNER JOIN (21–30)
-- ================================

-- 21. Business Question: Show client details with their gender information.
SELECT c.*, g.*
FROM clients c
INNER JOIN gender g ON c.GenderId = g.GenderId;

-- 22. Business Question: Show clients with their banking relationship details.
SELECT c.*, br.*
FROM clients c 
INNER JOIN banking_relationships br on c.BRId = br.BRId;

-- 23. Business Question: Show clients with their advisor information.
SELECT c.*, ia.*
FROM clients c 
INNER JOIN investment_advisors ia on c.IAId = ia.IAId;

-- 24. Business Question: Show complete client profile with gender, banking, and advisor info.
SELECT c.*,g.*,br.*,ia.*
FROM clients c 
INNER JOIN gender g on c.GenderId = g.GenderId
INNER JOIN banking_relationships br  on  c.BRId = br.BRId
INNER JOIN investment_advisors ia on c.IAId = ia.IAId;

-- 25. Business Question: How many clients does each advisor have (showing advisor details)?
SELECT ia.*, COUNT(c.BRId) AS client_count
FROM investment_advisors ia
INNER JOIN clients c ON ia.IAId = c.IAId
GROUP BY ia.IAId;

-- 26. Business Question: Show female clients with their advisor information.
SELECT c.*, ia.*
FROM clients c
INNER JOIN investment_advisors ia ON c.IAId = ia.IAId
WHERE c.GenderId = 2;

-- 27. Business Question: Which advisors manage more than 10 clients?
SELECT ia.*, COUNT(c.BRId) AS client_count
FROM investment_advisors ia
INNER JOIN clients c ON ia.IAId = c.IAId
GROUP BY ia.IAId
HAVING COUNT(c.BRId) > 10;

-- 28. Business Question: Count clients by gender and banking relationship type.
SELECT g.GenderId, br.BRId, COUNT(*) AS client_count
FROM clients c
INNER JOIN gender g ON c.GenderId = g.GenderId
INNER JOIN banking_relationships br ON c.BRId = br.BRId
GROUP BY g.GenderId, br.BRId
ORDER BY g.GenderId, br.BRId;

-- 29. Business Question: Show clients with advisors, ordered by advisor ID.
SELECT c.Name, ia.*
FROM clients c
INNER JOIN investment_advisors ia ON c.IAId = ia.IAId
ORDER BY ia.IAId, c.BRId;

-- 30. Business Question: Find clients who share the same advisor and gender.
SELECT c1.Name, c1.BRId AS client1, c2.BRId AS client2, c1.IAId, c1.GenderId
FROM clients c1
INNER JOIN clients c2 ON c1.IAId = c2.IAId AND c1.GenderId = c2.GenderId
WHERE c1.BRId < c2.BRId;

-- ================================
-- SECTION 4: LEFT JOIN (31–40)
-- ================================

-- 31. Business Question: Show all advisors and how many clients they have (including those with no clients).
SELECT ia.IAId,ia.`Investment Advisor`, COUNT(c.IAId)
FROM investment_advisors ia
LEFT JOIN clients c ON ia.IAId = c.IAId
GROUP BY ia.IAId;

-- 32. Business Question: Which advisors have no clients assigned?
SELECT ia.IAId,
    ia.`Investment Advisor`
FROM investment_advisors ia
LEFT JOIN clients c on ia.IAId = c.IAId
WHERE c.IAId IS NULL;

-- 33. Business Question: Show all banking relationship types and their client counts.
SELECT br.*, COUNT(c.BRId) AS client_count
FROM banking_relationships br
LEFT JOIN clients c ON br.BRId = c.BRId
GROUP BY br.BRId;

-- 34. Business Question: Which banking relationship types have no clients?
SELECT br.*
FROM banking_relationships br
LEFT JOIN clients c ON br.BRId = c.BRId
WHERE c.BRId IS NULL;

-- 35. Business Question: Show client count for each gender category.
SELECT g.*, COUNT(c.GenderId) AS client_count
FROM gender g
LEFT JOIN clients c ON g.GenderId = c.GenderId
GROUP BY g.GenderId;

-- 36. Business Question: Show all advisors with client counts by gender (including advisors with no clients).
SELECT 
    ia.IAId, 
    g.GenderId, 
    COUNT(c.Client_ID) AS client_count
FROM investment_advisors ia
LEFT JOIN clients c ON ia.IAId = c.IAId
LEFT JOIN gender g ON c.GenderId = g.GenderId
GROUP BY ia.IAId, g.GenderId;

-- 37. Business Question: Show advisors with client count, displaying 0 for those with no clients.
SELECT 
    ia.IAId, 
    COUNT(c.Client_Id) AS client_count
FROM investment_advisors ia
LEFT JOIN clients c ON ia.IAId = c.IAId
GROUP BY ia.IAId;

-- 38. Business Question: What percentage of banking relationships are actually being used?
SELECT 
    COUNT(DISTINCT br.BRId) AS total_relationships,
    COUNT(DISTINCT c.BRId) AS used_relationships,
    (COUNT(DISTINCT c.BRId) * 100.0 / NULLIF(COUNT(DISTINCT br.BRId), 0)) 
        AS usage_percentage
FROM banking_relationships br
LEFT JOIN clients c 
    ON br.BRId = c.BRId;
    
-- 39. Business Question: Show which advisor-gender combinations have no clients.
SELECT 
    ia.IAId, 
    g.GenderId
FROM investment_advisors ia
CROSS JOIN gender g
LEFT JOIN clients c 
    ON ia.IAId = c.IAId 
    AND g.GenderId = c.GenderId
GROUP BY ia.IAId, g.GenderId
HAVING COUNT(c.Client_Id) = 0;

-- 40. Business Question: Show advisors with their male and female client counts separately.
SELECT 
    ia.IAId,
    SUM(CASE WHEN g.GenderId = 1 THEN 1 ELSE 0 END) AS male_clients,
    SUM(CASE WHEN g.GenderId = 2 THEN 1 ELSE 0 END) AS female_clients
FROM investment_advisors ia
LEFT JOIN clients c 
    ON ia.IAId = c.IAId
LEFT JOIN gender g 
    ON c.GenderId = g.GenderId
GROUP BY ia.IAId;

-- ================================
-- SECTION 5: RIGHT / FULL JOIN (41–45)
-- ================================

-- 41. Business Question: Show all clients with their advisor information (client-centric view).
SELECT c.*, ia.*
FROM investment_advisors ia
RIGHT JOIN clients c
    ON c.IAId = ia.IAId;
    
-- 42. Business Question: Find clients whose advisor ID doesn't exist in the advisors table.
SELECT c.*
FROM investment_advisors ia
RIGHT JOIN clients c
    ON c.IAId = ia.IAId
WHERE ia.IAId IS NULL;

-- 43. Business Question: Show all advisors and all clients, whether matched or not.
SELECT c.*, ia.*
FROM clients c
LEFT JOIN investment_advisors ia 
    ON c.IAId = ia.IAId

UNION

SELECT c.*, ia.*
FROM clients c
RIGHT JOIN investment_advisors ia 
    ON c.IAId = ia.IAId;

-- 44. Business Question: Show complete mapping of banking relationships and clients.
SELECT br.*, c.*
FROM banking_relationships br
LEFT JOIN clients c 
    ON br.BRId = c.BRId

UNION

SELECT br.*, c.*
FROM banking_relationships br
RIGHT JOIN clients c 
    ON br.BRId = c.BRId;

-- 45. Business Question: For each client, show how many other clients share the same advisor.
SELECT 
    c1.Client_ID,
    c1.IAId,
    COUNT(c2.Client_ID) - 1 AS other_clients_with_same_advisor
FROM clients c1
JOIN clients c2 
    ON c1.IAId = c2.IAId
GROUP BY c1.Client_ID, c1.IAId;

-- ================================
-- SECTION 6: Subqueries (46–55)
-- ================================

-- 46. Business Question: Show clients whose advisor manages more clients than average.
SELECT c.*
FROM clients c
WHERE (
    SELECT COUNT(*) 
    FROM clients c2 
    WHERE c2.IAId = c.IAId
) > (
    SELECT AVG(client_count)
    FROM (
        SELECT COUNT(*) AS client_count
        FROM clients
        GROUP BY IAId
    ) t
);

-- 47. Business Question: Which banking relationship type has the most clients?
SELECT br.BRId,
       (SELECT COUNT(*) FROM clients c WHERE c.BRId = br.BRId) AS client_count
FROM banking_relationships br
ORDER BY client_count DESC
LIMIT 1;

-- 48. Business Question: Which advisors manage more clients than the average?
SELECT IAId, COUNT(*) AS client_count
FROM clients
GROUP BY IAId
HAVING COUNT(*) > (
    SELECT AVG(client_count)
    FROM (
        SELECT COUNT(*) AS client_count
        FROM clients
        GROUP BY IAId
    ) t
);

-- 49. Business Question: Show each gender's percentage of total clients.
SELECT 
    GenderId,
    COUNT(*) AS gender_count,
    ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM clients)),2) AS percentage
FROM clients
GROUP BY GenderId;

-- 50. Business Question: Show clients who work with the advisor that has the most clients.
SELECT c.*
FROM clients c
WHERE c.IAId IN (
    SELECT IAId
    FROM clients
    GROUP BY IAId
    HAVING COUNT(*) = (
        SELECT MAX(cnt)
        FROM (
            SELECT COUNT(*) AS cnt
            FROM clients
            GROUP BY IAId
        ) t
    )
);
	

-- ================================
-- SECTION 7: IN / EXISTS (56–65)
-- ================================

-- 56. Business Question: Show clients whose advisors exist in the advisor table.
SELECT *
FROM clients c
WHERE c.IAId IN (SELECT IAId FROM investment_advisors);

-- 57. Business Question: Which advisors have at least one client?
SELECT *
FROM investment_advisors ia
WHERE EXISTS (SELECT Name FROM clients c WHERE c.IAId = ia.IAId);

-- 58. Business Question: Show banking relationship types that are being used.
SELECT *
FROM banking_relationships br
WHERE br.BRId IN (SELECT DISTINCT BRId FROM clients);

-- 59. Business Question: Show clients whose gender is not in a specific subset.
SELECT *
FROM clients
WHERE GenderId NOT IN (1, 3);

-- 60. Business Question: Which advisors have no clients assigned?
SELECT *
FROM investment_advisors ia
WHERE NOT EXISTS (SELECT name FROM clients c WHERE c.IAId = ia.IAId);

-- 61. Business Question: Show all clients who share an advisor with Client_Id = 'IND95683'.
SELECT *
FROM clients c
WHERE c.IAId IN (
    SELECT IAId FROM clients WHERE Client_Id = 'IND95683'
)
AND c.Client_Id != 'IND95683';

-- 62. Business Question: Show all clients belonging to the most populous gender.
SELECT *
FROM clients c
WHERE c.GenderId IN (
    SELECT GenderId
    FROM (
        SELECT GenderId
        FROM clients
        GROUP BY GenderId
        ORDER BY COUNT(*) DESC
        LIMIT 1
    ) AS top_gender
);

-- 63. Business Question: Clients with popular advisors AND popular banking relationships.
SELECT *
FROM clients c
WHERE c.IAId IN (
    SELECT IAId FROM clients GROUP BY IAId HAVING COUNT(*) > 150
)
AND c.BRId IN (
    SELECT BRId FROM clients GROUP BY BRId HAVING COUNT(*) > 500
);

-- 64. Business Question: Advisors managing clients of all genders.
SELECT DISTINCT ia.*
FROM investment_advisors ia
WHERE EXISTS (
    SELECT * FROM clients c 
    WHERE c.IAId = ia.IAId AND c.GenderId = 1
)
AND EXISTS (
    SELECT * FROM clients c 
    WHERE c.IAId = ia.IAId AND c.GenderId = 2
);

-- 65. Business Question: Advisors who don't manage any male clients.
SELECT *
FROM investment_advisors ia
WHERE NOT EXISTS (
    SELECT * FROM clients c 
    WHERE c.IAId = ia.IAId AND c.GenderId = 1
);

-- ================================
-- SECTION 8: CTEs (66–75)
-- ================================

-- 66. Business Question: Summarize clients per advisor using a CTE.
WITH AdvisorSummary AS (
    SELECT IAId, COUNT(*) AS client_count
    FROM clients
    GROUP BY IAId
)
SELECT ia.*, COALESCE(acs.client_count, 0) AS client_count
FROM investment_advisors ia
LEFT JOIN AdvisorSummary acs 
    ON ia.IAId = acs.IAId;
    
-- 67. Business Question: Compare advisor and banking relationship popularity.
WITH AdvisorStats AS (
    SELECT IAId, COUNT(*) AS client_count
    FROM clients
    GROUP BY IAId
),
BankingStats AS (
    SELECT BRId, COUNT(*) AS client_count
    FROM clients
    GROUP BY BRId
)
SELECT 
    AVG(a.client_count) AS avg_per_advisor,
    AVG(b.client_count) AS avg_per_banking_type
FROM AdvisorStats a
CROSS JOIN BankingStats b;

-- 68. Business Question: Show advisors with above-average client counts.
WITH AdvisorCounts AS (
    SELECT IAId, COUNT(*) AS client_count
    FROM clients
    GROUP BY IAId
),
AvgCount AS (
    SELECT AVG(client_count) AS avg_clients
    FROM AdvisorCounts
)
SELECT 
    ia.IAId,
    ia.`Investment Advisor`,
    ac.client_count
FROM AdvisorCounts ac
JOIN investment_advisors ia 
    ON ac.IAId = ia.IAId
CROSS JOIN AvgCount avg
WHERE ac.client_count > avg.avg_clients;

-- 69. Business Question: Calculate market share for each advisor.
WITH AdvisorClients AS (
    SELECT IAId, COUNT(*) AS client_count
    FROM clients
    GROUP BY IAId
),
TotalClients AS (
    SELECT COUNT(*) AS total
    FROM clients
)
SELECT 
    ac.IAId,
    ac.client_count,
    tc.total,
    ROUND(ac.client_count * 100.0 / NULLIF(tc.total, 0), 2) AS market_share_pct
FROM AdvisorClients ac
CROSS JOIN TotalClients tc
ORDER BY market_share_pct DESC;

-- 70. Business Question: Rank advisors by client count and show top 5.
WITH AdvisorCounts AS (
    SELECT IAId, COUNT(*) AS client_count
    FROM clients
    GROUP BY IAId
),
RankedAdvisors AS (
    SELECT 
        IAId,
        client_count,
        ROW_NUMBER() OVER (ORDER BY client_count DESC) AS rank_num
    FROM AdvisorCounts
)
SELECT 
    ra.rank_num,
    ia.IAId,
    ia.`Investment Advisor`,
    ra.client_count
FROM RankedAdvisors ra
JOIN investment_advisors ia 
    ON ra.IAId = ia.IAId
WHERE ra.rank_num <= 5
ORDER BY ra.rank_num;

-- 71. Business Question: Create a pivot-like view of gender distribution per advisor.
WITH GenderByAdvisor AS (
    SELECT 
        IAId,
        GenderId,
        COUNT(*) AS client_count
    FROM clients
    GROUP BY IAId, GenderId
)
SELECT 
    IAId,
    SUM(CASE WHEN GenderId = 1 THEN client_count ELSE 0 END) AS male_clients,
    SUM(CASE WHEN GenderId = 2 THEN client_count ELSE 0 END) AS female_clients,
    SUM(client_count) AS total_clients
FROM GenderByAdvisor
GROUP BY IAId;

-- 72. Business Question: Show advisor performance tiers.
WITH AdvisorPerformance AS (
    SELECT 
        IAId, 
        COUNT(*) AS client_count,
        CASE 
            WHEN COUNT(*) >= 20 THEN 'High Performer'
            WHEN COUNT(*) >= 10 THEN 'Medium Performer'
            ELSE 'Low Performer'
        END AS performance_tier
    FROM clients
    GROUP BY IAId
)
SELECT 
    performance_tier,
    COUNT(*) AS advisor_count,
    AVG(client_count) AS avg_clients
FROM AdvisorPerformance
GROUP BY performance_tier;

-- 73. Business Question: Average clients per advisor, excluding advisors with less than 5 clients.
WITH QualifiedAdvisors AS (
    SELECT IAId, COUNT(*) AS client_count
    FROM clients
    GROUP BY IAId
    HAVING COUNT(*) >= 5
)
SELECT 
    COUNT(*) AS qualified_advisor_count,
    AVG(client_count) AS avg_clients,
    MIN(client_count) AS min_clients,
    MAX(client_count) AS max_clients
FROM QualifiedAdvisors;

-- 74. Business Question: Find advisors who manage clients with all available banking relationship types.
WITH AdvisorBankingTypes AS (
    SELECT IAId, COUNT(DISTINCT BRId) AS banking_types
    FROM clients
    GROUP BY IAId
),
TotalBankingTypes AS (
    SELECT COUNT(DISTINCT BRId) AS total_types
    FROM banking_relationships
)
SELECT abt.IAId, abt.banking_types
FROM AdvisorBankingTypes abt
CROSS JOIN TotalBankingTypes tbt
WHERE abt.banking_types = tbt.total_types;

-- 75. Business Question: Calculate cumulative client distribution across advisors.
WITH AdvisorCounts AS (
    SELECT IAId, COUNT(*) AS client_count
    FROM clients
    GROUP BY IAId
),
SortedAdvisors AS (
    SELECT 
        IAId,
        client_count,
        ROW_NUMBER() OVER (ORDER BY client_count DESC) AS position
    FROM AdvisorCounts
),
CumulativeData AS (
    SELECT 
        IAId,
        client_count,
        position,
        SUM(client_count) OVER (ORDER BY position) AS cumulative_clients,
        SUM(client_count) OVER () AS total_clients
    FROM SortedAdvisors
)
SELECT 
    IAId,
    client_count,
    position,
    cumulative_clients,
    ROUND(cumulative_clients * 100.0 / total_clients, 2) AS cumulative_percentage
FROM CumulativeData
ORDER BY cumulative_percentage  DESC;


-- ================================
-- SECTION 9: Window Ranking (76–85)
-- ================================

-- 76. Business Question: Assign unique ranks to advisors by number of clients.
WITH advisor_counts AS (
    SELECT IAId, COUNT(*) AS client_count
    FROM clients
    GROUP BY IAId
)
SELECT 
    IAId,
    client_count,
    ROW_NUMBER() OVER (ORDER BY client_count DESC) AS row_num
FROM advisor_counts;

-- 77. Business Question: Rank advisors allowing ties for same client counts.
WITH advisor_counts AS (
    SELECT IAId, COUNT(*) AS client_count
    FROM clients
    GROUP BY IAId
)
SELECT 
    IAId,
    client_count,
    RANK() OVER (ORDER BY client_count DESC) AS rank_with_gaps
FROM advisor_counts;

-- 78. Business Question: Rank advisors without gaps in ranking.
WITH advisor_counts AS (
    SELECT IAId, COUNT(*) AS client_count
    FROM clients
    GROUP BY IAId
)
SELECT 
    IAId,
    client_count,
    DENSE_RANK() OVER (ORDER BY client_count DESC) AS Rank_dense
FROM advisor_counts;

-- 79. Business Question: Divide advisors into quartiles based on client count.
WITH advisor_counts AS (
    SELECT IAId, COUNT(*) AS client_count
    FROM clients
    GROUP BY IAId
)
SELECT 
    IAId,
    client_count,
    NTILE(4) OVER (ORDER BY client_count DESC) AS quartile
FROM advisor_counts;

-- 80. Business Question: Rank clients within each advisor group.
SELECT 
    BRId,
    IAId,
    GenderId,
    ROW_NUMBER() OVER (PARTITION BY IAId ORDER BY BRId) AS client_rank_within_advisor
FROM clients;

-- 81. Business Question: Show various rankings for advisors simultaneously.
WITH advisor_counts AS (
    SELECT IAId, COUNT(*) AS client_count
    FROM clients
    GROUP BY IAId
)
SELECT 
    IAId,
    client_count,
    ROW_NUMBER() OVER (ORDER BY client_count DESC) AS row_num,
    RANK() OVER (ORDER BY client_count DESC) AS rank_num,
    DENSE_RANK() OVER (ORDER BY client_count DESC) AS dense_rankk,
    NTILE(3) OVER (ORDER BY client_count DESC) AS ntilee
FROM advisor_counts;

-- 82. Business Question: Rank banking relationships within each gender.
WITH gender_counts AS (
    SELECT 
        GenderId,
        BRId,
        COUNT(*) AS client_count
    FROM clients
    GROUP BY GenderId, BRId
)
SELECT 
    GenderId,
    BRId,
    client_count,
    RANK() OVER (
        PARTITION BY GenderId 
        ORDER BY client_count DESC
    ) AS rank_within_gender
FROM gender_counts;

-- 83. Business Question: Calculate percentile rank for each advisor.
WITH advisor_counts AS (
    SELECT IAId, COUNT(*) AS client_count
    FROM clients
    GROUP BY IAId
)
SELECT 
    IAId,
    client_count,
    PERCENT_RANK() OVER (ORDER BY client_count) AS percentile_rank
FROM advisor_counts;

-- 84. Business Question: Show cumulative distribution of advisor client counts.
WITH advisor_counts AS (
    SELECT IAId, COUNT(*) AS client_count
    FROM clients
    GROUP BY IAId
)
SELECT 
    IAId,
    client_count,
    CUME_DIST() OVER (ORDER BY client_count) AS cumulative_distribution
FROM advisor_counts;

-- 85. Business Question: Rank advisors within each client count tier.
WITH advisor_tiers AS (
    SELECT 
        IAId,
        COUNT(*) AS client_count,
        CASE 
            WHEN COUNT(*) >= 170 THEN 'Tier 1'
            WHEN COUNT(*) >= 85 THEN 'Tier 2'
            ELSE 'Tier 3'
        END AS tier
    FROM clients
    GROUP BY IAId
)
SELECT 
    tier,
    IAId,
    client_count,
    RANK() OVER (
        PARTITION BY tier 
        ORDER BY client_count DESC
    ) AS rank_within_tier
FROM advisor_tiers;
-- 82. Business Question: Rank banking relationships within each gender.
WITH gender_counts AS (
    SELECT 
        GenderId,
        BRId,
        COUNT(*) AS client_count
    FROM clients
    GROUP BY GenderId, BRId
)
SELECT 
    GenderId,
    BRId,
    client_count,
    RANK() OVER (
        PARTITION BY GenderId 
        ORDER BY client_count DESC
    ) AS rank_within_gender
FROM gender_counts;

-- 83. Business Question: Calculate percentile rank for each advisor.
WITH advisor_counts AS (
    SELECT IAId, COUNT(*) AS client_count
    FROM clients
    GROUP BY IAId
)
SELECT 
    IAId,
    client_count,
    PERCENT_RANK() OVER (ORDER BY client_count) AS percentile_rank
FROM advisor_counts;

-- 84. Business Question: Show cumulative distribution of advisor client counts.
WITH advisor_counts AS (
    SELECT IAId, COUNT(*) AS client_count
    FROM clients
    GROUP BY IAId
)
SELECT 
    IAId,
    client_count,
    CUME_DIST() OVER (ORDER BY client_count) AS cumulative_distribution
FROM advisor_counts;

-- 85. Business Question: Rank advisors within each client count tier.
WITH advisor_tiers AS (
    SELECT 
        IAId,
        COUNT(*) AS client_count,
        CASE 
            WHEN COUNT(*) >= 170 THEN 'Tier 1'
            WHEN COUNT(*) >= 85 THEN 'Tier 2'
            ELSE 'Tier 3'
        END AS tier
    FROM clients
    GROUP BY IAId
)
SELECT 
    tier,
    IAId,
    client_count,
    RANK() OVER (
        PARTITION BY tier 
        ORDER BY client_count DESC
    ) AS rank_within_tier
FROM advisor_tiers;

-- ================================
-- SECTION 10: Analytical Windows (86–95)
-- ================================

-- 86. Business Question: Show each advisor's client count compared to the previous advisor.
SELECT 
    IAId,
    client_count,
    LAG(client_count) OVER (ORDER BY client_count DESC) AS prev_advisor_count,
    client_count - LAG(client_count) OVER (ORDER BY client_count DESC) AS difference_from_prev
FROM (
    SELECT IAId, COUNT(*) AS client_count
    FROM clients
    GROUP BY IAId
) t;

-- 87. Business Question: Show each advisor's client count compared to the next advisor.
SELECT 
    IAId,
    client_count,
    LEAD(client_count) OVER (ORDER BY client_count DESC) AS next_advisor_count,
    client_count - LEAD(client_count) OVER (ORDER BY client_count DESC) AS difference_from_next
FROM (
    SELECT IAId, COUNT(*) AS client_count
    FROM clients
    GROUP BY IAId
) t;

-- 88. Business Question: For each gender, show the most popular banking relationship.
SELECT DISTINCT
    GenderId,
    FIRST_VALUE(BRId) OVER (
        PARTITION BY GenderId 
        ORDER BY usage_count DESC
    ) AS most_popular_banking
FROM (
    SELECT GenderId, BRId, COUNT(*) AS usage_count
    FROM clients
    GROUP BY GenderId, BRId
) t;

-- 89. Business Question: Show the least popular banking relationship per gender.
SELECT DISTINCT
    GenderId,
    LAST_VALUE(BRId) OVER (
        PARTITION BY GenderId 
        ORDER BY usage_count DESC
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS least_popular_banking
FROM (
    SELECT GenderId, BRId, COUNT(*) AS usage_count
    FROM clients
    GROUP BY GenderId, BRId
) t;

-- 90. Business Question: Calculate running total of clients by advisor.
SELECT 
    IAId,
    client_count,
    SUM(client_count) OVER (
        ORDER BY IAId 
        -- ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total_clients
FROM (
    SELECT IAId, COUNT(*) AS client_count
    FROM clients
    GROUP BY IAId
) t;

-- 91. Business Question: Calculate 3-advisor moving average of client counts.
SELECT 
    IAId,
    client_count,
    AVG(client_count) OVER (
        ORDER BY IAId 
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ) AS moving_avg_3
FROM (
    SELECT IAId, COUNT(*) AS client_count
    FROM clients
    GROUP BY IAId
) t;

-- 92. Business Question: Running total of clients by banking relationship within each gender.
SELECT 
    GenderId,
    BRId,
    client_count,
    SUM(client_count) OVER (
        PARTITION BY GenderId 
        ORDER BY BRId 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total_within_gender
FROM (
    SELECT GenderId, BRId, COUNT(*) AS client_count
    FROM clients
    GROUP BY GenderId, BRId
) t;

-- 93. Business Question: What percentage of total clients does each advisor manage?
SELECT 
    IAId,
    client_count,
    client_count * 100.0 / SUM(client_count) OVER () AS percentage_of_total
FROM (
    SELECT IAId, COUNT(*) AS client_count
    FROM clients
    GROUP BY IAId
) t;

-- 94. Business Question: Show how each advisor's client count differs from the average.
SELECT 
    IAId,
    client_count,
    AVG(client_count) OVER () AS avg_clients,
    client_count - AVG(client_count) OVER () AS difference_from_avg
FROM (
    SELECT IAId, COUNT(*) AS client_count
    FROM clients
    GROUP BY IAId
) t;

-- 95. Business Question: Calculate clients in current and next 2 advisors.
SELECT 
    IAId,
    client_count,
    SUM(client_count) OVER (
        ORDER BY IAId 
        ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING
    ) AS clients_next_3_advisors
FROM (
    SELECT IAId, COUNT(*) AS client_count
    FROM clients
    GROUP BY IAId
) t;

-- ================================
-- SECTION 11: CASE (96–100)
-- ================================

-- 96. Business Question: Categorize advisors by portfolio size.
SELECT 
    IAId,
    COUNT(*) AS client_count,
    CASE 
        WHEN COUNT(*) >= 150 THEN 'Large Portfolio'
        WHEN COUNT(*) >= 80 THEN 'Medium Portfolio'
        WHEN COUNT(*) >= 50 THEN 'Small Portfolio'
        ELSE 'Very Small Portfolio'
    END AS portfolio_category
FROM clients
GROUP BY IAId;

-- 97. Business Question: Count clients by gender and banking relationship tier.
SELECT 
    GenderId,
    SUM(CASE WHEN BRId IN (1, 2) THEN 1 ELSE 0 END) AS tier_1_banking,
    SUM(CASE WHEN BRId IN (3, 4) THEN 1 ELSE 0 END) AS tier_2_banking,
    SUM(CASE WHEN BRId >= 5 THEN 1 ELSE 0 END) AS tier_3_banking,
    COUNT(*) AS total_clients
FROM clients
GROUP BY GenderId;

-- 98. Business Question: Create complex advisor performance scoring.
SELECT 
    IAId,
    COUNT(*) AS client_count,
    COUNT(DISTINCT GenderId) AS gender_diversity,
    COUNT(DISTINCT BRId) AS banking_diversity,
    CASE 
        WHEN COUNT(*) >= 150 THEN
            CASE 
                WHEN COUNT(DISTINCT BRId) >= 150 THEN 'Elite'
                ELSE 'High Performer'
            END
        WHEN COUNT(*) >= 180 THEN
            CASE 
                WHEN COUNT(DISTINCT GenderId) >= 2 THEN 'Balanced'
                ELSE 'Moderate'
            END
        ELSE 'Developing'
    END AS advisor_grade
FROM clients
GROUP BY IAId;

-- 99. Business Question: Flag advisors above or below median performance.
SELECT 
    IAId,
    client_count,
    NTILE(4) OVER (ORDER BY client_count) AS quartile,
    CASE 
        WHEN NTILE(4) OVER (ORDER BY client_count) = 4 THEN 'Top Quartile'
        WHEN NTILE(4) OVER (ORDER BY client_count) = 3 THEN 'Above Median'
        WHEN NTILE(4) OVER (ORDER BY client_count) = 2 THEN 'Below Median'
        ELSE 'Bottom Quartile'
    END AS performance_bracket
FROM (
    SELECT IAId, COUNT(*) AS client_count
    FROM clients
    GROUP BY IAId
) t;

-- 100. Business Question: Identify potential data quality issues in client records.
SELECT 
    IAId,
    GenderId,
    BRId,
    CASE 
        WHEN IAId IS NULL THEN 'Missing Advisor'
        WHEN GenderId IS NULL THEN 'Missing Gender'
        WHEN BRId IS NULL THEN 'Missing Banking Relationship'
        WHEN NOT EXISTS (
            SELECT 1 FROM investment_advisors ia WHERE ia.IAId = clients.IAId
        ) THEN 'Invalid Advisor Reference'
        WHEN NOT EXISTS (
            SELECT 1 FROM gender g WHERE g.GenderId = clients.GenderId
        ) THEN 'Invalid Gender Reference'
        WHEN NOT EXISTS (
            SELECT 1 FROM banking_relationships br WHERE br.BRId = clients.BRId
        ) THEN 'Invalid Banking Reference'
        ELSE 'Valid'
    END AS data_quality_status
FROM clients;

-- ================================
-- SECTION 12: UNION (101–105)
-- ================================

-- 101. Business Question: List all unique IDs across advisors and banking relationships.
SELECT IAId AS id, 'Advisor' AS source
FROM investment_advisors
UNION
SELECT BRId AS id, 'Banking Relationship' AS source
FROM banking_relationships;

-- 102. Business Question: Create a full audit trail of all ID assignments.
SELECT BRId AS client_id, IAId AS assigned_id, 'Advisor Assignment' AS assignment_type
FROM clients
UNION ALL
SELECT BRId AS client_id, BRId AS assigned_id, 'Banking Assignment' AS assignment_type
FROM clients
UNION ALL
SELECT BRId AS client_id, GenderId AS assigned_id, 'Gender Assignment' AS assignment_type
FROM clients;

-- 103. Business Question: Compare counts across different dimensions.
SELECT 'Advisors' AS category, COUNT(*) AS count
FROM investment_advisors
UNION
SELECT 'Banking Relationships' AS category, COUNT(*) AS count
FROM banking_relationships
UNION
SELECT 'Gender Categories' AS category, COUNT(*) AS count
FROM gender
UNION
SELECT 'Total Clients' AS category, COUNT(*) AS count
FROM clients;

-- 104. Business Question: Identify high-value entities across categories.
SELECT IAId AS entity_id, 'High-Value Advisor' AS category, COUNT(*) AS client_count
FROM clients
GROUP BY IAId
HAVING COUNT(*) > 100

UNION

SELECT BRId AS entity_id, 'Popular Banking Type' AS category, COUNT(*) AS client_count
FROM clients
GROUP BY BRId
HAVING COUNT(*) > 500

ORDER BY client_count DESC;

-- 105. Business Question: Create comprehensive summary report.
WITH AdvisorMetrics AS (
    SELECT 'Advisor' AS metric_type, IAId AS id, COUNT(*) AS value
    FROM clients
    GROUP BY IAId
),
BankingMetrics AS (
    SELECT 'Banking' AS metric_type, BRId AS id, COUNT(*) AS value
    FROM clients
    GROUP BY BRId
)
SELECT * FROM AdvisorMetrics
WHERE value > 10
UNION
SELECT * FROM BankingMetrics
WHERE value > 20
ORDER BY metric_type, value DESC;

-- ================================
-- SECTION 13: Aggregations (106–110)
-- ================================

-- 106. Business Question: Show client counts with subtotals by gender and advisor.
SELECT 
    COALESCE(GenderId, 999) AS GenderId,
    COALESCE(IAId, 999) AS IAId,
    COUNT(*) AS client_count
FROM clients
GROUP BY GenderId, IAId WITH ROLLUP;

-- 107. Business Question: Analyze clients by multiple dimension combinations.
SELECT GenderId, IAId, NULL AS BRId, COUNT(*) AS client_count,
       0 AS g_gender, 0 AS g_advisor, 1 AS g_banking
FROM clients
GROUP BY GenderId, IAId

UNION ALL

SELECT GenderId, NULL AS IAId, BRId, COUNT(*) AS client_count,
       0 AS g_gender, 1 AS g_advisor, 0 AS g_banking
FROM clients
GROUP BY GenderId, BRId

UNION ALL

SELECT NULL AS GenderId, IAId, BRId, COUNT(*) AS client_count,
       1 AS g_gender, 0 AS g_advisor, 0 AS g_banking
FROM clients
GROUP BY IAId, BRId

UNION ALL

SELECT NULL, NULL, NULL, COUNT(*) AS client_count,
       1, 1, 1
FROM clients;

-- 108. Business Question: Calculate comprehensive statistics for advisor client distribution.
WITH AdvisorCounts AS (
    SELECT IAId, COUNT(*) AS client_count
    FROM clients
    GROUP BY IAId
)
SELECT 
    COUNT(*) AS total_advisors,
    AVG(client_count) AS mean_clients,
    MIN(client_count) AS min_clients,
    MAX(client_count) AS max_clients,
    STDDEV(client_count) AS stddev_clients,
    VARIANCE(client_count) AS variance_clients
FROM AdvisorCounts;

-- 109. Business Question: Count clients meeting various criteria for each advisor.
SELECT 
    IAId,
    COUNT(*) AS total_clients,
    COUNT(CASE WHEN GenderId = 1 THEN 1 END) AS male_clients,
    COUNT(CASE WHEN GenderId = 2 THEN 1 END) AS female_clients,
    COUNT(CASE WHEN BRId IN (1, 2, 3) THEN 1 END) AS premium_banking,
    COUNT(DISTINCT BRId) AS banking_diversity,
    COUNT(DISTINCT GenderId) AS gender_diversity
FROM clients
GROUP BY IAId;

-- 110. Business Question: Calculate concentration ratios and diversity metrics.
WITH AdvisorStats AS (
    SELECT 
        IAId,
        COUNT(*) AS client_count,
        COUNT(DISTINCT GenderId) AS gender_count,
        COUNT(DISTINCT BRId) AS banking_count
    FROM clients
    GROUP BY IAId
),
TotalClients AS (
    SELECT COUNT(*) AS total FROM clients
),
TotalGenders AS (
    SELECT COUNT(*) AS total FROM gender
),
TotalBanking AS (
    SELECT COUNT(*) AS total FROM banking_relationships
)
SELECT 
    ast.IAId,
    ast.client_count,
    ast.client_count * 100.0 / tc.total AS market_share_pct,
    ast.gender_count * 100.0 / tg.total AS gender_coverage_pct,
    ast.banking_count * 100.0 / tb.total AS banking_coverage_pct,
    (ast.gender_count + ast.banking_count) / 2.0 AS diversity_score
FROM AdvisorStats ast
CROSS JOIN TotalClients tc
CROSS JOIN TotalGenders tg
CROSS JOIN TotalBanking tb;

-- ================================
-- SECTION 14: Recursive (111–112)
-- ================================

-- 111. Business Question: Generate a series to identify gaps in advisor IDs.
WITH RECURSIVE NumberSeries AS (
    SELECT 1 AS num
    UNION ALL
    SELECT num + 1
    FROM NumberSeries
    WHERE num < (SELECT MAX(IAId) FROM investment_advisors)
)
SELECT ns.num AS missing_advisor_id
FROM NumberSeries ns
LEFT JOIN investment_advisors ia 
    ON ns.num = ia.IAId
WHERE ia.IAId IS NULL;

-- 112. Business Question: Simulate organizational hierarchy depth.
WITH RECURSIVE AdvisorHierarchy AS (
    SELECT IAId, 1 AS level
    FROM investment_advisors
    WHERE IAId <= 5

    UNION ALL

    SELECT IAId, level + 1
    FROM AdvisorHierarchy
    WHERE level < 3
)
SELECT IAId, MAX(level) AS max_depth
FROM AdvisorHierarchy
GROUP BY IAId;

-- ================================
-- SECTION 15: Business Scenarios (113–120)
-- ================================

-- 113. Business Question: Segment clients into strategic categories based on multiple factors.
WITH AdvisorCounts AS (
    SELECT IAId, COUNT(*) AS advisor_client_count
    FROM clients
    GROUP BY IAId
),
BankingCounts AS (
    SELECT BRId, COUNT(*) AS banking_popularity
    FROM clients
    GROUP BY BRId
)
SELECT 
    c.BRId,
    c.GenderId,
    c.IAId,
    ac.advisor_client_count,
    bc.banking_popularity,
    CASE 
        WHEN ac.advisor_client_count > 170 AND bc.banking_popularity > 400 THEN 'Premium High-Demand'
        WHEN ac.advisor_client_count > 88 THEN 'Premium Niche'
        WHEN bc.banking_popularity > 80 THEN 'Standard High-Demand'
        ELSE 'Standard'
    END AS client_segment
FROM clients c
JOIN AdvisorCounts ac ON c.IAId = ac.IAId
JOIN BankingCounts bc ON c.BRId = bc.BRId;

-- 114. Business Question: Analyze client distribution patterns.
WITH AdvisorCohorts AS (
    SELECT 
        IAId,
        NTILE(5) OVER (ORDER BY IAId) AS advisor_cohort,
        COUNT(*) AS client_count
    FROM clients
    GROUP BY IAId
)
SELECT 
    advisor_cohort,
    COUNT(*) AS advisors_in_cohort,
    AVG(client_count) AS avg_clients,
    SUM(client_count) AS total_clients,
    SUM(client_count) * 100.0 / SUM(SUM(client_count)) OVER () AS pct_of_total_clients
FROM AdvisorCohorts
GROUP BY advisor_cohort
ORDER BY advisor_cohort;

-- 115. Business Question: Which advisor-gender-banking combinations exist and which don't?
WITH AllCombinations AS (
    SELECT ia.IAId, g.GenderId, br.BRId
    FROM investment_advisors ia
    CROSS JOIN gender g
    CROSS JOIN banking_relationships br
),
ActualCombinations AS (
    SELECT IAId, GenderId, BRId, COUNT(*) AS client_count
    FROM clients
    GROUP BY IAId, GenderId, BRId
)
SELECT 
    ac.IAId,
    ac.GenderId,
    ac.BRId,
    COALESCE(act.client_count, 0) AS clients,
    CASE 
        WHEN act.client_count IS NULL THEN 'Gap' 
        ELSE 'Covered' 
    END AS status
FROM AllCombinations ac
LEFT JOIN ActualCombinations act
    ON ac.IAId = act.IAId
    AND ac.GenderId = act.GenderId
    AND ac.BRId = act.BRId
ORDER BY ac.IAId, ac.GenderId, ac.BRId;

-- 116. Business Question: Identify concentration risks in client distribution.

-- 117. Business Question: Compare each advisor against peer groups.

-- 118. Business Question: Identify underserved segments and opportunity areas.

-- 119. Business Question: Analyze variance in client distribution across all dimensions.

-- 120. Business Question: Generate executive dashboard with key performance indicators.