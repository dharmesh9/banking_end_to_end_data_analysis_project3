USE finance;
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