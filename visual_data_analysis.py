#!/usr/bin/env python
# coding: utf-8

# # Fraudulent Transactions

# In[2]:


# Initial imports
import pandas as pd
import calendar
import plotly.express as px
import hvplot.pandas
from sqlalchemy import create_engine
import psycopg2


# In[ ]:





# In[3]:


# Create a connection to the database
#engine = create_engine("postgresql://postgres:postgres@localhost:5432/fraud_detection")
engine = create_engine("postgresql+psycopg2://postgres:Fintech2021!@localhost:5432/fraud_detection")
query = "select * from card_holder;"
holder_df = pd.read_sql(query,engine)
#holder_df.head()


# In[ ]:





# ## Data Analysis 1
# 
# The two most important customers of the firm may have been hacked. Verify if there are any fraudulent transactions in their history. For privacy reasons, you only know that their cardholder IDs are 2 and 18.

# In[ ]:





# In[4]:


# loading data for card holder 2 and 18 from the database
# Write the query
query = """
        SELECT 
        ch.holder_id as cardholder,
        t.transaction_datetime as hour,
        t.amount as amount 
        from transaction t 
        join credit_card cc on cc.card_number = t.card_number
        join card_holder ch on ch.holder_id = cc.cardholder_id 
        where ch.holder_id in (2,18);
        """

# Create a DataFrame from the query result. 
holder_count_df = pd.read_sql(query, engine)
holder_count_df.head()


# In[5]:


# Plot for cardholder 2
holder_2_df = holder_count_df[(holder_count_df['cardholder'] == 2)]
holder_2_plot = holder_2_df.hvplot.line(x='hour',y='amount',title='Card Holder 2')
holder_2_plot


# In[6]:


# Plot for cardholder 18
holder_18_df = holder_count_df[(holder_count_df['cardholder'] == 18)]
holder_18_plot = holder_18_df.hvplot.line(x='hour',y='amount',title='Card Holder 18')


# In[7]:


holder_18_plot


# In[8]:


# Combined plot for card holders 2 and 18
combined_plot = holder_2_plot * holder_18_plot
combined_plot.opts(title = "Transactions Analysis For Card Holder 2 and 18", show_legend = True)


# ### Conclusions 
# Credit card holder 18 is regularly taking bit money within an interval (>$1000).
# Therefore card holder 18 is riskier that credit card holder 2.

# ## Data Analysis 2
# 
# The CEO of the biggest customer of the firm suspects that someone has used her corporate credit card without authorization in the first quarter of 2018 to pay quite expensive restaurant bills. Again, for privacy reasons, you know only that the cardholder ID in question is 25.

# In[41]:


# loading data of daily transactions from jan to jun 2018 for card holder 25
# Write the query
query = """
        SELECT 
        date_part('month', t.transaction_datetime) as month, 
        date_part('day', t.transaction_datetime) as day, 
        t.amount as amount 
        FROM transaction t 
        JOIN credit_card AS c ON c.card_number = t.card_number 
        WHERE c.cardholder_id = 25 
        AND date_part('month', t.transaction_datetime) >= 1 
        AND date_part('month', t.transaction_datetime) <= 6;
        """
# Create a DataFrame from the query result. 
fraud25_df = pd.read_sql(query, engine)
fraud25_df.head()


# In[42]:


# loop to change the numeric month to month names # stack over flow 
fraud25_df['month'] = fraud25_df['month'].astype('int32')
fraud25_df['month'].dtypes
fraud25_df['month'] = fraud25_df['month'].apply(lambda x: calendar.month_name[x])


# In[43]:


fraud25_df.head()
columns = ["Month", "Day", "Amount"]
fraud25_df.columns = columns
fraud25_df.head()


# In[ ]:





# In[44]:


# Creating the six box plots using plotly express
fraud25_boxplot = px.box(
    fraud25_df,
    x='Month',
    y='Amount',
    title = "Month Transactions Analysis for Cardholder 25",
    color = 'Month',
    height = 500,
    width = 1000
)
fraud25_boxplot


# #### Conclusions 
# Card holder 25 is quite alarming. The majority of his or her transactions are of small amounts, but almost every month there is big spending over $1000.

# In[ ]:





# In[ ]:




