# Data Warehousing of LAPD Crime Data

## Data Explanation
The data comes from an inital reporting of a crime to law enforcement (either from emergency phone calls (911), visits to the police station, or online reporting, etc) in the city of Los Angeles. Law enforcement officers or operators collect information about the reported crime such as the type of crime, location, time and date of occurrence, descriptions of suspects or victims. The information is then classified and documented (according to the data source, the original crime reports were typed on paper). The provided dataset is a transcribed version of the original paper documentation.

## Sourcing 

To source the data, I went to catalog.data.gov and chose a data set that piqued my interest. I chose 'Crime Data from 2020 to Present' from the LAPD. To get familiar with the data, I found where the data comes from and located the data dictionary (created excel file to store it) to understand the purpose/meaning of the respective data elements. I then wrote a script that utilizes pandas and numpy to gather the data. The script reads the data, creates a data frame, and shows the column and shape. 

## Storing

To store the data, I utilized Microsoft Azure Storage. On Microsoft Azure Storage, I created a resource group and a container within it to house data. To upload my sourced data to Azure, I updated my sourcing script to use the classes, BlobServiceClient, BlobClient, and ContainerClient from azure.storage.blob. The classes from the Azure library allows me to establish a connection, access the appropriate container and blob, and upload the data efficiently.

## Modeling

To model the data, I identified the facts and dimensions. The fact table consists of foreign keys that reference the dimension tables. The dimensions identified for the data warehouse are as follows: Crime, Premise, Victim, Datetime, Location, and Status. Afterwards, I employed DBSchema to visualize and construct the database system. Following this, I saved the SQL script generated by my model for data warehousing. 

## Extract, Transform, Load

To start, I isntalled the following:

azure-storage-blob - for data in storage

pyarrow - working with data and dataframes

psycopg2 sqlalchemy - interact with postgresql
  
  and used these libraries for manipulating data, transforming, and loading: 

import pandas as pd 

import numpy as np

import json

from azure.storage.blob import BlobServiceClient, BlobClient, ContainerClient

from io import StringIO

from datetime import datetime 

from math import ceil

import datetime

import calendar

from sqlalchemy import create_engine


After creating a dataframe from utilizing json and retrieving container client with azure, I started my transformation. For the transformation, I corrected the data of 'Premis Cd' to 'Int64' as it has no decimal values. I also combined "DATE OCC" and "TIME OCC" to create "DATETIME OCC" for simplicity. Further, I dropped the columns, 'DR_NO', 'Date Rptd', 'DATE OCC', 'TIME OCC', 'AREA', 'Rpt Dist No','Part 1-2','Mocodes', 'Weapon Used Cd', 'Weapon Desc','Crm Cd 1', 'Crm Cd 2', 'Crm Cd 3', 'Crm Cd 4', and 'Cross Street' as I will not be needing them for the data warehouse.

I then start the data mapping of the dimensions and fact table. Each table is given a data map relevant to it, its contents ordered, and turned into a dataframe. 

When the fact and dimension dataframes are completed, I created an Azure Database for Postgresql servers.
I took the database url and created a sqlalchemy engine to push the data into my data warehouse using DataGrip.
Before loading the data, I used the sql scripts from my data model to structure the data warehouse in DataGrip.
Once all the data was loaded in, I was able to further analyze and visualize the data leveraging Power BI.

## Data Visualization on Power BI

[PowerBI Link](https://cuny907-my.sharepoint.com/:u:/g/personal/jeffery_liu02_login_cuny_edu/EUNAHHHGcXVAgov9Ob07UtcBeBkH69n87BlrPtuZTGkWPw?e=mbavx3)

Bar Chart Comparing Average Victim by Area

![bar_chartof_avg_vict_by_area](https://github.com/jeffeleu/DataWarehouse_LAPD_Crime__Data/assets/160162018/d3c0133b-6d4f-4464-87dd-a14fe24368ae)

Line Chart Showing the Number of Crimes by Year

![linechartofnumberofcrimesbyyear](https://github.com/jeffeleu/DataWarehouse_LAPD_Crime__Data/assets/160162018/568517aa-35fc-45f4-b5bb-3dba4596b0be)

Map Locating Crimes with Latitude and Longitude

![latlon](https://github.com/jeffeleu/DataWarehouse_LAPD_Crime__Data/assets/160162018/4b698ed9-49f1-4a1f-8a19-003a0bdad79e)

Pie Chart Showing Crimes by Description

![piechartofcrimesbydescr](https://github.com/jeffeleu/DataWarehouse_LAPD_Crime__Data/assets/160162018/c2dbef8e-8253-4ab4-8032-99b41994f20b)

## Sources
[LAPD Crime Data](https://catalog.data.gov/dataset/crime-data-from-2020-to-present)

[Data Dictionary](https://data.lacity.org/Public-Safety/Crime-Data-from-2020-to-Present/2nrs-mtv8/about_data)
