import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

df = pd.read_csv(r"F:\Data analysis\Projects\Customer churn\WA_Fn-UseC_-Telco-Customer-Churn.csv")


#data cleaning
df = df.drop_duplicates()

# df.rename(columns = {"customerID":"Customer ID", "gender":"Gender", "SeniorCitizen":"Senior Citizen", "tenure":"Tenure"}, inplace = True)  #rename columns one by one

df.columns = ["Customer ID", "Gender", "Senior Citizen", "Partner", "Dependents", "Tenure(in Months)", "Phone Service", "Multiple Lines", "Internet Service", 
              "Online Security", "Online Backup", "Device Protection", "Tech Support", "Streaming TV", "Streaming Movies", "Contract", 
              "Paperless Billing", "Payment Method", "Monthly Charges", "Total Charges", "Churn"]     #rename all columns at once

# print(df.columns)

df["Online Security"] = df["Online Security"].replace({"No internet service":"No"})    #replace values only in "Online Security column"
# print(df["Online Security"].head(17))

cols = [ "Online Backup", "Device Protection", "Tech Support", "Streaming TV", "Streaming Movies"]   
df[cols] = df[cols].replace({"No internet service" : "No"})     #replace values in all columns mentioned in list
# print(df["Online Backup"].head(15)) 

df["Total Charges"] = pd.to_numeric(df["Total Charges"], errors = "coerce")     #pd.to_numeric -> converts values to numbers wherever possible,
                                                                                #errors = "coerce" -> If a value cannot be converted to a number, pandas replaces it with NaN (missing value).

churn_rate = df["Churn"].value_counts(normalize = True)*100       #value_counts -> counts no. of yes and no in the churn column
                                                                  #normalize = True -> converts the no. of yes and no into proportions/fractions
                                                                  #*100 -> converts the fractions into percentages
print((churn_rate).round(2))


#churn rate bar plot
# ax = churn_rate.plot(kind = "bar")
# plt.xticks(rotation = 0)
# plt.ylabel("Percentage")
# plt.title("Churn Rate")
# for container in ax.containers:        #to show data labels on the bar plot
#     ax.bar_label(container, fmt = "%.2f%%")
# plt.show()

df["Cutomer Lifetime Value"] = df["Monthly Charges"]*df["Tenure(in Months)"]   #calculates revenue a customer has generated for the company in his lifetime usage of the company's service
# print((df["Cutomer Lifetime Value"]).round(2))

bins = [0, 12, 24, 48, 72]
labels = ["0-1 years", "1-2 years", "2-4 years", "4-6 years"]
df["Tenure Group"] = pd.cut(df["Tenure(in Months)"], bins = bins, labels = labels)   #pd.cut() -> takes a numeric column and converts it into categories based on the specified bins.
# print((df.groupby("Tenure Group")["Churn"].value_counts(normalize = True)*100).round(2))   #helps to visualize customers from which tenure are more likely to churn

#EDA
# sns.countplot(data = df, x = "Churn")
# plt.show()

contract_churn = pd.crosstab(df["Contract"],df["Churn"],normalize="index")*100       #pd.crosstab() -> Creates a cross-tabulation (contingency table) between two columns.
                                                                                     #normalize = "index" -> Normalizes each row so that the percentages in a row add up to 100%
                                                                                     #*100 -> converts proportion to percentages
# print((contract_churn).round(2))

# contract_churn.plot(kind = "bar")
# plt.xticks(rotation = 0)
# plt.title("Churn rate by contract type")
# plt.ylabel("Churn rate")
# plt.show()

# sns.countplot(data = df, x = "Contract", hue = "Churn")      #Churn rate w.r.t contract
# plt.show()

# sns.boxplot(data = df, y = "Tenure(in Months)", x = "Churn", hue = "Churn")     #Churn rate w.r.t tenure
# plt.show()

# sns.boxplot(data = df, x = "Churn", y = "Monthly Charges", hue = "Churn")     #Churn rate w.r.t Monthly charges
# plt.show()

# sns.countplot(data = df, x = "Payment Method", hue = "Churn")     #Churn rate w.r.t Payment Method
# plt.show()

# sns.countplot(data = df, x = "Internet Service", hue = "Churn")     #Churn rate w.r.t Internet service
# plt.show()

# sns.heatmap(df.corr(numeric_only=True), annot = True, cmap = "coolwarm")
# plt.xticks(rotation = 0)
# plt.show()

monthly_revenue_lost = df[df["Churn"] == "Yes"]["Monthly Charges"].sum()   #monthly revenue lost due to churn
# print((monthly_revenue_lost).round(2))

total_revenue_lost = df.loc[df["Churn"]=="Yes", "Total Charges"].sum()    #total revenue lost due to churn -> this gives a more accurate picture of revenue loss for company
# print((total_revenue_lost).round(2))

# df.to_excel(r"F:\Data analysis\Customer churn\Final project.xlsx", index = False)