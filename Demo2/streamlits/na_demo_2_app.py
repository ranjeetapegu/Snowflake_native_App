# Import python packages
import streamlit as st
import pandas as pd
import numpy as np
from snowflake.snowpark.context import get_active_session

# Write directly to the app
st.title("Welcome to Snowflake Native App Demo")
st.write(
   """The following data is from the name_address table in the application package.
      However, the Streamlit app queries this data from a view called src.name_address_view 
   """
)

# Get the current credentials
session = get_active_session()

#  Create an example data frame
data_frame_1 = session.sql("SELECT * FROM src.name_address_view ;")
data_frame_2 = session.sql("SELECT * FROM src.movie_links_view  ;")
# Execute the query and convert it into a Pandas data frame
queried_data_1 = data_frame_1.to_pandas()
queried_data_2 = data_frame_2.to_pandas()
# Display the Pandas data frame as a Streamlit data frame.
st.subheader("Underlying Name and address data")
st.dataframe(queried_data_1, use_container_width=True)

st.subheader("Movie Link")
st.dataframe(queried_data_2 , use_container_width=True)


## adding some random chart 

chart_data = pd.DataFrame(np.random.randn(20, 3), columns=["a", "b", "c"])
st.subheader("Sample chart")
st.bar_chart(chart_data)