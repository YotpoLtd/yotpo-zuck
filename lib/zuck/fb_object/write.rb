module Zuck
 module FbObject
   module Write
    def self.included(base)
      base.extend(ClassMethods)
    end

    def save
      self.class.raise_if_read_only

      data_fields = @hash_delegator_hash.select { |k,v| self.class.update_fields.include?(k)}
      data = data_fields.merge(redownload: 1) # Tell facebook to return updated data
      data = data.stringify_keys

      # Don't post ids, because facebook doesn't like it
      data = data.keep_if{ |k,v| k != 'id' }

      # Update on facebook
      result = post(graph, path, data)

      if (result.is_a?(Hash) && result.has_key?('data'))
        # The data is nested by name and id, e.g.
        #
        #     "campaigns" => { "12345" => "data" }
        #
        # Since we only put one at a time, we'll fetch this like that.
        data = result['data'].values.first.values.first
        # Update and return
        set_data(data)
        return result['result']
      else
        reload
        return result
      end
    end

    def destroy
      self.class.destroy(graph, path)
    end


    module ClassMethods

      def raise_if_read_only
        return unless read_only?
        raise Zuck::Error::ReadOnly.new("#{self} is read_only")
      end

      def create(graph, data, parent=nil, path=nil)
        raise_if_read_only
        p = path || parent.path

        # We want facebook to return the data of the created object
        data['redownload'] = 1 unless (@redownload && @redownload == false)

        # Create
        result = create_connection(graph, p, list_path, data)
        if (result.is_a?(Hash) && result.has_key?('data'))
          # The data is nested by name and id, e.g.
          #
          #     "campaigns" => { "12345" => "data" }
          #
          # Since we only put one at a time, we'll fetch this like that.
          data = result['data'].values.first.values.first
        else
          data = result
        end


        # Return a new instance
        new(graph, data, parent)
      end

      def destroy(graph, id)
        raise_if_read_only
        delete(graph, id)
      end

    end

   end
 end
end
