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
           :created_time,
           :start_time,
           :end_time,
           :updated_time

    update_fields :name,
                  :campaign_status

    parent_object :ad_account
    list_path     :adcampaigns
    connections   :ad_groups

    def get_statistics(start_time, end_time, graph = Zuck.graph)
      graph_data = graph.get_object("act_#{account_id}/adcampaignstats?campaign_ids=#{[id].to_json}&start_time=#{start_time}&end_time=#{end_time}")
      if (graph_data && graph_data.size > 0)
        Zuck::AdStatistic.new(graph, graph_data[0])
      else
        return nil
      end
    end
  end
end
