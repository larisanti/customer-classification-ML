-- Evaluate the performance of the initial logistic regression model.
SELECT
  *
FROM
  ML.EVALUATE(MODEL `ecommerce.customer_classification_model`,
    (SELECT
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
          AND date BETWEEN '20170501' AND '20170731') -- Evaluate on the next 3 months
    JOIN
      (SELECT
          fullvisitorid,
          IF(COUNTIF(totals.transactions > 0 AND totals.newVisits IS NULL) > 0, 1, 0) AS will_buy_on_return_visit
      FROM
          `data-to-insights.ecommerce.web_analytics`
      GROUP BY fullvisitorid)
    USING (fullVisitorId)));