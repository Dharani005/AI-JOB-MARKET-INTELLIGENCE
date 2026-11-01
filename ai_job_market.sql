-- create database ai_job_market;
USE ai_job_market;
drop table jobs;
CREATE TABLE jobs (
    job_id VARCHAR(20),
    job_title VARCHAR(255),
    salary_usd DOUBLE,
    salary_currency VARCHAR(20),
    experience_level VARCHAR(50),
    employment_type VARCHAR(50),
    company_location VARCHAR(100),
    company_size VARCHAR(50),
    employee_residence VARCHAR(100),
    remote_ratio INT,
    required_skills TEXT,
    education_required VARCHAR(100),
    years_experience DOUBLE,
    industry VARCHAR(100),
    posting_date DATE,
    application_deadline DATE,
    job_description_length INT,
    benefits_score DOUBLE,
    company_name VARCHAR(255)
);

show tables;

set global local_infile=1;

LOAD DATA LOCAL INFILE 'C:/Users/Hp/Desktop/ai_job_dataset2.csv'
INTO TABLE jobs
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM jobs LIMIT 5;

-- DELETE FROM jobs
-- WHERE job_id = 'job_id';

-- Total Jobs
SELECT COUNT(*) AS total_jobs
FROM jobs;

-- Average Salary
SELECT ROUND(AVG(salary_usd),2) AS avg_salary
FROM jobs;

-- Highest Paying Roles
SELECT job_title,
       ROUND(AVG(salary_usd),2) AS avg_salary
FROM jobs
GROUP BY job_title
ORDER BY avg_salary DESC
LIMIT 10;

-- Most Common Job Roles
SELECT job_title,
       COUNT(*) AS total_jobs
FROM jobs
GROUP BY job_title
ORDER BY total_jobs DESC
LIMIT 10;

-- Remote Job Analysis
SELECT remote_ratio,
       COUNT(*) AS total_jobs
FROM jobs
GROUP BY remote_ratio
ORDER BY remote_ratio DESC;

-- Top Hiring Locations
select company_location,count(*) as sum
from jobs 
group by company_location
order by sum desc
limit 5;

-- Experience vs Salary
select years_experience,round(avg(salary_usd),2) as avg_salary from jobs group by years_experience order by years_experience desc;

-- Top Hiring Companies
SELECT company_name,
       COUNT(*) AS total_jobs
FROM jobs
GROUP BY company_name
ORDER BY total_jobs DESC
LIMIT 10;

-- Salary Ranking
SELECT job_title,
       company_name,
       salary_usd,
       RANK() OVER(ORDER BY salary_usd DESC) AS salary_rank
FROM jobs;

-- Average Salary by Company Size
SELECT company_size,
       ROUND(AVG(salary_usd),2) AS avg_salary
FROM jobs
GROUP BY company_size
ORDER BY avg_salary DESC;