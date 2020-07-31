/* Lesson 2 - SQL Joins */

/* Database Normalization
When creating a database, it is really important to think about how data will be stored. This is known as normalization, and it is a huge part of most SQL classes. If you are in charge of setting up a new database, it is important to have a thorough understanding of database normalization.

There are essentially three ideas that are aimed at database normalization:

Are the tables storing logical groupings of the data?
Can I make changes in a single location, rather than in many tables for the same information?
Can I access and manipulate data quickly and efficiently?
This is discussed in detail here.

However, most analysts are working with a database that was already set up with the necessary properties in place. As analysts of data, you don't really need to think too much about data normalization. You just need to be able to pull the data from the database, so you can start making insights. This will be our focus in this lesson. */

/* Joins */

SELECT orders.*
FROM orders
    JOIN accounts
    ON orders.account_id = accounts.id;

/* Quiz Questions
Try pulling all the data from the accounts table, and all the data from the orders table.

Try pulling standard_qty, gloss_qty, and poster_qty from the orders table, and the website and the primary_poc from the accounts table.
Another environment is below to practice these two questions, and you can check your solutions on the next concept. */

SELECT *
FROM orders
    JOIN accounts
    ON orders.account_id = accounts.id;

SELECT orders.standard_qty, orders.gloss_qty, orders.poster_qty, accounts.website, accounts.primary_poc
FROM orders
    JOIN accounts ON orders.account_id = accounts.id;

/* Keys
Primary Key (PK)
A primary key is a unique column in a particular table. This is the first column in each of our tables. Here, those columns are all called id, but that doesn't necessarily have to be the name. It is common that the primary key is the first column in our tables in most databases.

Foreign Key (FK)
A foreign key is a column in one table that is a primary key in a different table. We can see in the Parch & Posey ERD that the foreign keys are:

region_id
account_id
sales_rep_id
Each of these is linked to the primary key of another table. An example is shown in the image below:


Primary - Foreign Key Link
In the above image you can see that:

The region_id is the foreign key.
The region_id is linked to id - this is the primary-foreign key link that connects these two tables.
The crow's foot shows that the FK can actually appear in many rows in the sales_reps table.
While the single line is telling us that the PK shows that id appears only once per row in this table.
If you look through the rest of the database, you will notice this is always the case for a primary-foreign key relationship. In the next concept, you can make sure you have this down! 

Notice
Notice our
SQL query has the two tables we would like to join - one in the FROM and the other in the JOIN. Then in the ON, we will ALWAYs have the PK equal to the
FK:

The way we join any two tables is in this
way:
linking the PK and FK
(generally in an ON statement).

JOIN More than
Two Tables
This same logic can actually assist in joining more than two tables together. Look at the three tables below.


The Code
If we wanted to join all three of these tables, we could
use the
same logic. The code below pulls all of the data from all of the joined tables.

SELECT *
FROM web_events
    JOIN accounts
    ON web_events.account_id = accounts.id
    JOIN orders
    ON accounts.id = orders.account_id
Alternatively, we can
create a
SELECT statement that
could pull specific columns from any of the three tables. Again, our JOIN holds a table, and ON is a link for our PK to equal the FK.

To pull specific columns, the
SELECT statement will
need to specify the table that you are wishing to pull the column from, as well as the column name. We could pull only three columns in the above by changing the
select statement
to the below, but maintaining the rest of the JOIN
information:

SELECT web_events.channel, accounts.name, orders.total
We
could
continue
this same process to link all of the tables
if we wanted. For efficiency reasons, we probably don't want to do this unless we actually need information from all of the tables.
*/



/* Aliases
When we JOIN tables together, it is nice to give each table an alias. Frequently an alias is just the first letter of the table name. You actually saw something similar for column names in the Arithmetic Operators concept.

Example:

FROM tablename AS t1
JOIN tablename2 AS t2
Before, you saw something like:

SELECT col1 + col2 AS total, col3
Frequently, you might also see these statements without the AS statement. Each of the above could be written in the following way instead, and they would still produce the exact same results:

FROM tablename t1
JOIN tablename2 t2
and

SELECT col1 + col2 total, col3
Aliases for Columns in Resulting Table
While aliasing tables is the most common use case. It can also be used to alias the columns selected to have the resulting table reflect a more readable name.

Example:

Select t1.column1 aliasname, t2.column2 aliasname2
FROM tablename AS t1
JOIN tablename2 AS t2
The alias name fields will be what shows up in the returned table instead of t1.column1 and t2.column2

aliasname	aliasname2
example row	example row
example row	example row */

/* Questions
Provide a
table for all web_events associated
with account name of Walmart. There should be three columns. Be sure to include the primary_poc, time of the event, and the channel for each event. Additionally, you might choose to
add a fourth column to assure only Walmart events were chosen.

Provide a table that provides the region for each sales_rep along
with their associated accounts. Your final table should include three
columns:
the region name, the sales rep name, and the account name. Sort the accounts alphabetically
(A-Z) according to account name.

Provide the name for each region for every order, as well as the account name and the unit price they paid
(total_amt_usd/total) for the order. Your final table should have 3
columns:
region name, account name, and unit price. A few accounts have 0 for total, so I divided by
(total + 0.01) to assure not dividing by zero.
 */

SELECT accounts.primary_poc, web_events.occurred_at, web_events.channel, accounts.name
FROM accounts
    JOIN web_events
    ON web_events.account_id = accounts.id
WHERE name LIKE 'Walmart';

/* Or you can write the above in this fashion*/

SELECT a.primary_poc, w.occurred_at, w.channel, a.name
FROM web_events w
    JOIN accounts a
    ON w.account_id = a.id
WHERE a.name = 'Walmart';

SELECT r.name region, s.name rep, a.name account
FROM sales_reps s
    JOIN region r
    ON s.region_id = r.id
    JOIN accounts a
    ON a.sales_rep_id = s.id
ORDER BY a.name;

SELECT r.name region, a.name account, o.total_amt_usd/(o.total + 0.01) unit_price
FROM region AS r
    JOIN sales_reps s
    ON s.region_id = r.id
    JOIN accounts a
    ON a.sales_rep_id = s.id
    JOIN orders o
    ON o.account_id = a.id;