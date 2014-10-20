module Zuck
  class AdCampaign < RawFbObject
    # https://developers.facebook.com/docs/reference/ads-api/adset

    @redownload = false #Facebook, you're drunk go home (redownload bug).

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

    update_fields :name,
                  :campaign_status

    parent_object :ad_account
    list_path     :adcampaigns
    connections   :ad_groups

  end
end
