module Zuck
  class AdCampaign < RawFbObject

    # The [fb docs](https://developers.facebook.com/docs/reference/ads-api/adaccount/)
    # were incomplete, so I added here what the graph explorer
    # actually returned.
    fields :id,
           :name,
           :account_id,
           :campaign_status,
           :daily_budget,
           :lifetime_budget,
           :daily_imps,
           :created_time,
           :start_time,
           :end_time,
           :updated_time

    parent_object :ad_account
    list_path     :adcampaigns
    connections   :ad_groups

  end
end
