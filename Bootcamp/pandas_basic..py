import pandas as pd
## loading dataset
df = pd.read_csv("Sample - Superstore.csv")
print("Dataset Loaded")

## display top 5 rows
print(df.head(5))

## checking missing values
print("Missing Values\n", df.isnull().sum())

## filter rows sales>1000
print(df[df['Sales']>1000])

## calculate total sales
print(df.groupby('Category')['Sales'].sum())

## profit = sales - cost
df['Cost'] = df['Sales'] - df['Profit']
df['New_Profit'] = df['Sales'] - df['Cost']
print("New_Profit:\n", df[['Sales', 'Cost', 'Profit']].head())

## sort by highest sales
df_sorted = df.sort_values(by='Sales', ascending=False)
print("Sorted Values\n", df_sorted.head())

## Save file
df.to_csv("cleaned_data.csv", index=False)
print("File saved")