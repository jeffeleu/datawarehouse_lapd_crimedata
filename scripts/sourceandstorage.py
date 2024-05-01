!pip install azure-storage-blob

from google.colab import drive #import csv in google drive
drive.mount("/drive")

import pandas as pd #import libraries
import numpy as np
import json
from azure.storage.blob import BlobServiceClient, BlobClient, ContainerClient #will be using azure storage
from io import StringIO

"""s1 -> gather -> decompress -> convert to tabular -> clean -> reformat -> consolidation -> transformation -> load"""

#create data frame
df_raw = pd.read_csv('drive_location_of_raw_data')
df_raw.head()
print(df_raw.columns)

df_raw.dropna()
df_raw.shape

df_raw.info()

#code for later transformation
df_cleaned = df_raw.copy() #creates a copy of df_raw to the variable df_cleaned, df_cleaned will be used to transform
#ex. of cleaning by removing rows
df_cleaned = df_raw.drop(columns= ['Part 1-2', 'Mocodes', 'Crm Cd 1', 'Crm Cd 2', 'Crm Cd 3', 'Crm Cd 4', 'Cross Street'])
df_cleaned.info()

#store dataframe to azure storage
CONNECTION_STRING_AZURE_STORAGE = 'my_connection_string'
CONTAINER_AZURE = 'my_container'

blob_name = "my_blob_name"

#convert Dataframe to CSV (although data already in csv)
output = StringIO()
df_raw.to_csv(output, index = False)
data = output.getvalue()
output.close()

#create the BlobServiceClient object
blob_service_client = BlobServiceClient.from_connection_string(CONNECTION_STRING_AZURE_STORAGE)

#get a blob client using the container name and blob name
blob_client = blob_service_client.get_blob_client(CONTAINER_AZURE, blob = blob_name)

#upload the csv data
blob_client.upload_blob(data, overwrite = True)

print(f"Uploaded {blob_name} to Azure Blob Storage in container {CONTAINER_AZURE}.")
