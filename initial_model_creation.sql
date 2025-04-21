-- Create the initial logistic regression model to predict if a visitor will buy on a return visit.
CREATE OR REPLACE MODEL `ecommerce.customer_classification_model`
OPTIONS
  (model_type='logistic_reg',
   labels = ['will_buy_on_return_visit'])
AS
SELECT
  * EXCEPT(fullVisitorId)
FROM
  (SELECT
      fullVisitorId,
      IFNULL(totals.bounces, 0) AS bounces,
      IFNULL(totals.timeOnSite, 0) AS time_on_site
  FROM
      `data-to-insights.ecommerce.web_analytics`
  WHERE
      totals.newVisits = 1
      AND date BETWEEN '20160801' AND '20170430') -- Train on the first 9 months
JOIN
  (SELECT
      fullvisitorid,
      IF(COUNTIF(totals.transactions > 0 AND totals.newVisits IS NULL) > 0, 1, 0) AS will_buy_on_return_visit
  FROM
      `data-to-insights.ecommerce.web_analytics`
  GROUP BY fullvisitorid)
USING (fullVisitorId);

