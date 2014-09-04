module Zuck
  class AdCampaign < RawFbObject
    # https://developers.facebook.com/docs/reference/ads-api/adset

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

    update_fields :name

    parent_object :ad_account
    list_path     :adcampaigns
    connections   :ad_groups

  end
end
