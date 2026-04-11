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

-- 27. Business Question: Which advisors manage more than 10 clients?

-- 28. Business Question: Count clients by gender and banking relationship type.

-- 29. Business Question: Show clients with advisors, ordered by advisor ID.

-- 30. Business Question: Find clients who share the same advisor and gender.


-- ================================
-- SECTION 4: LEFT JOIN (31–40)
-- ================================

-- 31. Business Question: Show all advisors and how many clients they have (including those with no clients).

-- 32. Business Question: Which advisors have no clients assigned?

-- 33. Business Question: Show all banking relationship types and their client counts.

-- 34. Business Question: Which banking relationship types have no clients?

-- 35. Business Question: Show client count for each gender category.

-- 36. Business Question: Show all advisors with client counts by gender (including advisors with no clients).

-- 37. Business Question: Show advisors with client count, displaying 0 for those with no clients.

-- 38. Business Question: What percentage of banking relationships are actually being used?

-- 39. Business Question: Show which advisor-gender combinations have no clients.

-- 40. Business Question: Show advisors with their male and female client counts separately.


-- ================================
-- SECTION 5: RIGHT / FULL JOIN (41–45)
-- ================================

-- 41. Business Question: Show all clients with their advisor information (client-centric view).

-- 42. Business Question: Find clients whose advisor ID doesn't exist in the advisors table.

-- 43. Business Question: Show all advisors and all clients, whether matched or not.

-- 44. Business Question: Show complete mapping of banking relationships and clients.

-- 45. Business Question: For each client, show how many other clients share the same advisor.


-- ================================
-- SECTION 6: Subqueries (46–55)
-- ================================

-- 46. Business Question: Show clients whose advisor manages more clients than average.

-- 47. Business Question: Which banking relationship type has the most clients?

-- 48. Business Question: Which advisors manage more clients than the median?

-- 49. Business Question: Show each gender's percentage of total clients.

-- 50. Business Question: Show clients who work with the advisor that has the most clients.

-- 51. Business Question: Which banking relationships are used more than average?

-- 52. Business Question: Show clients belonging to the gender with fewer total clients.

-- 53. Business Question: Which advisors are in the top 25% by number of clients?

-- 54. Business Question: For each client, show how many clients their advisor manages.

-- 55. Business Question: Show banking relationships and their rank by popularity.


-- ================================
-- SECTION 7: IN / EXISTS (56–65)
-- ================================

-- 56. Business Question: Show clients whose advisors exist in the advisor table.

-- 57. Business Question: Which advisors have at least one client?

-- 58. Business Question: Show banking relationship types that are being used.

-- 59. Business Question: Show clients whose gender is not in a specific subset.

-- 60. Business Question: Which advisors have no clients assigned?

-- 61. Business Question: Show all clients who share an advisor with client BRId = 100.

-- 62. Business Question: Show all clients belonging to the most populous gender.

-- 63. Business Question: Clients with popular advisors AND popular banking relationships.

-- 64. Business Question: Advisors managing clients of all genders.

-- 65. Business Question: Advisors who don't manage any male clients.


-- ================================
-- SECTION 8: CTEs (66–75)
-- ================================

-- 66. Business Question: Summarize clients per advisor using a CTE.

-- 67. Business Question: Compare advisor and banking relationship popularity.

-- 68. Business Question: Show advisors with above-average client counts.

-- 69. Business Question: Calculate market share for each advisor.

-- 70. Business Question: Rank advisors by client count and show top 3.

-- 71. Business Question: Create a pivot-like view of gender distribution per advisor.

-- 72. Business Question: Show advisor performance tiers.

-- 73. Business Question: Average clients per advisor, excluding advisors with less than 5 clients.

-- 74. Business Question: Find advisors who manage clients with all available banking relationship types.

-- 75. Business Question: Calculate cumulative client distribution across advisors.


-- ================================
-- SECTION 9: Window Ranking (76–85)
-- ================================

-- 76. Business Question: Assign unique ranks to advisors by number of clients.

-- 77. Business Question: Rank advisors allowing ties for same client counts.

-- 78. Business Question: Rank advisors without gaps in ranking.

-- 79. Business Question: Divide advisors into quartiles based on client count.

-- 80. Business Question: Rank clients within each advisor group.

-- 81. Business Question: Show various rankings for advisors simultaneously.

-- 82. Business Question: Rank banking relationships within each gender.

-- 83. Business Question: Calculate percentile rank for each advisor.

-- 84. Business Question: Show cumulative distribution of advisor client counts.

-- 85. Business Question: Rank advisors within each client count tier.


-- ================================
-- SECTION 10: Analytical Windows (86–95)
-- ================================

-- 86. Business Question: Show each advisor's client count compared to the previous advisor.

-- 87. Business Question: Show each advisor's client count compared to the next advisor.

-- 88. Business Question: For each gender, show the most popular banking relationship.

-- 89. Business Question: Show the least popular banking relationship per gender.

-- 90. Business Question: Calculate running total of clients by advisor.

-- 91. Business Question: Calculate 3-advisor moving average of client counts.

-- 92. Business Question: Running total of clients by banking relationship within each gender.

-- 93. Business Question: What percentage of total clients does each advisor manage?

-- 94. Business Question: Show how each advisor's client count differs from the average.

-- 95. Business Question: Calculate clients in current and next 2 advisors.


-- ================================
-- SECTION 11: CASE (96–100)
-- ================================

-- 96. Business Question: Categorize advisors by portfolio size.

-- 97. Business Question: Count clients by gender and banking relationship tier.

-- 98. Business Question: Create complex advisor performance scoring.

-- 99. Business Question: Flag advisors above or below median performance.

-- 100. Business Question: Identify potential data quality issues in client records.


-- ================================
-- SECTION 12: UNION (101–105)
-- ================================

-- 101. Business Question: List all unique IDs across advisors and banking relationships.

-- 102. Business Question: Create a full audit trail of all ID assignments.

-- 103. Business Question: Compare counts across different dimensions.

-- 104. Business Question: Identify high-value entities across categories.

-- 105. Business Question: Create comprehensive summary report.


-- ================================
-- SECTION 13: Aggregations (106–110)
-- ================================

-- 106. Business Question: Show client counts with subtotals by gender and advisor.

-- 107. Business Question: Analyze clients by multiple dimension combinations.

-- 108. Business Question: Calculate comprehensive statistics for advisor client distribution.

-- 109. Business Question: Count clients meeting various criteria for each advisor.

-- 110. Business Question: Calculate concentration ratios and diversity metrics.


-- ================================
-- SECTION 14: Recursive (111–112)
-- ================================

-- 111. Business Question: Generate a series to identify gaps in advisor IDs.

-- 112. Business Question: Simulate organizational hierarchy depth.


-- ================================
-- SECTION 15: Business Scenarios (113–120)
-- ================================

-- 113. Business Question: Segment clients into strategic categories based on multiple factors.

-- 114. Business Question: Analyze client distribution patterns.

-- 115. Business Question: Which advisor-gender-banking combinations exist and which don't?

-- 116. Business Question: Identify concentration risks in client distribution.

-- 117. Business Question: Compare each advisor against peer groups.

-- 118. Business Question: Identify underserved segments and opportunity areas.

-- 119. Business Question: Analyze variance in client distribution across all dimensions.

-- 120. Business Question: Generate executive dashboard with key performance indicators.