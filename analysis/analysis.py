import pandas as pd

# =========================
# Load Dataset
# =========================
df = pd.read_excel("data/churn_data.xlsx")

# =========================
# Basic Overview
# =========================
print(df.head())
print("Shape:", df.shape)
print("Columns:", df.columns)

# =========================
# Data Info & Missing Values
# =========================
df.info()
print(df.isnull().sum())

# =========================
# Data Cleaning
# =========================
df['Total Charges'] = pd.to_numeric(df['Total Charges'], errors='coerce')
df['Total Charges'] = df['Total Charges'].fillna(0)

# =========================
# Churn Rate
# =========================
total_customers = len(df)
churned_customers = len(df[df['Churn Label'] == 'Yes'])
churn_rate = (churned_customers / total_customers) * 100

print("Total Customers:", total_customers)
print("Churn Rate: {:.2f}%".format(churn_rate))

# =========================
# Feature Engineering
# =========================
df['Customer Type'] = df['Tenure Months'].apply(lambda x: 'New' if x <= 12 else 'Old')

df['Charge Group'] = pd.cut(df['Monthly Charges'],
                           bins=[0, 35, 70, 120],
                           labels=['Low', 'Medium', 'High'])

# =========================
# Analysis
# =========================

# Churn distribution
print(df['Churn Label'].value_counts())

# Churn by customer type
print(df.groupby('Customer Type')['Churn Label'].value_counts(normalize=True).unstack() * 100)

# Churn by charge group
print(df.groupby('Charge Group')['Churn Label'].value_counts(normalize=True).unstack() * 100)

# Churn by contract
print(df.groupby('Contract')['Churn Label'].value_counts(normalize=True).unstack() * 100)

# Avg Monthly Charges
print(df.groupby('Churn Label')['Monthly Charges'].mean())

# Top churn reasons
print(df[df['Churn Label'] == 'Yes']['Churn Reason'].value_counts().head(10))