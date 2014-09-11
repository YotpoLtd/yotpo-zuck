require 'zuck/facebook/ad_creative'

module Zuck
  class AdGroup < RawFbObject
    # https://developers.facebook.com/docs/reference/ads-api/adgroup

    fields :id,
           :name,
           :account_id,
           :adgroup_review_feedback,
           :adgroup_status,
           :bid_type,
           :bid_info,
           :campaign_id,
           :campaign_group_id,
           :conversion_specs,
           :creative_ids,
           :creative,
           :failed_delivery_checks,
           :targeting,
           :tracking_specs,
           :view_tags,
           :created_time,
           :updated_time

    update_fields :name,
                  :adgroup_status,
                  :bid_type,
                  :bid_info,
                  :conversion_specs,
                  :creative,
                  :objective,
                  :targeting,
                  :tracking_specs,
                  :view_tags,
                  :view_tags

    parent_object :ad_campaign
    list_path     :adgroups
    connections   :ad_creatives
  end
end
