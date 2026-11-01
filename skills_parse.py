import pandas as pd

df = pd.read_csv("ai_job_dataset.csv")

# Explode skills into individual rows
df['skill'] = df['required_skills'].str.split(', ')
skills_df = df.explode('skill')
skills_df['skill'] = skills_df['skill'].str.strip()

# Add salary and experience for analysis
skills_export = skills_df[['job_id', 'skill', 'salary_usd', 
                            'experience_level', 'industry', 
                            'remote_ratio', 'job_title']].copy()

# Skill frequency
print("Top 20 Skills:")
print(skills_df['skill'].value_counts().head(20))

# Skill salary premium
skill_salary = skills_df.groupby('skill')['salary_usd'].mean().sort_values(ascending=False)
print("\nTop 10 Highest Paying Skills:")
print(skill_salary.head(10))

# Save for Power BI
skills_export.to_csv("skills_exploded.csv", index=False)
print("\nSaved as skills_exploded.csv!")