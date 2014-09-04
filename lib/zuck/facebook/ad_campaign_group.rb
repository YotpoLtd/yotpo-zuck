module Zuck
  class AdCampaignGroup < RawFbObject
    # https://developers.facebook.com/docs/reference/ads-api/adcampaign

    fields :id,
           :name,
           :account_id,
           :objective,
           :buying_type,
           :campaign_group_status,
           :spend_cap,
           :topline_id,
           :created_time,
           :start_time,
           :stop_time,
           :updated_time

    update_fields :name, :objective, :campaign_group_status

    parent_object :ad_account
    list_path     :adcampaign_groups
    connections   :ad_groups, :ad_campaigns
  end
end
