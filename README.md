Project Overview
This Netflix Data Analysis Project is a complete end-to-end data engineering and analytics pipeline built using:
AWS S3 — to store the raw Netflix CSV datasets.
Snowflake — as the central data warehouse for data storage and querying.
DBT (Data Build Tool) — for modular, version-controlled SQL transformations and analytics.
The goal is to simulate a real-world enterprise data workflow — from raw data ingestion to clean, modeled, and tested analytical outputs that drive decision-making.
Press enter or click to view image in full size

🧱 Step 1: Data Ingestion — AWS to Snowflake
We start by setting up a Snowflake user and stage, connecting directly to the AWS S3 bucket that holds our CSV data.
Using the Snowflake COPY INTO command, we load all raw Netflix data into Snowflake’s raw schema — efficiently and securely.
AWS to Snowflake pipeline:
Press enter or click to view image in full size

⚙️ Step 2: Initializing the DBT Project
Once the raw data is in Snowflake, the next step is data transformation using DBT.
DBT models (SQL files) define how raw data should be cleaned, enriched, and organized.
DBT initialization:
Press enter or click to view image in full size

DBT follows a layered approach to model design:
Staging Layer (Bronze): Clean and standardize raw data.
Intermediate Layer (Silver): Apply business rules and joins.
Gold Layer: Create analytical models for dashboards and reports.
Views created by DBT appearing on Snowflake:
Press enter or click to view image in full size
Press enter or click to view image in full size
🪄 Step 3: Data Modeling and Materialization
Here we define dimension and fact tables in our development schema.
We also use DBT’s materializations to decide how models are built:
Views — store only SQL logic (no physical data).
Tables — persist transformed data.
Incremental models — only process new or changed data.
Raw movies table and DBT model views:
Press enter or click to view image in full size
Press enter or click to view image in full size
🔁 Step 4: Slowly Changing Dimensions (SCDs)
In real-world analytics, data changes — movie titles get updated, ratings evolve, or new tags appear.
To track these changes over time, we implemented Slowly Changing Dimensions (SCDs):
Type 1: Overwrite old data.
Type 2: Keep history with versioning and date ranges.
We used DBT snapshots to implement SCD2 with a surrogate key:
{{ dbt_utils.generate_surrogate_key(['user_id','movie_id','tag']) }} AS row_key
Snapshots in DBT for SCD2:
Press enter or click to view image in full size

This ensures analysts can study how user preferences evolve over time.
🔍 Step 5: Testing & Documentation
DBT includes robust data testing and documentation features.
We built tests to ensure:
Relevance scores are always positive.
IDs are never null.
Referential integrity is maintained.
Then we generated interactive documentation and lineage graphs using:
dbt docs generate
dbt docs serve
DBT documentation and lineage:
Press enter or click to view image in full size
Press enter or click to view image in full size
🧩 Step 6: Using Macros, Seeds & Sources
We used macros (reusable SQL code blocks) to eliminate redundancy.
Seed files were created for static reference data and loaded using dbt seed.
The sources.yml file tracks all tables, ensuring full data traceability.
Macros in DBT:
Press enter or click to view image in full size

📈 Step 7: Analysis & Insights
The final step: transforming structured data into meaningful insights.
Get Codegner’s stories in your inbox
Join Medium for free to get updates from this writer.

Subscribe
Using the Gold layer, we created models that answer key analytical questions:
🎭 How do ratings vary across genres?
👥 How engaged are users (number of ratings per user)?
🕰️ What are the trends in movie releases over time?
🏷️ Which tags are most relevant to top-rated movies?
🎬 Which are the top 10 movies per genre?
📆 How do ratings vary month-to-month?
Sample analysis models:
Press enter or click to view image in full size

📊 Visualization & Insights — Turning Data into Stories:
Once all data transformations were complete in DBT and the movie_analysis model was materialized on Snowflake, I visualized the results using SQL queries and simple charts.
The key query analyzed was:
SELECT movie_title, average_rating, total_ratings 
FROM MOVIELENS.DEV.movie_analysis
ORDER BY average_rating DESC
LIMIT 20;
This query retrieves the top 20 movies ranked by average rating, along with their total number of ratings.
🎬 Chart 1: Movie Title vs. Average Rating
📊 Chart Type: Horizontal Bar Chart
🧠 Purpose: To compare the highest-rated movies and understand audience satisfaction.
By plotting movie titles on the Y-axis and average ratings on the X-axis, we can quickly spot which films are consistently loved by viewers.
Key Findings:
A handful of movies maintain exceptionally high ratings (above 4.5), suggesting strong audience approval.
Some titles, though older or niche, still score highly — showing the lasting emotional impact of certain genres or stories.
The visualization helps identify quality over popularity, highlighting critically acclaimed titles even if they weren’t blockbusters.
Why It Matters:
Businesses like Netflix use similar analysis to improve content recommendations and understand what type of movies resonate most with specific user segments.
It’s the foundation for personalized user experiences and smarter content investments.
Movie Title vs Average Rating:
Press enter or click to view image in full size

🍿 Chart 2: Movie Title vs. Total Ratings
📊 Chart Type: Horizontal Bar Chart
🧠 Purpose: To reveal which movies received the most audience engagement (number of ratings).
This chart plots movie titles on the Y-axis and total ratings on the X-axis, showing how widely each film was watched and rated.
Key Findings:
Popular titles like mainstream blockbusters dominate in total rating counts.
Some highly rated movies have fewer total ratings, meaning they are critically strong but niche in audience reach.
It helps separate “most loved” from “most watched.”
Why It Matters:
This insight helps platforms or studios balance popularity vs. quality.
For example:
A movie with millions of ratings but an average score of 3.5 might be good for engagement.
A movie with fewer ratings but an average score of 4.8 signals a cult favorite worth promoting to similar audiences.
Movie Title vs Total Ratings:
Press enter or click to view image in full size

🧩 Bringing It Together
When combined, these two charts tell a complete story:
Average Rating reveals viewer satisfaction (quality).
Total Ratings reveals viewer engagement (popularity).
Together, they provide a balanced metric for decision-making — the same logic streaming platforms use to:
Refine recommendation algorithms.
Plan marketing campaigns.
Decide which genres or directors to invest in next.
In short, this visualization bridges the gap between data and decisions — turning raw numbers into meaningful insights that guide both business strategy and user experience optimization.
Real-World Impact
This project mirrors how data teams in real businesses operate:
Retail: to track purchases and customer lifetime value.
Finance: to monitor transactions and detect anomalies.
Healthcare: to analyze patient records and treatment outcomes.
It’s a demonstration of how raw data becomes actionable intelligence through automation, version control, and scalable transformation tools.
🧠 Key Learnings
Built a fully functional data pipeline from AWS → Snowflake → DBT.
Designed robust incremental, ephemeral, and snapshot models.
Implemented data testing, lineage tracking, and documentation.
Generated business insights ready for visualization and storytelling.
