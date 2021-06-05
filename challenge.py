#!/usr/bin/env python
# coding: utf-8

# ## Identifying Outliers using Standard Deviation

# In[100]:


# Initial imports
import pandas as pd
import numpy as np
import random
from sqlalchemy import create_engine


# In[20]:


# Create a connection to the database
engine = create_engine("postgresql+psycopg2://postgres:Fintech2021!@localhost:5432/fraud_detection")
query = """
SELECT 
ch.holder_id as cardholder,
cc.card_number number,
m.merchant_name as merchant,
t.transaction_datetime as hour,
t.amount as amount 
FROM card_holder ch
JOIN credit_card cc ON ch.holder_id = cc.cardholder_id
JOIN transaction t ON t.card_number = cc.card_number 
JOIN merchant m ON t.merchant_id = m.merchant_id
JOIN merchant_category mc ON m.merchant_category_id = m.merchant_category_id
group by cc.card_number, ch.holder_id, m.merchant_name,t.transaction_datetime,t.amount
order by t.amount
"""
transactions_df = pd.read_sql(query, engine)
transactions_df.head()


# In[50]:


# Write function that locates outliers using standard deviation 
def outliers(data_df):
    return pd.DataFrame(data_df[data_df > data_df.mean() + 3*data_df.std()])


# In[86]:


transactions_df.dropna()


# In[87]:


transactions_df.shape


# In[88]:


# Find anomalous transactions for 3 random card holders
rand_card_holders = np.random.randint(1,95,3)
for id in rand_card_holders:
    df = transactions_df.loc[transactions_df['cardholder']==id, 'amount']
    if len(outliers(df)) == 0:
        print(f"Card holder {id} has no outlier transactions.")
    else:
        print(f"Card holder {id} has outlier transactions as below:\n{outliers(df)}.")
    


# ## Identifying Outliers Using Interquartile Range

# In[98]:


# Write a function that locates outliers using interquartile range
def outliers_iqr(data_df):
    if data_df.empty:
        return []
    else:
        IQR_threshold = np.quantile(data_df, .75)+(np.quantile(data_df, .75)-np.quantile(data_df, .25))*1.5
        return pd.DataFrame(data_df[data_df > IQR_threshold])


# In[99]:


# Find anomalous transactions for 3 random card holders
for id in rand_card_holders:
    df2 = transactions_df.loc[transactions_df['cardholder']==id, 'amount']
    if len(outliers_iqr(df2)) == 0:
        print(f"Card holder {id} has no outlier transactions.")
    else:
        print(f"Card holder {id} has outlier transactions as below:\n{outliers_iqr(df2)}.")

