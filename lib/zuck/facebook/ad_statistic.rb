module Zuck
  class AdStatistic < RawFbObject
    # https://developers.facebook.com/docs/reference/ads-api/adstatistics

    fields :id,
           :account_id,
           :impressions,
           :clicks,
           :spent,
           :social_impressions,
           :social_clicks,
           :social_spent,
           :unique_impressions,
           :social_unique_impressions,
           :unique_clicks,
           :social_unique_clicks,
           :actions,
           :inline_actions,
           :start_time,
           :end_time

    parent_object :ad_group
    list_path     :adgroupstats
  end
end
