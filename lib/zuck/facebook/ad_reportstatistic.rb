module Zuck
  class AdReportStatistic < RawFbObject
    # https://developers.facebook.com/docs/reference/ads-api/adreportstats

    fields :id,
           :account_id,
           :adgroup_id,
           :impressions,
           :clicks,
           :spend,
           :cpc,
           :actions,
           :date_start,
           :date_stop

    parent_object :ad_account
    list_path     :reportstats
  end
end
