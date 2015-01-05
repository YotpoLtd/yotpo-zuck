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
           :targeting,
           :tracking_specs,
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
                  :tracking_specs

    parent_object :ad_campaign
    list_path     :adgroups
    connections   :ad_creatives

    def get_ad_statistics(start_time, graph = Zuck.graph)
      adgroup_ids = [id]
      graph_data = graph.get_object("act_#{account_id}/adgroupstats?adgroup_ids=#{adgroup_ids.to_json}&start_time=#{start_time}", fields: Zuck::AdStatistic.fields.compact.join(','))
      if (graph_data && graph_data.size > 0)
        Zuck::AdStatistic.new(graph, graph_data[0])
      else
        return nil
      end
    end
  end
end
