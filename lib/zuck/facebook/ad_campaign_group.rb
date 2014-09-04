module Zuck
  class AdCampaignGroup < RawFbObject
    fields :id,
           :account_id,
           :name,
           :buying_type,
           :campaign_group_status,
           :objective,
           :spend_cap,
           :topline_id,
           :created_time,
           :start_time,
           :stop_time,
           :updated_time

    parent_object :ad_account
    list_path     :adcampaign_groups
    connections   :ad_groups
  end
end
