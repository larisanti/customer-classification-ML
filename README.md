# BigQuery ML for Customer Classification

[![BigQuery](https://img.shields.io/badge/BigQuery-blue?logo=google-cloud-platform&logoColor=white)](https://cloud.google.com/bigquery)
[![ML](https://img.shields.io/badge/ML-orange?logo=google-cloud&logoColor=white)](https://cloud.google.com/bigquery/docs/reference/standard-sql/bigqueryml-syntax)

This project, completed as part of the Machine Learning Engineer course by Google, applies BigQuery ML to build and evaluate machine learning models for customer classification. The models aim to predict whether new visitors to the Google Merchandise Store will return to make a purchase.

## Project Structure

This repository contains the following SQL files:

```markdown
├── initial_model_creation.sql     # creates the initial logistic regression model
├── initial_model_evaluation.sql   # evaluates the initial logistic regression model
├── improved_model_creation.sql    # creates a logistic regression model with improved features
├── improved_model_evaluation.sql  # evaluates the improved logistic regression model
├── prediction_query.sql           # predicts future purchases using the final model
└── README.md                      
```

## Implementation

The project follows these steps:

1.  **Initial Model Creation (`initial_model_creation.sql`):**
    * A logistic regression model (`ecommerce.customer_classification_model`) is created.
    * The model predicts `will_buy_on_return_visit` based on `bounces` and `time_on_site` for new visitors.
    * Data from '20160801' to '20170430' is used for training.

2.  **Initial Model Evaluation (`initial_model_evaluation.sql`):**
    * The `ML.EVALUATE` function assesses the performance of the `ecommerce.customer_classification_model`.
    * Evaluation is performed on data from '20170501' to '20170731'.

3.  **Improved Model Creation (`improved_model_creation.sql`):**
    * A new logistic regression model (`ecommerce.improved_customer_classification_model`) is created.
    * This model includes additional features: `latest_ecommerce_progress`, `trafficSource.source`, `trafficSource.medium`, `channelGrouping`, `device.deviceCategory`, and `geoNetwork.country`.
    * Data from '20160801' to '20170430' is used for training.

4.  **Improved Model Evaluation (`improved_model_evaluation.sql`):**
    * The `ML.EVALUATE` function assesses the performance of the `ecommerce.improved_customer_classification_model`.
    * Evaluation is performed on data from '20170501' to '20170731'.

5.  **Prediction Query (`prediction_query.sql`):**
    * The `ML.PREDICT` function uses the `ecommerce.finalized_classification_model` to predict `will_buy_on_return_visit`.
    * Predictions are made for data from '20170801' to '20170831'.  This identifies new visitors in the last month who are most likely to purchase.

## How to Run

To reproduce this project, you will need:

1.  A Google Cloud Platform account.
2.  Access to BigQuery.
3.  The `data-to-insights.ecommerce.web_analytics` public dataset in BigQuery.
4. Execute the SQL files in the BigQuery console.
